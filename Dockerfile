FROM fedora:latest AS base
WORKDIR /usr/local/bin
RUN dnf upgrade -y && \
    dnf install curl git ansible which util-linux-user passwd -y

FROM base AS maiki 
RUN groupadd -g 1000 maik
RUN useradd -u 1000 -g 1000 -m maik
RUN passwd -d maik
RUN echo "maik ALL=(root) NOPASSWD:ALL" > /etc/sudoers.d/maik && \
    chmod 0440 /etc/sudoers.d/maik
USER maik
WORKDIR /home/maik

FROM maiki
COPY . .
CMD ["sh", "-c", "ansible-playbook main.yml"]