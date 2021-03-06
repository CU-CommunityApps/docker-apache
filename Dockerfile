FROM 095493758574.dkr.ecr.us-east-1.amazonaws.com/base

# File Author / Maintainer
MAINTAINER Shawn Bower <shawn.bower@gmail.com>

# Install.
RUN \
  apt-get update && \
  apt-get install -y apache2 && \
  apt-get clean

#copy files needed for CUWA
COPY conf/cuwebauth.load /etc/apache2/mods-available/cuwebauth.load
COPY lib/libcom_err.so.3 /lib/libcom_err.so.3
COPY lib/mod_cuwebauth.so /usr/lib/apache2/modules/mod_cuwebauth.so

# turn on mods
RUN \
  a2enmod ssl \
  cuwebauth \
  rewrite \
  proxy \
  proxy_http

EXPOSE 80
EXPOSE 443

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
