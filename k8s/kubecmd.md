## deployment 
### 创建
```shell
kubectl create deployment my-deploy-name --image={dockerurl}

# --record flag设置
kubectl create -f xxx.yaml --record
# apply -f xxx.yaml和create的区别就是可以对于已有的部署进行更改，而create只能在没有某个部署的时候使用，否则会报错
kubectl apply -f xxx.yaml
```

### 查看
```shell
kubectl get deployments

kubectl describe deployments
kubectl describe deployments/deploymentname

```

### 更新
```shell
# 更新部署的镜像
kubectl set image deployment/nginx-deployment nginx=xxx

# 使用类vim的编辑器编辑 deployment的配置 xx.yaml
kubectl edit deployment/deploymentname
```

### 回退
```shell
kubectl rollout history deployment/exmock

# 回退一个版本
kubectl rollout undo deployment/nginx-deployment

# 回退到指定的revision（kube会默认保留10?个revision, 反正可以通过修改revisionHistoryLimit这个字段控制）
kubectl rollout undo deployment/deploymentname --to-revision=2

kubectl rollout status deployment deployname
```

### 扩缩容
```shell
kubectl scale deployment nginx-deployment --replicas 10

#如果集群支持 HPA horizontal pod autoscaling 的话，还可以为 Deployment 设置自动扩展：
kubectl autoscale deployment nginx-deployment --min=10 --max=15 --cpu-percent=80

```

---
### StatefulSet 
> 解决有状态服务的问题 （对应deployment和replicaset是为了解决无状态的服务设计的）

其他的场景：

- 稳定的持久化存储，pod重新调度后还是能访问到相同的持久化数据，基于pvc实现
- 稳定的网络标识，即pod重新调度后podname和hostname不变，基于headless service来实现
- 有序部署，有序扩展，即pod是有顺序的。部署和扩展的时候要依据定义的顺序一次进行
- 有序收缩，有序删除

StatefulSet由几个部分组成：
- 定义网络标识的（DNS domain）的headless service
- 创建persistentVolumes的volumeclaimtemplates
- 定义具体应用的statefulset

statefulset中每个pod的dns格式：
```shell
{statefulsetname}-{0..n}.{headlessservicename}.namespace.svc.cluster.local
```

### Deamon Set

### Job

> job负责批处理任务，即仅执行一次的任务，它保证批处理任务的一个或者多个pod成功结束

#### job sepc

- spec.template格式同pod
- restartPolicy 仅支持Never或者onFailure
- 单个pod时，默认pod成功运行后即结束
- .spec.completions 标志job结束需要成功运行的pod个数，默认为1
- .spec.parallelism 标志并行运行的pod的个数，默认为1
- .spec.activeDeadlineSeconds 标志失败pod的充实最大时间，超过这个时间不会继续重试

```yaml
apiVersion: batch/v1
kind: Job
metadata: 
  name: pi
spec:
  template:
    metadata:
      name: pi
    spec:
      containers:
      - name: pi
        image: perl
        command: ["perl", "-Mbignum=bpi", "-wle", "print bpi(2000)"]
      restartPolicy: Never
```