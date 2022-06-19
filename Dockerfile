FROM fedora:latest AS base
RUN dnf upgrade -y && \
    dnf install curl git ansible which util-linux-user passwd -y

FROM base AS maiki 
RUN groupadd -g 1000 maik
RUN useradd -u 1000 -g 1000 -m maik
RUN echo "maik:root" | chpasswd 
RUN usermod -aG wheel maik 
USER maik

WORKDIR /home/maik/ansible
CMD ["sh", "-c", "ansible-playbook main.yml"]