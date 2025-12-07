FROM postgres:15-alpine3.22 AS build

ENV PG_MAJOR=15

RUN apk update && \
  apk add ca-certificates git cmake g++ make postgresql${PG_MAJOR}-dev icu-dev && \
  git clone https://github.com/jaiminpan/pg_jieba && cd pg_jieba && \
  git submodule update --init --recursive && \
  mkdir build && cd build && \
  cmake -DPostgreSQL_TYPE_INCLUDE_DIR=/usr/include/postgresql/${PG_MAJOR}/server .. && \
  make && make install

FROM postgres:15-alpine3.22 AS production

RUN --mount=from=build,source=/,target=/build \
  cat /build/pg_jieba/build/install_manifest.txt | xargs -i cp -p /build{} {} && \
  mkdir -p /etc/postgresql && cp -p /usr/local/share/postgresql/postgresql.conf.sample /etc/postgresql/postgresql.conf && \
  sed -i '/#shared_preload_libraries = ''/a shared_preload_libraries = '"'pg_jieba.so'"'' /etc/postgresql/postgresql.conf

CMD ["postgres", "-c", "config_file=/etc/postgresql/postgresql.conf"]
