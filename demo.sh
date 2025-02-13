#!/bin/bash
# Update system and install necessary packages
sudo yum update -y
sudo yum install -y git httpd

# Start and enable Apache
sudo systemctl start httpd
sudo systemctl enable httpd

# Clone GitHub repository (replace with your repo link)
cd /var/www/html
sudo git clone https://github.com/deep-18/E-commerce-Clothing.git

# Move into the repo and set correct permissions
cd your-repo
sudo chown -R apache:apache /var/www/html/your-repo

# Restart Apache to serve the content
sudo systemctl restart httpd
