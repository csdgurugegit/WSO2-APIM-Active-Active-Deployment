FROM docker.wso2.com/wso2am:4.3.0
USER root

COPY lib/ /home/wso2carbon/wso2am-4.3.0/repository/components/lib/
COPY security/ /home/wso2carbon/wso2am-4.3.0/repository/resources/security/
COPY deployment.toml /home/wso2carbon/wso2am-4.3.0/repository/conf/
COPY settings/publisher/settings.json /home/wso2carbon/wso2am-4.3.0/repository/deployment/server/webapps/publisher/site/public/conf/
COPY settings/devportal/settings.json /home/wso2carbon/wso2am-4.3.0/repository/deployment/server/webapps/devportal/site/public/theme/
COPY settings/adminportal/settings.json /home/wso2carbon/wso2am-4.3.0/repository/deployment/server/webapps/admin/site/public/conf/

RUN mkdir -p /home/apim-shared
RUN chmod 775 -R /home/apim-shared
RUN apt-get -y update
RUN apt-get install -y iputils-ping
RUN apt-get install -y vim
RUN apt-get install -y net-tools
RUN apt-get install -y curl                          
