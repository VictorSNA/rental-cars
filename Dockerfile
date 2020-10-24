FROM ruby:2.6.3

ARG uid
ARG app_path

RUN apt-get update && \
      apt-get install -yqq --no-install-recommends nodejs && \
      useradd -u $uid --home-dir $app_path rental-cars

USER rental-cars

WORKDIR $app_path
