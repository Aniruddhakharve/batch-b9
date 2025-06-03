FROM moongeun/centos9
ENV project=devops
WORKDIR /opt/
ADD https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.105/bin/apache-tomcat-9.0.105.tar.gz /opt/
RUN yum install httpd -y
COPY index.html /var/www/html/index.html
EXPOSE 80
CMD [ "/usr/sbin/httpd", "-D", "FOREGROUND" ]