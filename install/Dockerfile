# docker build -t ruby-ssh .

FROM ubuntu:18.04

# download dependencies
RUN apt-get update && apt-get upgrade -y && apt-get install -y git sudo curl software-properties-common gpg openssh-server
# to allow connecting through ssh with username root and password root
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
RUN sed -i 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' /etc/pam.d/sshd 
RUN sudo apt install -y firefox
# to include the setup script
WORKDIR /home
COPY setup_rvm.sh setup_rvm.sh
RUN chmod +x setup_rvm.sh && \
    ./setup_rvm.sh && \
    rm setup_rvm.sh

# expose ports for ssh (22) and web (3000)
EXPOSE 22
EXPOSE 3000

# run ssh service automatically
# CMD ["/usr/sbin/sshd", "-D"]
CMD ["/bin/bash", "-c", "service postgresql start & /usr/sbin/sshd -D"]
# CMD ["/bin/bash", "-c", "service postgresql start"]
