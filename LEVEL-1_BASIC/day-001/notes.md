
---

# `LEVEL-1_BASIC/day-001/notes.md`

```markdown
# Notas Día 1 - Terraform EC2 + EKS + Istio

- Preparé variables para región, subnet, AMI y permisos IAM.  
- Terraform creó la instancia EC2 con éxito y pude entrar con SSH.  
- No entendí bien cómo funciona el webhook para sidecar injection de Istio.  
- La app hello-world corrió con sidecar, pero quiero revisar mejor la comunicación entre pods y proxy.  
- Port-forward me ayudó a probar el acceso, pero quiero entender mejor VirtualServices y Gateway. 
