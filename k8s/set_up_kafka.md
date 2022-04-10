# GCP: Set up kafka

# Setup Kafka

- Service type LoadBalancer

```
helm install --namespace default kafka bitnami/kafka \
	--set externalAccess.enabled=true \
	--set externalAccess.service.type=LoadBalancer  \
	--set externalAccess.service.port=9094 \
	--set externalAccess.autoDiscovery.enabled=true \
	--set serviceAccount.create=true \
	--set rbac.create=true \
	--set maxMessageBytes=_10485760 \
	--set image.tag=2.8.1-debian-10-r90

```

- Service type NodePort

```
helm install --namespace default kafka bitnami/kafka \
	--set externalAccess.enabled=true \
	--set externalAccess.service.type=NodePort \
	--set externalAccess.autoDiscovery.enabled=true \
	--set serviceAccount.create=true \
	--set rbac.create=true \
	--set image.tag=2.8.1-debian-10-r90

```

- Upgrade option

```
helm upgrade --namespace default kafka bitnami/kafka \
      --set replicaCount=1 \
      --set externalAccess.enabled=true \
      --set externalAccess.service.loadBalancerIPs[0]=<your ip> \
	    --set externalAccess.service.port=9092 \
      --set externalAccess.service.type=LoadBalancer

```

- Private only (For Test, Stage, Prod)

```
helm install --namespace default kafka bitnami/kafka \
	--set maxMessageBytes=_10485760 \
	--set image.tag=2.8.1-debian-10-r90
```