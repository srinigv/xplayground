FROM ubuntu:15.04
MAINTAINER "srinigv" "srinigv@icloud.com"

RUN echo "###*** updating to latest and greatest ***###"
RUN apt-get update 

ENV DEBIAN_FRONTEND noninteractive

RUN echo "###*** installing desktop, ssh essentials ***###"
RUN apt-get install -y openssh-server xubuntu-desktop openssl

RUN echo "###*** installing x2go ***###"
RUN add-apt-repository ppa:x2go/stable
RUN apt-get update
RUN apt-get install x2goserver x2goserver-xsession pwgen -y

RUN echo "###*** sshd config ***###"
RUN mkdir -p /var/run/sshd && sed -i "s/UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && sed -i "s/UsePAM.*/UsePAM no/g" /etc/ssh/sshd_config
RUN sed -i "s/PermitRootLogin.*/PermitRootLogin yes/g" /etc/ssh/sshd_config
RUN sed -i "s/#PasswordAuthentication/PasswordAuthentication/g" /etc/ssh/sshd_config

RUN mkdir -p /tmp/.X11-unix && chmod 1777 /tmp/.X11-unix

RUN echo "###*** config root/users ***###"
ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh
RUN chmod +x /*.sh

RUN echo "###*** enable ssh port ***###"
EXPOSE 22

CMD ["/run.sh"]
