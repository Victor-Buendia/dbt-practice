FROM ubuntu:20.04
RUN apt-get update
RUN apt-get install -y git python3.8 python3-pip
RUN pip3 install --upgrade pip setuptools
RUN pip3 install dbt-postgres dbt-redshift
WORKDIR /dbt