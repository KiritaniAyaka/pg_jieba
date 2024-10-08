# pg_jieba

<center>

English | [简体中文](./README.zh.md)

![Visitors](https://count.ayk.moe/KiritaniAyaka/pg_jieba)
![Docker Pulls](https://img.shields.io/docker/pulls/kiritaniayaka/pg_jieba)
![Docker Image Size (tag)](https://img.shields.io/docker/image-size/kiritaniayaka/pg_jieba/latest?logo=Docker&label=Image%20Size)
![Docker Image Size (tag)](https://img.shields.io/docker/image-size/kiritaniayaka/pg_jieba/alpine?logo=Docker&label=Image%20Size%20(Alpine))

PostgreSQL Docker image for jieba preinstalled.

</center>

## Usage

> [!NOTE]
> The configuration path of PostgreSQL is `/usr/shared/postgresql` on bullseye(alse `latest`), but `/usr/local/shared/postgresql` on Alpine. All the following examples are on bullseye, be cautious if you are using Alpine variant.

```sh
docker run --name postgres_jieba \
  --restart always \
  -p 5432:5432 \
  -e POSTGRES_PASSWORD=your_password \
  -v ./data:/var/lib/postgresql/data \
  kiritaniayaka/pg_jieba:latest
```

To enable `jieba`, run `CREATE EXTENSION pg_jieba;` in the database you want.

## Database Configuration

This image is automated add jieba to shared_preload_libraries in a customed configuration file: `/etc/postgresql/postgresql.conf`. You can modify this file to change configuration as you need.

If you need to use another configuration file, note that the jieba is not added to shared_preload_libraries at first.

### Sample config file

Use the following command to export a configuration file sample:

```sh
docker run -i --rm kiritaniayaka/pg_jieba cat /usr/share/postgresql/postgresql.conf.sample > postgresql.conf
```

### Use a custom config file

```sh
docker run --name postgres_jieba \
  --restart always \
  -p 5432:5432 \
  -e POSTGRES_PASSWORD=your_password \
  -v ./data:/var/lib/postgresql/data \
  -v ./config/postgresql.conf:/etc/postgresql/postgresql.conf \ # mount a configuration file
  kiritaniayaka/pg_jieba:latest \
  postgres -c 'config_file=/etc/postgresql/postgresql.conf' # using a custom configuration file
```

This repository provided a script to help you export sample configuration file and add pg_jieba to preload libraries. Just run `./setup-config.sh`. (For Alpine: `USE_ALPINE=1 ./setup-config.sh`) 

## User Dictionary

Mount a user dictionary to container:

```sh
docker run --name postgres_jieba \
  --restart always \
  -p 5432:5432 \
  -e POSTGRES_PASSWORD=your_password \
  -v ./data:/var/lib/postgresql/data \
  -v ./config/jieba_user.dict:/usr/share/postgresql/tsearch_data/jieba_user.dict \ # mount user dictionary
  kiritaniayaka/pg_jieba:latest
```

More information about user dictionary, see [jaiminpan/pg_jieba](https://github.com/jaiminpan/pg_jieba).

## Acknowledgements

- [jaiminpan/pg_jieba](https://github.com/jaiminpan/pg_jieba) - The extension used by this project.
- [XYenon/postgres_jieba](https://github.com/XYenon/postgres_jieba) - The project referenced by this project. 
