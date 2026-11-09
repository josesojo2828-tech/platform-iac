# Arquitectura objetivo

```
                         ┌──────────────────────────────┐
                         │        Proxmox VE            │
                         │  (nodo o clúster)            │
                         └──────────────┬───────────────┘
                                        │ Terraform (bpg/proxmox)
                    ┌───────────────────┼───────────────────┐
                    ▼                   ▼                   ▼
              ┌──────────┐        ┌──────────┐        ┌──────────┐
              │  node01  │        │  node02  │        │  node03  │
              │  k3s     │        │  k3s     │        │  k3s     │
              └────┬─────┘        └────┬─────┘        └────┬─────┘
                   │                   │                   │
                   └───────────────────┼───────────────────┘
                                       │
                    ┌──────────────────┼──────────────────┐
                    ▼                  ▼                  ▼
              ┌──────────┐      ┌────────────┐     ┌──────────────┐
              │  goshrt  │      │kube-elements│    │ quantic-monitor│
              │ (Go+PG)  │      │ (estático)  │    │ (Prom/Grafana) │
              └──────────┘      └────────────┘     └──────────────┘
```

## Separación de responsabilidades

| Capa | Herramienta | Qué hace | Qué NO hace |
|---|---|---|---|
| Provisión | Terraform | Crea y destruye VMs, discos, red | No instala paquetes ni configura servicios |
| Configuración | Ansible | Usuarios, paquetes, firewall, k3s | No crea infraestructura |
| Entrega | GitHub Actions | `plan`/`apply`, lint, deploy | No reemplaza a ninguna de las dos |

## Decisión clave

Terraform **no** se usa para instalar software, y Ansible **no** se usa para
crear VMs. Mezclarlos es el error clásico: el estado de Terraform termina
mintiendo y nadie sabe qué creó qué.

## Diagrama de flujo

```
dev ──▶ PR ──▶ terraform fmt + validate + plan ──▶ review
                                   │
merge ─────────────────────────────┴──▶ terraform apply
                                              │
                                              ▼
                                     ansible-playbook site.yml
                                              │
                                              ▼
                                        host listo
```
