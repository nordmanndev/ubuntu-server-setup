# https://www.digitalocean.com/community/questions/best-practices-for-hardening-new-sever-in-2017
# https://linux-audit.com/ubuntu-server-hardening-guide-quick-and-secure/
# https://dennisnotes.com/note/20180627-ubuntu-18.04-server-setup/
# https://www.ncsc.gov.uk/guidance/eud-security-guidance-ubuntu-1804-lts
# https://www.ubuntu.com/security
function setupLynis(){

    # lynis -- https://cisofy.com/lynis/
  sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 013baa07180c50a7101097ef9de922f1c2fde6c4
  sudo apt install apt-transport-https -y
  echo 'Acquire::Languages "none";' | sudo tee /etc/apt/apt.conf.d/99disable-translations
  echo "deb https://packages.cisofy.com/community/lynis/deb/ stable main" | sudo tee /etc/apt/sources.list.d/cisofy-lynis.list
  sudo apt update
  sudo apt install lynis -y

  # https://www.theurbanpenguin.com/detecting-rootkits-with-rkhunter-in-ubuntu-18-04/
  sudo apt install -y rkhunter

  sudo lynis audit system

}