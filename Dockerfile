FROM alpine:latest

MAINTAINER Fernando Ribeiro <fernando.ribeiro@geocrafter.eu>

ARG RTL_VERSION

RUN apk add --no-cache gcc libc-dev make cmake rtl-sdr librtlsdr-dev curl

RUN curl https://github.com/merbanan/rtl_433/archive/$RTL_VERSION.tar.gz -jkSL -o /tmp/$RTL_VERSION.tar.gz && \
    tar -xvf /tmp/$RTL_VERSION.tar.gz

# Compile
RUN cd /rtl_433-$RTL_VERSION/ && mkdir build && cd build && cmake .. && make && make install

# Cleanup
RUN apk del curl make gcc libc-dev && rm -rf /tmp/* /var/cache/apk/* /rtl_433-$RTL_VERSION
