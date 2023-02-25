# docker build -t ruby-ssh .

FROM ubuntu:18.04

# download dependencies
RUN apt-get update && apt-get upgrade -y && apt-get install -y git sudo curl software-properties-common gpg openssh-server
# to enable ssh
RUN mkdir /var/run/sshd
RUN echo 'root:prueba' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
RUN sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd 
# start on home
WORKDIR /home
# to include the setup script
# COPY setup.sh setup.sh
# RUN echo "tzdata tzdata/Areas select US" | sudo debconf-set-selections
# RUN echo "tzdata tzdata/Zones/US select Central" | sudo debconf-set-selections
# RUN chmod +x setup.sh && ./setup.sh https://github.com/vibalcam/match-my-fashion-public-CodeCreators
EXPOSE 22
EXPOSE 3000
CMD ["/usr/sbin/sshd", "-D"]
