# Notas Día 2 - Terraform + Ansible

- Me olvidé de abrir el puerto 22 en el SG, no podía conectar Ansible.
- Tuve que dar permisos 400 al `.pem` para evitar el error de "bad permissions".
- `ansible_user` por defecto es `ec2-user` en Amazon Linux 2.
- Agregué `become: yes` porque sin eso no se puede usar `yum` ni `service`.
- Usé `terraform output public_ip` para copiar rápido al inventario.
- Aprendí que Ansible no necesita agente, se conecta solo por SSH.

Ejecutar playbook:
ansible-playbook -i inventory.ini playbook.yml
Resultado esperado
Instancia EC2 con Nginx instalado y corriendo

Usuario deploy creado

Archivo /home/ec2-user/bienvenida.txt presente

Aprendi cómo Ansible se conecta, ejecuta tareas y automatiza post-provisionamiento

Recursos
Terraform EC2 Module

Ansible Getting Started
