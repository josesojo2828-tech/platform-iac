# platform-iac

Infraestructura como código de una plataforma de hosting pequeña: **Terraform**
provisiona, **Ansible** configura y **CI/CD** ejecuta el flujo sin intervención
manual.

Es el proyecto que cierra los huecos reales frente al puesto de L2 Systems &
Networks: infraestructura declarativa, gestión de configuración y pipelines.

## Objetivo

Demostrar, con código que corre, este flujo:

```
terraform plan ──▶ PR (revisión)
terraform apply ──▶ merge
ansible-playbook ──▶ configuración idempotente
```

Y sobre esa base desplegar los workloads que ya existen (`goshrt` y
`kube-elements`) con la observabilidad de `quantic-monitor`.

## Fases

- [x] **F0 — Esqueleto y decisiones**: repo, ADR, estructura, CI de `fmt` y `validate`.
- [ ] **F1 — Un host de punta a punta**: Terraform crea una VM desde template con
      cloud-init; Ansible la endurece; `destroy` + `apply` la recrea idéntico.
- [ ] **F2 — Red**: VLANs, DNS, reverse proxy y VPN de administración.
- [ ] **F3 — Workload**: k3s + `goshrt` + Postgres, deploy manual.
- [ ] **F4 — CI/CD**: el deploy manual se reemplaza por pipeline.
- [ ] **F5 — Observabilidad**: `quantic-monitor` vigilando la plataforma.
- [ ] **F6 — Confiabilidad**: backups, restore drill y un nodo RHEL-family.

## Estructura

```
platform/
├── terraform/
│   ├── versions.tf              # provider de Proxmox
│   ├── variables.tf
│   ├── main.tf                  # for_each sobre los hosts declarados
│   ├── outputs.tf
│   ├── terraform.tfvars.example
│   └── modules/pve-vm/          # módulo reutilizable
├── ansible/
│   ├── ansible.cfg
│   ├── requirements.yml
│   ├── site.yml
│   ├── inventory/example/hosts.yml
│   └── roles/common/
├── docs/
│   ├── architecture.md
│   └── adr/0001-alcance-y-objetivo.md
└── .github/workflows/
```

## Uso

```bash
# Terraform
cp terraform/terraform.tfvars.example terraform/terraform.tfvars
# completar endpoint, token y hosts
make fmt validate plan

# Ansible
cp ansible/inventory/example/hosts.yml ansible/inventory/hosts.yml
make ansible-syntax
```

Nunca commitees `terraform.tfvars` ni `inventory/hosts.yml`: están en
`.gitignore`.

## Requisitos

- Terraform >= 1.6
- Ansible core >= 2.16
- Un host Proxmox VE con un template de VM y un API token
