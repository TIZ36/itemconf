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

### 安装prometheus

prometheus.yml
```yml
global:
  scrape_interval:     15s # By default, scrape targets every 15 seconds.

  # Attach these labels to any time series or alerts when communicating with
  # external systems (federation, remote storage, Alertmanager).
  external_labels:
    monitor: 'codelab-monitor'

# A scrape configuration containing exactly one endpoint to scrape:
# Here it's Prometheus itself.
scrape_configs:
  # The job name is added as a label `job=<job_name>` to any timeseries scraped from this config.
  - job_name: 'prometheus'

    # Override the global default and scrape targets from this job every 5 seconds.
    scrape_interval: 5s

    static_configs:
      - targets: ['localhost:9090']
```

``` shell
# Create persistent volume for your data
# docker volume create prometheus-data

# start, 使用制定的volumn。bindmount
docker run \
    -dp 9090:9090 \
    --mount type=bind,source=/Users/lilithgames/docker-data-volume/prometheus_data,target=/prometheus \
    -v ./prometheus.yml:/etc/prometheus/prometheus.yml \
    prom/prometheus \
    --config.file=/etc/prometheus/prometheus.yml \
    --web.enable-lifecycle

# reload
curl -X POST localhost:9090/-/reload
```

### 安装grafana

```shell

docker run -dp 3001:3000 --name=grafana \
--mount type=bind,source=/Users/lilithgames/docker-data-volume/grafana_data,target=/var/lib/grafana \
grafana/grafana-enterprise

```

### 安装redis

```shell
docker run -dp 6379:6379 --name myredis \
-v /Users/lilithgames/docker-data-volume/redis_data/redis.conf:/etc/redis/redis.conf  \
-v /Users/lilithgames/docker-data-volume/redis_data/data:/data \
--restart=always \
redis \
redis-server /etc/redis/redis.conf
```

### 安装minio

```shell
docker run -d \
  -p 9000:9000 \
  -p 9001:9001 \
  --name minio1 \
  -v /Users/lilithgames/docker-data-volume/minio_data:/data \
  -e "MINIO_ROOT_USER=schuck" \
  -e "MINIO_ROOT_PASSWORD=597502610ztS$%^&" \
  quay.io/minio/minio server /data --console-address ":9001"
```

### 安装jaeger
```shell
docker run -d --rm --name jaeger \
  -e COLLECTOR_ZIPKIN_HOST_PORT=:9411 \
  -p 6831:6831/udp \
  -p 6832:6832/udp \
  -p 5778:5778 \
  -p 16686:16686 \
  -p 4317:4317 \
  -p 4318:4318 \
  -p 14250:14250 \
  -p 14268:14268 \
  -p 14269:14269 \
  -p 9411:9411 \
  jaegertracing/all-in-one:1.57
```