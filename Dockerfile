FROM ubuntu:22.04 AS base-env
ENV cmakeversion=cmake-3.24.1-linux-x86_64
WORKDIR /usr/local


FROM base-env AS build-env
RUN apt update && apt install bzip2
ADD https://cmake.org/files/v3.24/${cmakeversion}.tar.gz .
RUN tar -xvf ${cmakeversion}.tar.gz


FROM base-env
LABEL Description="compiler"
COPY --from=build-env /usr/local/${cmakeversion}/ /usr/local/${cmakeversion}/ 
ENV PATH "/usr/local/${cmakeversion}/bin:$PATH"
RUN apt update && apt install -y \
    make \
    && rm -rf /var/lib/apt/lists/*
WORKDIR /usr/src
