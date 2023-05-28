# Docker命令

####  容器命令

- `docker attach`：连接到正在运行的容器。
- `docker create`：创建一个新的容器但不启动它。
- `docker cp`：在容器和主机之间复制文件和文件夹。
- `docker diff`：显示容器文件系统中的更改。
- `docker exec`：在正在运行的容器中执行新命令。
- `docker export`：将容器的文件系统导出为 tar 归档文件。
- `docker inspect`：显示有关 Docker 对象（容器、镜像、网络等）的详细信息。
- `docker kill`：终止正在运行的容器。
- `docker logs`：获取容器的日志。
- `docker pause`：暂停一个正在运行的容器。
- `docker port`：显示容器的公开端口。
- `docker ps`：列出正在运行的容器。
- `docker restart`：重启容器。
- `docker rm`：删除一个或多个容器。
- `docker start`：启动一个或多个已经创建的容器。
- `dockerstop`：停止一个或多个正在运行的容器。
- `docker top`：显示容器中正在运行的进程。
- `docker unpause`：恢复暂停的容器。
- `docker update`：更新容器配置。
- `docker wait`：阻塞直到容器停止。

#### 镜像命令

- `docker build`：从 Dockerfile 构建镜像。
- `docker commit`：从容器创建一个新的镜像。
- `docker history`：显示镜像的历史记录。
- `docker images`：列出本地镜像。
- `docker import`：从归档文件或 URL 创建镜像。
- `docker load`：从归档文件中加载镜像。
- `docker pull`：从 Docker Hub 或其他 Docker Registry 拉取镜像。
- `docker push`：将本地镜像推送到 Docker Hub 或其他 Docker Registry。
- `docker rmi`：删除一个或多个镜像。
- `docker save`：将镜像保存为归档文件。
- `docker tag`：为镜像添加标签。

#### 网络命令

- `docker network`：管理 Docker 网络。

#### Swarm 命令

- `docker node`：管理 Docker 集群节点。
- `docker service`：管理 Docker Swarm 服务。
- `docker swarm`：管理 Docker Swarm。

#### 系统命令

- `docker info`：显示 Docker 系统信息。
- `docker login`：登录到 Docker Hub 或其他 Docker Registry。
- `docker logout`：从 Docker Hub 或其他 Docker Registry 注销。
- `docker system`：管理 Docker 系统。
- `docker version`：显示 Docker 版本信息。

# docker compose文件

- `version`：指定 Compose 文件的版本。当前支持的版本为 2.x、3.x、3.1、3.2、3.3 等。
- `services`：定义要运行的服务，可以是一个或多个服务。
- `networks`：定义要使用的网络，可以是一个或多个网络。
- `volumes`：定义要使用的卷，可以是一个或多个卷。

除了上述参数外，Docker Compose 文件还支持其他参数，如 `environment`、`ports`、`depends_on`、`restart`、`image`、`command`、`volumes`、`networks` 等。这些参数的作用如下：

- `environment`：设置环境变量，可以是一个列表或一个字典。
- `ports`：将容器端口映射到主机端口。
- `depends_on`：定义服务之间的依赖关系，以便在启动依赖服务之前启动当前服务。
- `restart`：定义容器失败时的重启策略。
- `image`：使用的镜像名称和标签。
- `command`：在容器中运行的命令，可以覆盖 Dockerfile 中的 `CMD`。
- `volumes`：将主机路径或命名卷挂载到容器中。
- `networks`：将服务添加到指定的网络中。

除了上述参数外，Docker Compose 文件还支持其他参数，如 `network_mode`、`container_name`、`links`、`user`、`working_dir`、`entrypoint` 等。这些参数的作用如下：

- `network_mode`：指定容器要使用的网络模式。
- `container_name`：指定容器的名称。
- `links`：链接到其他服务。
- `user`：设置容器中运行进程的用户。
- `working_dir`：设置容器工作目录。
- `entrypoint`：覆盖 Dockerfile 中的 `ENTRYPOINT`。

Docker Compose 文件还支持通过环境变量文件或命令行参数覆盖 Compose 文件中的参数。例如，可以使用 `-f` 参数指定 Compose 文件的路径，使用 `--project-name` 参数指定项目名称，使用 `--env-file` 参数指定环境变量文件的路径等。

# 1 .env环境变量

## 1.1 定义

> 在使用 Docker 构建和运行容器时，可以通过使用 `.env` 文件来设置环境变量和配置参数。`.env` 文件是一个文本文件，其中包含变量和其对应的值，每行一个变量，格式为 `VAR_NAME=VAR_VALUE`。
>
> 在 Dockerfile 中，可以使用 `ENV` 命令来设置环境变量，但如果使用 `.env` 文件，则可以在 Dockerfile 中使用 `${VAR_NAME}` 的语法来引用变量，例如：

```properties
VAR_NAME=${VAR_NAME}
```

> 在 Docker Compose 配置文件中，也可以使用 `${VAR_NAME}` 的语法来引用 `.env` 文件中的变量。例如：

```yml
version: '3'
services:
  web:
    image: nginx
    environment:
      MY_VAR: ${VAR_NAME}
```



## 1.2 使用

```shell
# 构建镜像
docker compose --env-file .env up -d
# .env 文件中的变量仅在构建和运行Docker 容器时才会生效 
# 可以在容器启动命令中使用 -e 参数来将其传递给容器
docker run -e MY_VAR=${VAR_NAME} myimage
# 查看环境变量的引用
docker-compose --env-file ../.env config
```



# 2. docker compose up

## 2.1 参数

- `-d`：在后台模式下启动容器。
- `--no-color`：禁用输出的颜色。
- `--quiet-pull`：禁止输出拉取镜像的详细信息。
- `--no-deps`：不启动服务依赖的服务。
- `--force-recreate`：强制重新创建容器，即使容器已经存在。
- `--always-recreate-deps`：重新创建所有服务依赖的容器。
- `--no-recreate`：不重新创建容器，即使容器已经存在。
- `--no-build`：不构建镜像，直接使用已有的镜像。
- `--build`：在启动容器之前构建镜像。
- `--abort-on-container-exit`：当容器退出时，停止所有容器的运行。
- `--attach-dependencies`：在启动容器之前启动所有服务依赖的服务。
- `--remove-orphans`：移除无关的容器，即没有被 Compose 文件中定义的服务所依赖的容器。
- `--timeout TIMEOUT`：设置容器启动的超时时间，默认为 10 秒。
- `--renew-anon-volumes`：在启动容器之前删除匿名卷，并重新创建它们。
- `--remove-volumes`：在移除容器时同时移除关联的匿名和命名卷。
- `--volumes`：在容器之间共享命名卷。
- `--scale SERVICE=NUM`：指定要启动的服务以及要启动的容器数量，例如 `--scale web=2` 表示启动 `web` 服务的 2 个容器。
- `--no-log-prefix`：不在日志中输出服务名称的前缀。
- `--log-level LEVEL`：设置日志的级别，默认为 `info`。
- `--exit-code-from SERVICE`：从指定的服务获取退出代码，并在所有容器停止时退出。
- `--disable-content-trust`：禁用 Docker Content Trust。
- `--pull`：在启动容器之前拉取最新的镜像。
- `--no-healthcheck`：不运行健康检查。
- `--compose-file FILE`：指定要使用的 Compose 文件，可以指定多个文件。
- `--project-namePROJECT_NAME`：指定 Compose 项目的名称。
- `-f, --file FILE`：指定要使用的 Compose 文件，可以指定多个文件。
- `--env-file PATH`：指定要使用的环境变量文件。
- `--env, -e KEY=VALUE`：设置环境变量，可以指定多个。
- `--no-recreate`：不重新创建容器，即使容器已经存在。
- `--no-start`：不启动容器，只构建镜像。
- `--scale SERVICE=NUM`：指定要启动的服务以及要启动的容器数量，例如 `--scale web=2` 表示启动 `web` 服务的 2 个容器。
- `--remove-orphans`：移除无关的容器，即没有被 Compose 文件中定义的服务所依赖的容器。
- `--no-build`：不构建镜像，直接使用已有的镜像。
- `--build`：在启动容器之前构建镜像。
- `--always-recreate-deps`：重新创建所有服务依赖的容器。
- `--force-recreate`：强制重新创建容器，即使容器已经存在。
- `--no-deps`：不启动服务依赖的服务。
- `--abort-on-container-exit`：当容器退出时，停止所有容器的运行。
- `--attach-dependencies`：在启动容器之前启动所有服务依赖的服务。
- `--remove-orphans`：移除无关的容器，即没有被 Compose 文件中定义的服务所依赖的容器。
- `--timeout TIMEOUT`：设置容器启动的超时时间，默认为 10 秒。
- `--renew-anon-volumes`：在启动容器之前删除匿名卷，并重新创建它们。
- `--remove-volumes`：在移除容器时同时移除关联的匿名和命名卷。
- `--volumes`：在容器之间共享命名卷。
- `--no-log-prefix`：不在日志中输出服务名称的前缀。
- `--log-level LEVEL`：设置日志的级别，默认为 `info`。
- `--exit-code-from SERVICE`：从指定的服务获取退出代码，并在所有容器停止时退出。
- `--disable-content-trust`：禁用 Docker Content Trust。



## 2.2 举例

```shell
# 指定一个镜像
docker compose up -d redis
# 指定环境变量
docker-compose --env-file ../.env up -d
# 重新创建容器，即使容器已经存在。
docker compose up   --force-recreate -d
# 构建镜像并启动容器。
docker-compose up --build
# 指定使用的 Compose 文件，默认文件名为 docker-compose.yml。
docker-compose -f filename.yml up
# 指定项目名称。
docker-compose -p projectname up
# 如果一个容器退出，则停止所有容器。
docker-compose up --abort-on-container-exit

```



# 3.docker logs

## 3.1参数

- `-f`：实时输出日志，类似于 `tail -f` 命令。
- `--tail NUM`：仅输出最后 NUM 行的日志，默认为全部输出。
- `--since TIME`：仅输出从指定时间点开始的日志，例如 `2022-05-01T00:00:00`。
- `--until TIME`：仅输出到指定时间点为止的日志，例如 `2022-05-01T23:59:59`。
- `--details`：输出更多的容器详细信息，例如容器的标签、ID、名称等。
- `--timestamps`：在日志中显示时间戳。
- `--follow` 或 `-f`：在输出日志后保持连接，实时查看容器日志的变化。
- `--tail` 或 `-n`：指定输出日志的行数。
- `--since`：指定输出日志的起始时间。

## 3.2 举例

### 3.2.1 查看容器的所有日志：

```shell
docker logs <container_id>
```

### 3.2.2 查看容器的最后 100 行日志：

```shell
docker logs --tail 100 <container_id>
```

### 3.2.3 查看容器的实时日志：

```shell
docker logs <container_id> 2>&1 | grep "error"
```

### 3.2.4 查看容器的所有日志，并在其中搜索关键字 `error`：

```shell
docker logs -f <container_id>
```

### 3.2.5 查看容器的最后 100 行日志，并在其中搜索关键字 `error`：

```shell
docker logs --tail 100 <container_id> 2>&1 | grep "error"
```

### 3.2.6 查看容器的实时日志，并在其中搜索关键字 `error`：：

```shell
docker logs -f <container_id> 2>&1 | grep "error"
```



# 4.Docker Inspect 

`docker inspect` 命令用于获取 Docker 对象（容器、镜像、网络等）

## 4.1 参数

- `--format`: 指定输出的格式。
- `--type`: 指定要检查的对象类型。
- `--size`: 显示对象占用的磁盘空间大小。
- `--all`: 显示所有对象的详细信息。
- `--verbose`: 显示更详细的信息。
- `--pretty`: 显示格式化的输出。
- `--no-trunc`: 显示完整的输出，而不是截断后的输出。
- `--help`: 显示帮助信息。



## 4.2 举例
### 4.2.1 检查容器的详细信息：

   ```shell
   docker inspect  <container_id> 
   ```

### 4.2.2 检查容器 IP 地址：

   ```shell
   docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'  <container_id> 
   ```

### 4.2.3 检查镜像信息：

   ```shell
   docker inspect <image_id> 
   ```

### 4.2.4 检查网络信息：

   ```shell
   docker inspect <network_name>
   ```

### 4.2.5 指定输出格式：

   ```shell
   docker inspect --format='{{.Name}} - {{.State.Status}}' <container_id> 
   ```

### 4.2.6 按条件筛选容器：

   ```shell
   docker inspect -f '{{.Name}} {{.State.Running}}' $(docker ps -q --filter "status=running")
   ```

### 4.2.7 按条件筛选镜像：

   ```shell
   docker inspect -f '{{.RepoTags}} {{.Size}}' $(docker images -q --filter "dangling=true")
   ```

### 4.2.8 使用jq格式化工具

```shell
docker inspect  <container_id>   | jq '.[0] | {id: .Id, created: .Created, author: .Author, size: .Size, labels: .Config.Labels}'
```

### 4.2.9 查看目录挂载信息

```shell
docker inspect --format="{{json .Mounts}}" <container_id> | jq
```

### 4.2.10 查看容器网络信息

```shell
#查看完整网络信息
docker inspect --format="{{json .NetworkSettings}}" <container_id> | jq
#查看网络端口映射
docker inspect --format="{{json .NetworkSettings.Ports}}" <container_id> | jq
# 查看容器的网络ip、网关等信息
docker inspect --format="{{json .NetworkSettings.Networks}}" <container_id> | jq

```

### 4.2.11 查看容器的端口映射：

```shell
docker inspect --format='{{json .HostConfig.PortBindings}}' mycontainer
```

### 4.2.12 查看容器的环境变量：

```shell
docker inspect --format='{{json .Config.Env}}' mycontainer
```

### 

# 5.docker exec 

## 5.1 参数

- `-it`: 以交互模式进入容器中执行命令，通常用于需要交互式操作的命令。
- `-d`: 让容器在后台运行。
- `--user`: 指定要执行命令的用户。
- `--workdir`: 指定命令执行的工作目录。
- `--env`: 设置环境变量。
- `--privileged`: 让容器拥有特权，可以访问主机的设备和文件系统。
- `--name`: 指定容器的名称。
- `--detach-keys`: 指定在后台运行容器时使用的键盘序列。

## 5.2 举例

### 5.2.1 进入正在运行的容器并执行命令：

```shell
docker exec -it mycontainer sh
```

上面的命令将以交互模式进入名为 `mycontainer` 的容器，并在容器中执行 `sh` 命令。

### 5.2.2 在后台运行容器并执行命令：

```shell
docker exec -d mycontainer ls
```

上面的命令将在名为 `mycontainer` 的容器中运行 `ls` 命令，并让容器在后台运行。

### 5.2.3 指定执行命令的用户：

```shell
docker exec --user=username mycontainer whoami
```

上面的命令将在名为 `mycontainer` 的容器中以 `username` 用户身份执行 `whoami` 命令。

### 5.2.4 指定命令执行的工作目录：

```shell
docker exec --workdir=/app mycontainer ls
```

上面的命令将在名为 `mycontainer` 的容器中以 `/app` 目录作为工作目录执行 `ls` 命令。

### 5.2.5 设置环境变量并执行命令：

```shell
docker exec --env MY_VAR=value mycontainer env
```

上面的命令将在名为 `mycontainer` 的容器中设置名为 `MY_VAR` 的环境变量为 `value`，并执行 `env` 命令。

### 5.2.6 让容器拥有特权并执行命令：

```shell
docker exec --privileged mycontainer ls /dev
```

上面的命令将在名为 `mycontainer` 的容器中以特权模式运行 `ls /dev` 命令，可以访问主机的设备和文件系统。

### 5.2.7 指定容器的名称并执行命令：

```shell
docker exec --name=myexec mycontainer ls
```

上面的命令将在名为 `mycontainer` 的容器中执行 `ls` 命令，并将执行结果输出到名为 `myexec` 的容器中。

### 5.2.8 指定在后台运行容器时使用的键盘序列：

```shell
docker exec --detach-keys="ctrl-d" mycontainer ls
```

上面的命令将在名为 `mycontainer` 的容器中运行 `ls` 命令，并在后台运行容器时使用 `ctrl-d` 键作为键盘序列。

### 5.2.9 在容器中查看日志：

```shell
docker exec -it mycontainer cat /var/log/mylog.log
```

### 5.2.10 查看容器内的进程：

```shell
dockerexec -it mycontainer ps -ef
```

# 6. docker cp

## 6.1 参数

- `-a, --archive`: 以归档模式进行复制，包括复制文件的所有 uid/gid 信息。
- `--follow-link`: 始终跟随源路径中的符号链接。
- `--help`: 显示帮助信息。

## 6.2 举例

### 6.2.1. 从容器复制文件到主机：

```shell
docker cp mycontainer:/path/to/myfile.txt /host/path/
```

上面的命令将从名为 `mycontainer` 的容器中复制 `/path/to/myfile.txt` 文件到主机的 `/host/path/` 目录中。

### 6.2.2 从主机复制文件到容器：

```shell
docker cp /host/path/myfile.txt mycontainer:/path/to/
```

上面的命令将从主机的 `/host/path/myfile.txt` 文件复制到名为 `mycontainer` 的容器中的 `/path/to/` 目录中。

### 6.2.3 使用 `-a` 参数复制所有的文件属性：

```shell
docker cp -a mycontainer:/path/to/myfile.txt /host/path/
```

上面的命令将从名为 `mycontainer` 的容器中复制 `/path/to/myfile.txt` 文件到主机的 `/host/path/` 目录中，并保留文件的所有属性。

### 6.2.4 使用 `-follow-link` 参数跟随符号链接：

```shell
docker cp --follow-link mycontainer:/path/to/mylink /host/path/
```

上面的命令将从名为 `mycontainer` 的容器中复制 `/path/to/mylink` 符号链接所指向的文件到主机的 `/host/path/` 目录中。

### 6.2.5 使用 `-` 作为目标路径打印到标准输出：

```shell
docker cp mycontainer:/path/to/myfile.txt -
```

上面的命令将从名为 `mycontainer` 的容器中读取 `/path/to/myfile.txt` 文件的内容，并输出到标准输出。

### 6.2.6 从容器中复制整个目录：

```shell
docker cp mycontainer:/path/to/mydir /host/path/
```

上面的命令将从名为 `mycontainer` 的容器中复制 `/path/to/mydir` 目录及其下的所有文件和子目录到主机的 `/host/path/` 目录中。

### 6.2.7 在容器中创建新文件并复制：

```shell
docker cp /host/path/myfile.txt mycontainer:/path/to/newfile.txt
```

上面的命令将在名为 `mycontainer` 的容器中创建名为 `/path/to/newfile.txt` 的新文件，并将主机中的 `/host/path/myfile.txt` 文件复制到新文件中。

这些是 `docker cp` 常用的参数和使用示例，可以根据具体的应用场景和需求，使用不同的参数和路径进行复制操作。
