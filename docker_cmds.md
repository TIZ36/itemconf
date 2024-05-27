### 安装mysql

```shell
docker run -d \
    -v mysql-data:/var/lib/mysql \
    -e MYSQL_ROOT_PASSWORD=root \
    -e MYSQL_DATABASE=exmock \
    -p3306:3306 \
    mysql:8.0
```

### 安装opwenwebui

```shell
docker run -d -p 3000:8080 -e OLLAMA_BASE_URL=http://10.3.30.81:11434/api -v open-webui:/app/backend/data --name open-webui --restart always ghcr.io/open-webui/open-webui:main
```