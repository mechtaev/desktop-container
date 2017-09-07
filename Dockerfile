FROM ubuntu:14.04

RUN apt-get update && \
    apt-get install -y openssh-server

RUN mkdir /var/run/sshd

# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

RUN apt-get -y install git emacs24-nox build-essential

RUN apt-get -y install sudo

RUN useradd -m ubuntu && echo "ubuntu:ubuntu" | chpasswd && adduser ubuntu sudo

USER ubuntu

RUN cd ~ && git clone https://github.com/mechtaev/dotfiles.git && ~/dotfiles/install

USER root

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
