# ADR-0001 — Alcance y objetivo del proyecto

- **Estado:** aceptado
- **Fecha:** 2026-11-09

## Contexto

El puesto de L2 Systems & Networks Technician pide, explícitamente:

- Infraestructura como código (Terraform, Ansible)
- Mentalidad DevOps: CI/CD, automatización, observabilidad
- Virtualización (KVM, Proxmox)
- Linux, redes y programación (Go/Python/Bash)

El portfolio actual cubre Linux, redes, virtualización, observabilidad y
programación, pero **no tiene Terraform, Ansible ni CI/CD de infraestructura**.
Esos son los huecos que este proyecto debe cerrar.

## Decisión

1. **Un repo único** (`platform`) para infraestructura, configuración y
   documentación. Sin monorepo de aplicaciones: los workloads ya viven en sus
   repos y se integran por imagen.
2. **Proxmox VE como target**, con el provider `bpg/proxmox`. Es el entorno que
   la vacante pide y el que el autor ya opera.
3. **Separación estricta**: Terraform provisiona, Ansible configura. Nunca al
   revés.
4. **Pipeline en GitHub Actions**: `fmt` + `validate` en cada PR; `plan` cuando
   hay credenciales; `apply` solo en `main`.

## Alternativas consideradas

| Alternativa | Por qué no |
|---|---|
| Solo Ansible | No cubre el requisito de IaC declarativa ni el estado/destroy |
| Solo Terraform + cloud-init | La configuración queda en scripts no idempotentes |
| Kubernetes como única capa | No demuestra provisión de infraestructura |
| Cloud (AWS/GCP) | Costo real y no coincide con el stack de la vacante |

## Consecuencias

- El módulo `pve-vm` queda aislado: si mañana el target cambia (libvirt, cloud),
  se reemplaza el módulo sin tocar los playbooks.
- El estado de Terraform es sensible: nunca se commitea. En F1 se decide backend
  remoto (S3/MinIO o local con cifrado).
- Sin acceso a un Proxmox real, el repo se valida con `fmt`/`validate` y los
  playbooks con `--syntax-check`; el `apply` queda documentado como pendiente.

## Preguntas abiertas

- ¿Target final: Proxmox del trabajo, Proxmox propio o libvirt local?
- ¿Backend de estado: local cifrado o remoto?
