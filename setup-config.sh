#!/bin/bash

if [ -z "USE_ALPINE" ]
then
  docker run -i --rm kiritaniayaka/pg_jieba \
    cat /usr/share/postgresql/postgresql.conf.sample > ./config/postgresql.conf
else
 docker run -i --rm kiritaniayaka/pg_jieba:alpine \
    cat /usr/local/share/postgresql/postgresql.conf.sample > ./config/postgresql.conf  
fi

sed -i "/^#shared_preload_libraries/ {
  n
  i\
shared_preload_libraries = 'pg_jieba.so'
}" ./postgresql/postgresql.conf
