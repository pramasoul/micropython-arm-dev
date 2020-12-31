FROM ubuntu:20.04
# https://askubuntu.com/questions/1243252/how-to-install-arm-none-eabi-gdb-on-ubuntu-20-04-lts-focal-fossa
RUN apt-get update \
    && apt-get install -y --no-install-recommends curl ca-certificates libncurses-dev \
    build-essential python3
### MAYBE LATER    && rm -rf /var/lib/apt/lists/*

# https://developer.arm.com/tools-and-software/open-source-software/developer-tools/gnu-toolchain/gnu-rm/downloads
RUN curl -L -s 'https://developer.arm.com/-/media/Files/downloads/gnu-rm/9-2020q2/gcc-arm-none-eabi-9-2020-q2-update-x86_64-linux.tar.bz2?revipsion=05382cca-1721-44e1-ae19-1e7c3dc96118&la=en&hash=D7C9D18FCA2DD9F894FD9F3C3DC9228498FA281A' \
    | tar xjf - -C /usr/share/

RUN ln -s /usr/share/gcc-arm-none-eabi-* /usr/share/gcc-arm-none-eabi
ENV PATH="/usr/share/gcc-arm-none-eabi/bin/:${PATH}"

# FIXME: Do these up top once debugged
RUN apt-get install -y --no-install-recommends git
RUN apt-get install -y --no-install-recommends less

COPY initialize.sh makeall.sh /opt/bin/
RUN chmod a+x /opt/bin/*.sh
ENV PATH="/opt/bin/:${PATH}"

WORKDIR /opt/micropython


ENTRYPOINT [ "/bin/bash", "-l", "-c" ]