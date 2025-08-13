# Día 1: Terraform EC2 + EKS + Istio + App básica

## Objetivo

- Usar Terraform para crear una instancia EC2 con permisos para acceder a un bucket S3  
- Crear un cluster EKS y configurarlo con Istio  
- Desplegar una app hello-world con sidecar Istio y exponerla vía ingressgateway  
- Profundizar en conceptos de Gateway, VirtualService y estado del proxy Istio

---

## Parte 1: Infra con Terraform

Usar Terraform para crear:

- Security Group para SSH desde tu IP local  
- Instancia EC2 con AMI, tipo y subnet según variables  
- IAM Role y Policy para que la instancia lea el bucket S3 `test`  
- Backend remoto en S3 para el estado (bucket `test`, key `s3/cluster`)

Variables necesarias: región, VPC, subnet pública, AMI, key SSH, rango IP para SSH

Ejecutar:

terraform init
terraform apply
Parte 2: Cluster EKS + Istio básico
Crear cluster EKS:


eksctl create cluster --name demo-eks-istio --region us-east-1 --nodes 2
Configurar kubeconfig para conectar con el cluster:


aws eks update-kubeconfig --region sa-east-1 --name demo-eks-istio
Instalar Istio con perfil demo:


curl -L https://istio.io/downloadIstio | sh -
cd istio-1.x.x
export PATH=$PWD/bin:$PATH

istioctl install --set profile=demo -y
Crear namespace y activar sidecar injection automático:


kubectl create namespace app-namespace
kubectl label namespace app-namespace istio-injection=enabled
Desplegar la app hello-world con sidecar Istio:


kubectl apply -n app-namespace -f samples/hello-world.yaml
Verificar pods y servicios desplegados:


kubectl get pods -n app-namespace
kubectl get svc -n app-namespace
Parte 3: Exposición con Gateway e Istio ingress
Revisar Gateways y VirtualServices instalados:


kubectl get gateway -n istio-system
kubectl get virtualservice -n app-namespace
Hacer port-forward para exponer Istio ingressgateway localmente:


kubectl -n istio-system port-forward svc/istio-ingressgateway 8080:80
En otra terminal, probar acceso vía curl simulando host:


curl -H "Host: app.test.com" http://localhost:8080/
Consultar estado del proxy Istio en los pods sidecar:


istioctl proxy-status
Ver logs de la app desplegada para debug:


kubectl logs -n app-namespace deployment/hello-world
Resultado esperado
Instancia EC2 accesible con permisos S3

Cluster EKS con Istio instalado y sidecar funcionando

App hello-world corriendo con sidecar

Servicio expuesto y accesible a través del ingressgateway

Comprensión inicial de Gateway, VirtualService y estado proxy

Recursos
Terraform AWS Provider

EKS Getting Started

Istio Getting Started
