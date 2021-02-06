#!/bin/bash

set -e

function getCurrentDir() {
    local current_dir="${BASH_SOURCE%/*}"
    if [[ ! -d "${current_dir}" ]]; then current_dir="$PWD"; fi
    echo "${current_dir}"
}

function includeDependencies() {
    # shellcheck source=./setupLibrary.sh
    source "${current_dir}/setupLibrary.sh"
}

current_dir=$(getCurrentDir)
includeDependencies
output_file="output.log"

function main() {
    read -rp "Enter the username of the new user account:" username

    promptForPassword

    # Run setup functions
    trap cleanup EXIT SIGHUP SIGINT SIGTERM

    addUserAccount "${username}" "${password}"

    read -rp $'Paste in the public SSH key for the new user:\nHint: cat ~/.ssh/id_rsa.pub\n' sshKey
    echo 'Running setup script...'
    logTimestamp "${output_file}"

    # Use exec and tee to redirect logs to stdout and a log file at the same time 
    # https://unix.stackexchange.com/a/145654
    exec > >(tee -a "${output_file}") 2>&1
    disableSudoPassword "${username}"
    addSSHKey "${username}" "${sshKey}"
    changeSSHConfig
    setupUfw

    if ! hasSwap; then
        setupSwap
    fi

    setupTimezone

    echo "Installing Network Time Protocol... " 
    configureNTP

    # ------------ @engineervix's additional functions ------------
    setupHostname
    setupNodeYarn
    setupPython

    sudo -i -u "${username}" bash << EOF
    $(setupGit)
    $(setupZSH)
    $(setupRuby)
    $(setupVim)
EOF

    # fix for (warning: unable to access '$HOME/.config/git/attributes': Permission denied)
    sudo chown -R "${username}" /home/"${username}"/.config/

    # ---------- end @engineervix's additional functions ----------

    sudo service ssh restart

    cleanup

    echo "Setup Done! Log file is located at ${output_file}" 
}

function setupSwap() {
    createSwap
    mountSwap
    tweakSwapSettings "10" "50"
    saveSwapSettings "10" "50"
}

function hasSwap() {
    [[ "$(sudo swapon -s)" == *"/swapfile"* ]]
}

function cleanup() {
    if [[ -f "/etc/sudoers.bak" ]]; then
        revertSudoers
    fi
}

function logTimestamp() {
    local filename=${1}
    {
        echo "===================" 
        echo "Log generated on $(date)"
        echo "==================="
    } >>"${filename}" 2>&1
}

function setupTimezone() {
    echo -ne "Enter the timezone for the server (Default is 'Africa/Lusaka'):\n" 
    read -r timezone
    if [ -z "${timezone}" ]; then
        timezone="Africa/Lusaka"
    fi
    setTimezone "${timezone}"
    echo "Timezone is set to $(cat /etc/timezone)" 
}

# Keep prompting for the password and password confirmation
function promptForPassword() {
   PASSWORDS_MATCH=0
   while [ "${PASSWORDS_MATCH}" -eq "0" ]; do
       read -s -rp "Enter new UNIX password:" password
       printf "\n"
       read -s -rp "Retype new UNIX password:" password_confirmation
       printf "\n"

       if [[ "${password}" != "${password_confirmation}" ]]; then
           echo "Passwords do not match! Please try again."
       else
           PASSWORDS_MATCH=1
       fi
   done 
}

# ----------- addtitional features not in original script ----------- #

function setupHostname() {
    # hostname 
    # this hostname should have a DNS A record pointing to the IP address of your server.
    # ref: https://linuxize.com/post/how-to-change-hostname-on-ubuntu-18-04/
    # ref: https://aws.amazon.com/premiumsupport/knowledge-center/linux-static-hostname/
    hostnamectl
    echo "Let's setup a new hostname" 
    read -p 'hostname: ' myhostname 
    sudo hostnamectl set-hostname $myhostname

    cat /etc/hosts
    echo "updating your /etc/hosts file" 
    # add text after 1st line
    # https://stackoverflow.com/a/44894788
    sudo sed -i "1 a 127.0.0.1   $myhostname" /etc/hosts

    # for AWS ...
    echo -e "\e[35m===========================================================\e[00m" 
    echo -e "changing \e[35mpreserve_hostname: false\e[00m to \e[35mpreserve_hostname: true\e[00m" 
    echo -e "\e[35m===========================================================\e[00m" 
    sudo sed -i -e 's/preserve_hostname:\ false/preserve_hostname:\ true/g' /etc/cloud/cloud.cfg
}

function setupZSH() {
    sudo apt install zsh -y
    # Verify installation (Expected result: zsh 5.4.2 or more recent):
    echo "You have installed ZSH $(zsh --version)" 
    echo "Let us now make ZSH your default shell ..." 
    chsh -s $(which zsh)

    # ohmyzsh
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

    # powerlevel10k
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/powerlevel10k
    # Replace ZSH_THEME="robbyrussell" with ZSH_THEME="powerlevel10k/powerlevel10k".
    sed 's/robbyrussell/powerlevel10k\/powerlevel10k/g' -i ~/.zshrc

    # font installation
    sudo apt install fonts-inconsolata fonts-symbola -y
    sudo apt install fonts-powerline -y

    wget https://github.com/Lokaltog/powerline/raw/develop/font/PowerlineSymbols.otf https://github.com/Lokaltog/powerline/raw/develop/font/10-powerline-symbols.conf
    wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf
    wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf
    wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf
    wget https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf

    sudo mv -v PowerlineSymbols.otf /usr/share/fonts/
    sudo mv -v MesloLGS*.ttf /usr/share/fonts/

    sudo fc-cache -vf

    sudo mv 10-powerline-symbols.conf /etc/fonts/conf.d/

    echo "in order to use your fancy new ZSH setup, exit terminal and enter a new session" 
}

function setupNodeYarn() {
    # nodeJS
    curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
    sudo apt-get install -y nodejs

    # yarn
    curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
    sudo apt-get update && sudo apt-get install yarn
}

function setupPython() {
    sudo apt install -y python3-pip  # also installs python3-dev

    # PILLOW needs these
    sudo apt install -y libffi-dev libjpeg-dev zlib1g-dev libtiff-dev libfreetype6-dev libraqm-dev libraqm0 pngquant libopenjp2-7-dev libopenjp2-7 tk-dev libwebp-dev liblcms2-dev
}

function setupGit() {
    # Configure git
    git config --global color.ui true

    echo "Now Configuring Git, Please specify your Git Global Name & Email" 
    read -p 'Your (git) Name: ' git_name 
    read -p 'Your (git) Email Address: ' git_email 
    git config --global user.name $git_name
    git config --global user.email $git_email
}

function setupRuby() {
    # first, install dependencies needed for ruby installation via rbenv (we already have node and yarn)
    sudo apt install libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev libssl-dev -y

    # Installing with rbenv is a simple two step process. First you install rbenv, and then ruby-build: 
    cd
    git clone https://github.com/rbenv/rbenv.git ~/.rbenv
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.zshrc
    echo 'eval "$(rbenv init -)"' >> ~/.zshrc
    exec $SHELL -l

    git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build
    echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.zshrc
    exec $SHELL -l

    rbenv install 2.6.6
    rbenv global 2.6.6
    exec $SHELL -l
    ruby -v

    ## The last step is to install Bundler
    gem install bundler
}

function setupVim() {
    # Vim setup
    sudo -H pip3 install powerline-status
    sudo apt install vim-nox -y
    curl -L https://bit.ly/janus-bootstrap | bash
    cp -rv $HOME/ubuntu-server-setup/.janus/ $HOME/
    cp -v $HOME/ubuntu-server-setup/.vimrc.after $HOME/
}

# --------- end addtitional features not in original script --------- #

main