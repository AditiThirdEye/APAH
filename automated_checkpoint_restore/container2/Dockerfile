FROM kalilinux/kali-rolling
WORKDIR /simple_loop
COPY /simple_loop .
RUN ls
RUN apt-get update
RUN apt install -y build-essential
RUN dpkg -i criu_3.14-1_amd64.deb || true
RUN apt --fix-broken install -y
RUN apt-get install nano
