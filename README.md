## Todo App 📔

- React JS
- FastAPI
- Sqlalchemy
- Tailwind CSS

![Todo gif](https://user-images.githubusercontent.com/64283478/204075904-bfb3d555-b736-4501-b30b-70c256d5c75a.gif)


## Local Usage Instructions

## 🚀 Run Locally with Docker Compose

1. **Clone the repository:**
```bash
git clone https://github.com/Buddywise/todo-application.git
cd todo-application
```

2. **Build and start the services:**
```bash
docker compose up --build
```

3. **Access the application:**
- Frontend UI: [http://localhost:3000](http://localhost:3000)
- Backend API: [http://localhost:8000](http://localhost:8000)

4. **Stop the application:**
```bash
docker compose down
```

> Ensure Docker and Docker Compose are installed.

---

## ☁️ Cloud Architecture Overview (AWS)

A production-grade infrastructure on AWS includes:

- **VPC** with public subnet
- **ECS Fargate** for container orchestration
- **Application Load Balancer (ALB)**
- **CloudWatch** for monitoring
- **Security Groups** for restricted access

### Network Layout
```
[ Users ]
   ↓
[ ALB ]
   ↓
[ ECS Fargate ]
   ↓
[ CloudWatch Logs ]
```

### Security Highlights
- ALB allows only HTTP(S)
- ECS tasks are in secured subnets
- Backend accessible only via ALB

---

## 📁 Project Structure

```plaintext
todo-buddywise-application/
├── backend/                  # FastAPI backend
├── frontend/                 # React frontend
├── docker-compose.yml        # Local container orchestration
├── terraform/               # AWS infrastructure as code
│   └── README.md            # Terraform setup instructions
├── k8s/                     # Kubernetes manifests
│   └── README.md            # K8s setup & HA/scaling guide
└── README.md                # This file
```

> See [`terraform/README.md`](./terraform/README.md) for Terraform usage instructions and infrastructure provisioning steps.
---

## 🚜 Kubernetes Deployment (Optional)

Use `kubectl apply -f <file>` to deploy components from the `k8s/` folder:
- Frontend: `frontend-deployment.yaml`
- Backend: `backend-deployment.yaml`
- Ingress (optional): `ingress.yaml`

> See [`k8s/README.md`](./k8s/README.md) for detailed instructions and HA/scalability notes.

---

## ⚙️ CI/CD Pipeline

This repository includes a GitHub Actions workflow (`.github/workflows/ci-cd.yml`) that:

- Builds backend and frontend Docker images on every push to `main`
- Pushes them to Docker Hub under your account

> Make sure to configure `DOCKER_USERNAME` and `DOCKER_PASSWORD` in your GitHub repository secrets.

---

## 🔗 Links & Docs
- [Terraform Setup](./terraform/README.md)
- [Kubernetes Setup](./k8s/README.md)

---

