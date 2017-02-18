# www.bayun.org
clear

echo ""

# make sure if it is run by root
if [ `whoami` != root ]; then
    echo "This script must be run as root!"
    exit 0
fi

# Input the hostname of Ubuntu
echo "This script install Ghost on Ubuntu"
echo "Please provide your hostname(eg:www.bayun.org):"
echo ""
read HOSTNAME

# Update and install some commands
apt-get update -y
apt-get install -y curl unzip vim wget screen

# Download the latest version of Ghost
cd /home
wget https://cdn.bayun.org/software/ghost-latest.zip
unzip -d ghost ghost-latest.zip
rm -rf ghost-latest.zip
cd ghost
sed -e "s/my-ghost-blog.com/$HOSTNAME/" <config.example.js >config.js

# Use cnpm instead of npm
curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash -
apt-get install -y nodejs
apt-get install -y npm
ln -s /usr/bin/nodejs /usr/bin/node
npm install -g cnpm --registry=https://registry.npm.taobao.org
cnpm install

# Install Nginx
apt-get install -y nginx
rm -rf /etc/nginx/sites-enabled/default

echo "Configuring Nginx"
echo "server {" >> /etc/nginx/sites-available/ghost
echo "    listen 80;" >> /etc/nginx/sites-available/ghost
echo "    server_name $HOSTNAME;" >> /etc/nginx/sites-available/ghost
echo "    location / {" >> /etc/nginx/sites-available/ghost
echo "        proxy_set_header   X-Real-IP \$remote_addr;" >> /etc/nginx/sites-available/ghost
echo "        proxy_set_header   Host      \$http_host;" >> /etc/nginx/sites-available/ghost
echo "        proxy_pass         http://127.0.0.1:2368;" >> /etc/nginx/sites-available/ghost
echo "        }" >> /etc/nginx/sites-available/ghost
echo "    }" >> /etc/nginx/sites-available/ghost

sudo ln -s /etc/nginx/sites-available/ghost /etc/nginx/sites-enabled/ghost
service nginx restart

# Start Ghost
cd /home/ghost
npm start --production
