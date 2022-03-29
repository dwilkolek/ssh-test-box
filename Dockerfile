FROM ubuntu:latest

RUN apt-get update && apt-get install -y openssh-server
RUN sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config

RUN useradd -m -s /bin/bash sshuser
RUN mkdir /home/sshuser/.ssh
COPY id_rsa.pub /home/sshuser/.ssh/id_rsa.pub
RUN cat /home/sshuser/.ssh/id_rsa.pub > /home/sshuser/.ssh/authorized_keys

RUN chmod 700 /home/sshuser/.ssh
RUN chmod 600 /home/sshuser/.ssh/authorized_keys

RUN chown sshuser:sshuser /home/sshuser
RUN chown sshuser:sshuser /home/sshuser/.ssh
RUN chown sshuser:sshuser /home/sshuser/.ssh/id_rsa.pub
RUN chown sshuser:sshuser /home/sshuser/.ssh/authorized_keys

RUN echo "AllowUsers sshuser" >> /etc/ssh/sshd_config

RUN service ssh start

COPY ssh-test-box ./server
RUN chmod +x ./server

EXPOSE 22
EXPOSE 8080
ENTRYPOINT service ssh restart && ./server