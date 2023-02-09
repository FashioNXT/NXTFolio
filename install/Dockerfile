# docker build -t ruby-ssh .

FROM ubuntu:18.04

RUN apt-get update && apt-get install -y openssh-server git sudo
RUN mkdir /var/run/sshd
RUN echo 'root:prueba' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
# WORKDIR /home
# to include the setup script
# COPY setup.sh /home/setup.sh
EXPOSE 22
EXPOSE 3000
CMD ["/usr/sbin/sshd", "-D"]