sudo mkdir ~/pihole
sudo cp docker-compose.yml ~/pihole
cd ~/pihole
sudo systemctl stop systemd-resolve
sudo systemctl disable systemd-resolve
sudo sed -i 's/nameserver 127.0.0.[0-9]*/nameserver 1.1.1.1/' /etc/resolv.conf
sudo docker-compose up -d

