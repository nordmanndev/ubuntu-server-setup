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

  echo "Please specify your Git Global Name & Email" 
  read -rp 'Your (git) Name: ' git_name 
  read -rp 'Your (git) Email Address: ' git_email 

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
  furtherHardening
  setupUfw

  if ! hasSwap; then
      setupSwap
  fi

  setupTimezone

  # echo "Installing Network Time Protocol... " 
  configureNTP

  setupHostname
  setupNodeYarn
  setupPython

  sudo -i -u "${username}" -H bash -c "mkdir -p /home/${username}/bin"

  setupGit
  setupZSH
  setupRuby
  setupVim

  # fix for (warning: unable to access '$HOME/.config/git/attributes': Permission denied)
  sudo -i -u "${username}" -H bash -c "mkdir -p /home/${username}/.config"
  sudo chown -R "${username}" /home/"${username}"/.config/

  sudo service ssh restart

  cleanup

  echo -e "\e[35mYou have installed ZSH $(zsh --version)\e[00m" 
  echo -e "\e[35mLet us now make ZSH your default shell ...\e[00m" 
  sudo -i -u "${username}" -H bash -c "chsh -s $(which zsh)"

  sudo mv -v "${current_dir}/${output_file}" /home/"${username}"/ && sudo chown -R "${username}":"${username}" /home/"${username}"/"${output_file}"
  sudo rm -fv /home/$username/oh_my_zsh_install.sh
  echo -e "Setup Done! Log file (\e[35m${output_file}\e[00m) is in \e[35m${username}\e[00m's home directory"
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

# ----------- addtitional functions not in original script ----------- #

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
  sudo apt-get install -y python3-pip  # also installs python3-dev

  # PILLOW needs these
  sudo apt-get install -y libffi-dev libjpeg-dev zlib1g-dev libtiff-dev libfreetype6-dev libraqm-dev libraqm0 pngquant libopenjp2-7-dev libopenjp2-7 tk-dev libwebp-dev liblcms2-dev
}

function setupGit() {
  # Configure git
  git config --global color.ui true

  git config --global user.name "${git_name}"
  git config --global user.email "${git_email}"
}

function setupZSH() {
  sudo apt-get install zsh -y

  # ohmyzsh
  sudo wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O /home/$username/oh_my_zsh_install.sh
  sudo -i -u "${username}" -H bash -c "ZSH=\"/home/$username/.oh-my-zsh\" sh oh_my_zsh_install.sh --unattended"
  sudo chown -R "${username}":"${username}" /home/$username/.oh-my-zsh
  sudo cp -v ${current_dir}/.zshrc /home/$username/ && sudo chown -R "${username}":"${username}" /home/$username/.zshrc
  sudo -i -u "${username}" -H bash -c "sed -i \"s/root/home\/$username/g\" /home/$username/.zshrc"
  # powerlevel10k
  sudo -i -u "${username}" -H bash -c "git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-/home/$username/.oh-my-zsh/custom}/themes/powerlevel10k"
  # Replace ZSH_THEME="robbyrussell" with ZSH_THEME="powerlevel10k/powerlevel10k".
  sudo -i -u "${username}" -H bash -c "sed 's/robbyrussell/powerlevel10k\/powerlevel10k/g' -i /home/$username/.zshrc"

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

  echo -e "\e[35min order to use your fancy new ZSH setup, you'll have to later exit terminal and enter a new session\e[00m" 
}

function setupRuby() {
  sudo apt-get install ruby-full ruby-bundler -y
}

function setupVim() {
  # Vim setup
  sudo -u "${username}" -H bash -c "sudo -H pip3 install powerline-status"
  sudo apt-get install vim-nox -y
  sudo -u "${username}" -H bash -c "curl -L https://bit.ly/janus-bootstrap | bash"

  sudo cp -rv $HOME/ubuntu-server-setup/.janus/ /home/$username/ && sudo chown -R "${username}":"${username}" /home/$username/.janus/
  sudo cp -v $HOME/ubuntu-server-setup/.vimrc.after /home/$username/ && sudo chown -R "${username}":"${username}" /home/$username/.vimrc.after
}

function furtherHardening() {
  # restrict access to the server
  echo "AllowUsers ${username}" | sudo tee -a /etc/ssh/sshd_config

  # Secure Shared Memory
  # tip 6 at https://hostadvice.com/how-to/how-to-harden-your-ubuntu-18-04-server/
  echo "none /run/shm tmpfs defaults,ro 0 0" | sudo tee -a /etc/fstab
}

# --------- end addtitional features not in original script --------- #

main