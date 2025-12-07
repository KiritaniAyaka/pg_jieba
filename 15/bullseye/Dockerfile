FROM postgres:15-bullseye AS build

ENV PG_MAJOR=15

RUN apt update && \
  apt-get install -y --no-install-recommends ca-certificates git cmake build-essential postgresql-server-dev-${PG_MAJOR} icu-devtools && \
  git clone --depth 1 https://github.com/jaiminpan/pg_jieba && cd pg_jieba && \
  git submodule update --init --recursive --depth 1 && \
  mkdir build && cd build && \
  cmake -DPostgreSQL_TYPE_INCLUDE_DIR=/usr/include/postgresql/${PG_MAJOR}/server .. && \
  make && make install

FROM postgres:15-bullseye AS production

RUN --mount=from=build,source=/,target=/build \
  cat /build/pg_jieba/build/install_manifest.txt | xargs -i cp -p /build{} {} && \
  mkdir -p /etc/postgresql && cp -p /usr/share/postgresql/postgresql.conf.sample /etc/postgresql/postgresql.conf && \
  sed -i '/#shared_preload_libraries = ''/a shared_preload_libraries = '"'pg_jieba.so'"'' /etc/postgresql/postgresql.conf

CMD ["postgres", "-c", "config_file=/etc/postgresql/postgresql.conf"]
