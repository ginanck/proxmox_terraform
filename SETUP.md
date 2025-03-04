# Development Environment Setup (Updated)

This document outlines the resources, configurations, and IP mappings for our development environment infrastructure.

## DNS

| Hostname  | IP Address   | CPU     | RAM | Storage | Access URL            | VM_ID |
|-----------|--------------|---------|-----|---------|-----------------------|-------|
| dns-01    | 172.16.2.21  | 2 cores | 4GB | 40GB    | https://dns.dev.local | 221   |

## FreeIPA

| Hostname  | IP Address  | CPU     | RAM  | Storage | Role      | VM_ID |
|-----------|-------------|---------|------|---------|-----------|-------|
| ipa-01    | 172.16.2.25 | 4 cores | 8GB  | 100GB   | primary   | 225   |
| ipa-02    | 172.16.2.26 | 4 cores | 8GB  | 100GB   | secondary | 226   |
| ipa-03    | 172.16.2.27 | 4 cores | 8GB  | 100GB   | teritary  | 227   |

## Gitea

| Hostname | IP Address   | CPU     | RAM | Storage | Access URL              | VM_ID |
|----------|--------------|---------|-----|---------|-------------------------|-------|
| gitea01  | 172.16.2.31  | 2 cores | 4GB | 200GB    | https://gitea.dev.local | 231   |

## Harbor

| Hostname | IP Address   | CPU     | RAM | Storage | Access URL               | VM_ID |
|----------|--------------|---------|-----|---------|--------------------------|-------|
| harbor01 | 172.16.2.35  | 4 cores | 8GB | 200GB   | https://harbor.dev.local | 235   |

## Jenkins

| Hostname        | IP Address   | CPU     | RAM | Storage | Access URL                | VM_ID |
|-----------------|--------------|---------|-----|---------|---------------------------|-------|
| jenkins-master  | 172.16.2.41  | 4 cores | 8GB | 100GB   | https://jenkins.dev.local | 241   |
| jenkins-slave01 | 172.16.2.42  | 4 cores | 4GB | 100GB   | N/A                       | 242   |
| jenkins-slave02 | 172.16.2.43  | 4 cores | 4GB | 100GB   | N/A                       | 243   |

## PVE Hosts

| Hostname  | IP Address  | CPU     | RAM | Storage0 | Storage1 | Role      | VM_ID |
|-----------|-------------|---------|-----|----------|----------|-----------|-------|
| pve-01    | 172.16.2.51 | 4 cores | 8GB | 40GB     | 120GB    | primary   | 251   |
| pve-02    | 172.16.2.52 | 4 cores | 8GB | 40GB     | 120GB    | secondary | 252   |
| pve-03    | 172.16.2.53 | 4 cores | 8GB | 40GB     | 120GB    | tertiary  | 253   |

## NFS Server

| Hostname      | IP Address   | CPU     | RAM | Storage | VM_ID |
|---------------|--------------|---------|-----|---------|-------|
| nfs-server-01 | 172.16.2.61  | 2 cores | 4GB | 200GB   | 261   |

Exports List;
- /exports/k8s
- /exports/jenkins

## HAProxy

| Hostname  | IP Address  | CPU     | RAM  | Storage0 | Role      | VM_ID |
|-----------|-------------|---------|------|----------|-----------|-------|
| haproxy01 | 172.16.2.71 | 2 cores | 2GB  | 40GB     | primary   | 271   |

## NGinx

| Hostname | IP Address  | CPU     | RAM  | Storage0 | Role      | VM_ID |
|----------|-------------|---------|------|----------|-----------|-------|
| nginx01  | 172.16.2.81 | 2 cores | 2GB  | 40GB     | primary   | 281   |

## Kubernetes Cluster
### Master Nodes

| Hostname     | IP Address   | CPU     | RAM | Storage | Role          | VM_ID |
|--------------|--------------|---------|-----|---------|---------------|-------|
| k8s-master01 | 172.16.2.101 | 4 cores | 4GB | 80GB    | control plane | 301   |
| k8s-master02 | 172.16.2.102 | 4 cores | 4GB | 80GB    | control plane | 302   |
| k8s-master03 | 172.16.2.103 | 4 cores | 4GB | 80GB    | control plane | 303   |

### Worker Nodes

| Hostname     | IP Address   | CPU     | RAM | Storage | Role        | VM_ID |
|--------------|--------------|---------|-----|---------|-------------|-------|
| k8s-worker01 | 172.16.2.111 | 4 cores | 4GB | 140GB   | worker node | 311   |
| k8s-worker02 | 172.16.2.112 | 4 cores | 4GB | 140GB   | worker node | 312   |
| k8s-worker03 | 172.16.2.113 | 4 cores | 4GB | 140GB   | worker node | 313   |
