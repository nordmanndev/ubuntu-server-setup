# Setup the Uncomplicated Firewall
function setupUfw() {
    sudo ufw default deny incoming 
    sudo ufw default allow outgoing
    
    sudo ufw allow ssh 
    sudo ufw allow http
    sudo ufw allow https
    yes y | sudo ufw enable
}