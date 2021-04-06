#!/bin/bash
echo "⏭ BUILDING"
mkdir -p /var/www/_letsencrypt
chown nginx /var/www/_letsencrypt
sed -i -r 's/(listen .*443)/\1; #/g; s/(ssl_(certificate|certificate_key|trusted_certificate) )/#;#\1/g; s/(server \{)/\1\n    ssl off;/g' /etc/nginx/sites-available/sushilayer.com.conf
sudo nginx -t && sudo systemctl reload nginx
certbot certonly --webroot -d sushilayer.com -d www.sushilayer.com -d cdn.sushilayer.com --email admin@sushilayer.com -w /var/www/_letsencrypt -n --agree-tos --force-renewal
sed -i -r -z 's/#?; ?#//g; s/(server \{)\n    ssl off;/\1/g' /etc/nginx/sites-available/sushilayer.com.conf
sudo nginx -t && sudo systemctl reload nginx

echo "Configure Certbot to reload NGINX when it successfully renews certificates.."
echo -e '#!/bin/bash\nnginx -t && systemctl reload nginx' | sudo tee /etc/letsencrypt/renewal-hooks/post/nginx-reload.sh
sudo chmod a+x /etc/letsencrypt/renewal-hooks/post/nginx-reload.sh

echo "🎉Let's go live!"
sudo nginx -t && sudo systemctl reload nginx
