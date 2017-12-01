FROM ubuntu:16.04
MAINTAINER Liuyang-Z "liuyang.z@hooowl.com"

RUN set -x \
        && apt-get -yqq update \
        && apt-get -yqq install ruby ruby-dev make nodejs gcc python \
        && gem sources --remove https://rubygems.org/ \
        && gem sources -a https://ruby.taobao.org \
        && gem install --no-rdoc --no-ri jekyll \
        && gem install jekyll-paginate \
        && gem install pygments.rb \
        && gem install jekyll-sitemap \
        && gem install redcarpet

VOLUME /data
VOLUME /var/www/html
WORKDIR /data

ENTRYPOINT ["jekyll","build","--destination=/var/www/html" ]