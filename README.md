# 🚀 Azure HA Platform




---



## 📌 Description

Projet démontrant la conception et le déploiement d’une plateforme web \*\*hautement disponible et scalable\*\* sur Microsoft Azure.

Infrastructure entièrement automatisée via \*\*Terraform\*\* et déployée via \*\*GitHub Actions (OIDC sécurisé)\*\*.

---

## 🏗 Architecture

<p align="center">
  <img src="docs/AZURE.png" width="2400">
</p>

```
Internet
↓
Azure Load Balancer
↓
VM Scale Set (2–5 instances)
↓
Application Docker (Nginx)
↓
Azure Monitor / Log Analytic
```
---

## ⚙️ Fonctionnalités Implémentées
### Infrastructure
- Architecture modulaire Terraform
- Backend distant Azure Storage
- VNet avec segmentation public / privé
- VM Scale Set scalable
- Rolling Upgrade activé


### CI/CD
- Build Docker automatique
- Push vers GitHub Container Registry
- Terraform Plan sur Pull Request
- Terraform Apply sur branche main
- Authentification OIDC GitHub → Azure

### Observabilité

- Log Analytics Workspace
- Diagnostic Settings VMSS \& Load Balancer
- Alert CPU > 80%
- Autoscaling CPU (2 à 5 instances)

---

## 🔁 Déploiement

### Initialisation Terraform

```bash

terraform init

terraform plan

terraform apply

```
## 🔁 Déploiement automatique

- Push sur `main` → \*\*Terraform Apply automatique\*\*
- Pull Request → \*\*Terraform Plan automatique\*\*
---


## 🛡 Sécurité

- Aucun secret cloud stocké dans le dépôt
- Authentification sécurisée via \*\*OIDC (GitHub → Azure)\*\*
- Isolation réseau (subnets public / privé)
- Rolling upgrades sans interruption de service

---

## 🧠 Stack Technique

- Terraform
- Microsoft Azure
- Azure VM Scale Set (VMSS)
- Azure Monitor
- Docker
- GitHub Actions
- OIDC
- Azure CLI

---
## 🎯 Objectif

Démonstration d’une architecture Cloud prête pour la production avec :

- Haute disponibilité
- Scalabilité automatique
- Monitoring et alerting
- CI/CD sécurisé
- Infrastructure as Code modulaire





