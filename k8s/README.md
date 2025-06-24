# Kubernetes Deployment for Buddywise Todo Application

This directory contains Kubernetes manifests to deploy the **frontend** and **backend** services of the Buddywise Todo Application.

> ⚠️ **Reminder:** Be sure to update the Docker image in the deployment YAMLs from `nginx:latest` to your actual application image before production or demonstration.

---

## Files

- `frontend-deployment.yaml` - Deploys the frontend app and exposes it via a NodePort service on port 3000.
- `backend-deployment.yaml` - Deploys the backend API and exposes it via a NodePort service on port 8000.
- `ingress.yaml` - Optional Ingress resource to route `/` to frontend and `/api/` to backend.

---

## Usage

### 1. Apply the deployments:
```bash
kubectl apply -f frontend-deployment.yaml
kubectl apply -f backend-deployment.yaml
```

### 2. (Optional) Enable Ingress and apply:
```bash
minikube addons enable ingress
kubectl apply -f ingress.yaml
```

### 3. Access the applications:
- With NodePort:
    - Frontend: `http://<NodeIP>:32000`
    - Backend: `http://<NodeIP>:32001`
- With Ingress:
    - Frontend: `http://<Ingress-IP>/`
    - Backend: `http://<Ingress-IP>/api/`

Replace `<NodeIP>` or `<Ingress-IP>` with your cluster node or ingress IP.

---

## Scalability
- Each service is deployed with **2 replicas**.
- You can scale using:
```bash
kubectl scale deployment frontend-deployment --replicas=3
kubectl scale deployment backend-deployment --replicas=3
```
- For auto-scaling, integrate with Horizontal Pod Autoscaler (HPA).

---

## High Availability
- Deployments are replicated to ensure availability.
- Pods are distributed across nodes if using a multi-node cluster.

---

## Note on NodePort and Ingress
This setup uses `NodePort` for simplicity and visibility during demos.

🔒 In production, prefer:
- `LoadBalancer` type (cloud-managed)
- `Ingress` with TLS and path-based routing