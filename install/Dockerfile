# docker build -t ruby-ssh .

FROM ubuntu:18.04

RUN apt-get update && apt-get upgrade -y && apt-get install -y git sudo curl software-properties-common gpg openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:prueba' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
RUN sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd 
# to include the setup script
WORKDIR /home
# COPY setup.sh setup.sh
# RUN chmod +x install_rvm.sh && ./install_rvm.sh
EXPOSE 22
EXPOSE 3000
CMD ["/usr/sbin/sshd", "-D"]
