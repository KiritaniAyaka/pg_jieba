# pg_jieba

<center>

[English](./README.md) | 简体中文

![Visitors](https://count.ayk.moe/KiritaniAyaka/pg_jieba)
![Docker Pulls](https://img.shields.io/docker/pulls/kiritaniayaka/pg_jieba)
![Docker Image Size (tag)](https://img.shields.io/docker/image-size/kiritaniayaka/pg_jieba/latest?logo=Docker&label=Image%20Size)
![Docker Image Size (tag)](https://img.shields.io/docker/image-size/kiritaniayaka/pg_jieba/alpine?logo=Docker&label=Image%20Size%20(Alpine))

预装 jieba 的 PostgreSQL Docker 镜像。

</center>

## 食用方法

> [!NOTE]
> 在 bullseye 上 PostgreSQL 的配置路径是 `/usr/shared/postgresql`，但在 Alpine 上是 `/usr/local/shared/postgresql`。下面的所有示例都是基于 bullseye 的，如果你正在使用 Alpine 版本，请注意这一点。

```sh
docker run --name postgres_jieba \
  --restart always \
  -p 5432:5432 \
  -e POSTGRES_PASSWORD=your_password \
  -v ./data:/var/lib/postgresql/data \
  kiritaniayaka/pg_jieba:latest
```

在想要启用 `jieba` 的数据库中运行 `CREATE EXTENSION pg_jieba;`。

## 数据库配置

使用下面的命令导出配置文件示例：

```sh
docker run -i --rm kiritaniayaka/pg_jieba cat /usr/share/postgresql/postgresql.conf.sample > postgresql.conf
```

然后将配置文件挂载到容器中并使用：

```sh
docker run --name postgres_jieba \
  --restart always \
  -p 5432:5432 \
  -e POSTGRES_PASSWORD=your_password \
  -v ./data:/var/lib/postgresql/data \
  -v ./config/postgresql.conf:/etc/postgresql/postgresql.conf \ # 挂载配置文件
  kiritaniayaka/pg_jieba:latest \
  postgres -c 'config_file=/etc/postgresql/postgresql.conf' # 使用自定义配置文件
```

此仓库还提供了一个脚本一键导出示例并将 pg_jieba 添加到 preload libraries 配置中。运行 `./setup-config.sh` 即可。（Alpine 则运行：`USE_ALPINE=1 ./setup-config.sh`）

## User Dictionary

将用户词典挂载到容器：

```sh
docker run --name postgres_jieba \
  --restart always \
  -p 5432:5432 \
  -e POSTGRES_PASSWORD=your_password \
  -v ./data:/var/lib/postgresql/data \
  -v ./config/jieba_user.dict:/usr/share/postgresql/tsearch_data/jieba_user.dict \ # 挂载用户词典
  kiritaniayaka/pg_jieba:latest
```

有关用户词典的更多信息，请参阅 [jaiminpan/pg_jieba](https://github.com/jaiminpan/pg_jieba)。

## 鸣谢

- [jaiminpan/pg_jieba](https://github.com/jaiminpan/pg_jieba) - 本项目所使用的 PostgreSQL 扩展。
- [XYenon/postgres_jieba](https://github.com/XYenon/postgres_jieba) - 本项目参考了此项目。
