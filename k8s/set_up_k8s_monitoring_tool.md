# Setup K8s Monitoring Tool

- Install Prometheus

```
$ helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
$ helm install pmt-prometheus prometheus-community/prometheus --set server.service.type=NodePort
```

- Install Grafana

```
$ helm repo add grafana https://grafana.github.io/helm-charts
$ helm install gfn-grafana grafana/grafana --set service.type=NodePort
```

- Uninstall

```
$ helm uninstall pmt-prometheus
$ helm uninstall gfn-grafana
```