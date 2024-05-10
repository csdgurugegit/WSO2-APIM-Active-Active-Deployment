# WSO2 API-M Active-Active Deployment

In this deployment configuration, WSO2 API-M is set up in an Active-Active configuration within a single node environment. This architecture utilizes two WSO2 API Manager containers, effectively distributing the workload and ensuring redundancy for high availability. These containers work together smoothly and talk to a central MySQL server, which stores all the important data.

![](https://github.com/csdgurugegit/projectimages/blob/main/WSO2-API-M-Active-Active-Deployment.jpg)

## Create a SSL Certificate

Official Documentation.

https://apim.docs.wso2.com/en/latest/install-and-setup/setup/security/configuring-keystores/keystore-basics/creating-new-keystores/

When changing the hostname, it is necessary to create a new keystore and import it into the **client-truststore.jks** file to avoid issues.

```bash
keytool -genkey -alias apimcert -keyalg RSA -keysize 2048 -keystore apimwso2.jks -validity 730 -dname "CN=api.am.wso2.com, OU=WSO2,O=WSO2,L=SL,S=WS,C=LK" -storepass wso2carbon -keypass wso2carbon

keytool -export -alias apimcert -keystore apimwso2.jks -file apimwso2.pem -storepass wso2carbon

keytool -import -alias apimcert -file apimwso2.pem -keystore client-truststore.jks -storepass wso2carbon
```

## Configure the Load Balancer

Official Documentation.

https://apim.docs.wso2.com/en/latest/install-and-setup/setup/setting-up-proxy-server-and-the-load-balancer/configuring-the-proxy-server-and-the-load-balancer/

#### Step 01: Create an SSL certificate for the Nginx Load Balancer.

```bash
sudo openssl genrsa -des3 -out apimssl.key 2048
sudo openssl req -new -key apimssl.key -out apimserver.csr

sudo cp apimssl.key apimssl.key.org
sudo openssl rsa -in apimssl.key.org -out apimssl.key

sudo openssl x509 -req -days 365 -in apimserver.csr -signkey apimssl.key -out apim.crt
```

Wildcard domains can be used as a common name (CN). For example, CN=*.am.wso2.com

#### Step 02: Install nginx service.

```bash
sudo apt install nginx -y
```

#### Step 03: Create a directory to add SSL certificate files.

```bash
sudo mkdir /etc/nginx/ssl
```

Add **apimssl.key** and **apim.crt** files into the /etc/nginx/ssl directory.

#### Step 04: Create nginx configuration file.

Place the **nginx.conf** file into the /etc/nginx/conf.d directory.

Create the locations to save **access_log** and **error_log** and set correct permissons.

```bash
sudo mkdir /etc/nginx/log/am/https
sudo mkdir /etc/nginx/log/gw/https
```

#### Step 05: Set hostname.

vim or nano /etc/hosts.

```
[ip-address] api.am.wso2.com
[ip-address] gw.am.wso2.com
```

Run nginx service.

```bash
sudo systemctl start nginx
sudo systemctl restart nginx
sudo systemctl status nginx
```

## Build and Deploy

#### Step 01: Build the Enviroment.

Give execute permisson **chmod +x pre-build.sh** and run **Bash Script**.

```bash
sh docker-build.sh
```

#### Step 02: Use docker-compose to start the Deployment.

Deploy two API-M containers and a MySQL container by using the **service.yaml** file.

```bash
sudo docker-compose -f service.yaml up
```
