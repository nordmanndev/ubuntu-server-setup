function setupFail2ban() {
    
    sudo apt install fail2ban -y
    sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
    echo -e "\e[35m===========================================================\e[00m"
    echo -e "\e[35mNow updating the /etc/fail2ban/jail.local file ...\e[00m"
    sudo sed -i "s/^destemail\ =\ root@localhost/destemail\ =\ $root_email/" /etc/fail2ban/jail.local
    sudo sed -i "s/^sender\ =\ root@<fq-hostname>/sender\ =\ $mail_from/" /etc/fail2ban/jail.local
    echo -e "\e[35menabling sshd ...\e[00m"
    sudo sed -i '/^\[sshd\]/a enabled\ =\ true' /etc/fail2ban/jail.local
    echo -e "\e[35m===========================================================\e[00m"
}

