# pg_jieba

PostgreSQL Docker image for jieba preinstalled.

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

Use the following command to export a configuration file sample:

```sh
docker run -i --rm kiritaniayaka/pg_jieba cat /usr/share/postgresql/postgresql.conf.sample > postgresql.conf
```

Then mount it into container and tell PostgreSQL to using it:

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

- [pg_jieba extension](https://github.com/jaiminpan/pg_jieba) - The extension used by this project.
- [XYenon/postgres_jieba](https://github.com/XYenon/postgres_jieba) - The project referenced by this project. 
