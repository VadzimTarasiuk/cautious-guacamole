FROM sbeliakou/centos:6.7
MAINTAINER Siarhei Beliakou (siarhei_beliakou@epam.com)
RUN yum install -y httpd web-assets-httpd
EXPOSE 80
CMD httpd -DFOREGROUND
