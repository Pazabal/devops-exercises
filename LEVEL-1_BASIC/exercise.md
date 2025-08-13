# Día 2: Terraform + Ansible para configurar EC2

## Objetivo

- Crear una instancia EC2 con Terraform  
- Usar Ansible para conectarse vía SSH y configurar esa instancia  
- Practicar inventarios dinámicos, comandos remotos, y tareas básicas con Ansible

---

## Parte 1: Infra con Terraform

1. Usar Terraform para crear:

- Una instancia EC2 en una subnet pública
- Security group que permita SSH (puerto 22)
- Asociar una key `.pem` para conectarse
- Output del `public_ip` de la instancia

2. Asegurate de tener:

- Tu VPC, subnet y VPC ID definidos como variables
- Backend en S3 
