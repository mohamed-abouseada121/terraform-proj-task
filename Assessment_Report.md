# 🚀 Obelion Cloud Automation Assessment - Project Submission

This document details the solution implementation for the Cloud Automation Assessment. The solution focuses on **Automation**, **Security**, and **Scalability** using Terraform, AWS, and GitHub Actions.

---

## ✅ Task Group A: Infrastructure as Code (Terraform)

I designed a modular **3-Tier Architecture** on AWS using Terraform to ensure the code is organized, reusable, and easy to maintain.

### 1. Networking (`modules/networking`)
*   **Custom VPC:** `10.0.0.0/16` for full network control.
*   **Security Groups:** Implemented a "Least Privilege" access model:
    *   **Frontend SG:** Accepts HTTP (80) & Custom (3001) from `0.0.0.0/0`.
    *   **Backend SG:** Accepts traffic **ONLY** from the Frontend SG (and temporary SSH).
    *   **Database SG:** Accepts MySQL traffic **ONLY** from the Backend SG (No Internet Access).

### 2. Compute (`modules/compute`)
*   **Dynamic AMI:** Automatically fetches the latest Ubuntu 22.04 LTS image (No hardcoded IDs).
*   **Resources:**
    *   **Frontend Machine:** `t3.micro` hosting **Uptime Kuma** (Dockerized).
    *   **Backend Machine:** `t3.micro` hosting **Laravel** (Nginx + PHP 8.2).

### 3. Database (`modules/database`)
*   **RDS MySQL 8:** Deployed in a purely **Private Subnet** for maximum security.
*   **Storage:** Configured with `gp3` storage for better performance/cost ratio.

---

## ✅ Task Group B: CI/CD & Automation

I implemented **GitHub Actions** for fully automated pipelines and **CloudWatch** for monitoring.

### 1. Frontend Automation (Uptime Kuma)
*   **Workflow:** `.github/workflows/frontend-deploy.yml`
*   **Mechanism:** Docker Compose.
*   **Trigger:** Push to `main`.
*   **Action:** Connects via SSH, pulls the latest Docker image, and restarts the container.
*   **Proof of Success:**

![Uptime Kuma Dashboard](uptime-kuma.png)
*Figure 1: Uptime Kuma running successfully on Port 3001.*

### 2. Backend Automation (Laravel)
*   **Workflow:** `.github/workflows/backend-deploy.yml`
*   **Mechanism:** Shell Scripting.
*   **Process:**
    1.  **Clone/Pull:** Fetches latest code to `/var/www/laravel`.
    2.  **Environment:** Inject Secrets (`DB_HOST`, `DB_PASSWORD`, etc.) into `.env` dynamically.
    3.  **Migration:** Runs `php artisan migrate --force` to update the DB schema automatically.
*   **Proof of Success:**

![Laravel Welcome Page](laravel.png)
*Figure 2: Laravel Application connected to RDS MySQL.*

### 3. Monitoring & Alerting (CloudWatch + SNS)
*   **Metric:** CPU Utilization > 50%.
*   **Tool:** AWS CloudWatch Alarms created via **Terraform**.
*   **Notification:** AWS SNS Topic sending emails to the administrator.

![Frontend CPU Alert](frontend_alert.png)
*Figure 3: CloudWatch Alarm for Frontend CPU High.*

![Backend CPU Alert](backend_alert.png)
*Figure 4: CloudWatch Alarm for Backend CPU High.*

---

## 💡 Recommendations & Optimization

1.  **Cost Optimization:**
    *   Removed **NAT Gateway** ($30/month) since the backend uses Public IP for updates, saving significant cost for a dev environment.
    *   Used `gp3` storage for RDS (Cheaper and faster than `gp2`).

2.  **Security:**
    *   **GitIgnore:** Added `.terraform` and `.tfstate` to `.gitignore` to prevent leaking sensitive data.
    *   **Secrets Management:** All credentials are stored in GitHub Secrets, never in the code.

---

## 🏃 How to Run

1.  **Clone the Repo:**
    ```bash
    git clone <repo-url>
    ```
2.  **Provision Infrastructure:**
    ```bash
    terraform init
    terraform apply -auto-approve
    ```
3.  **Deployment:**
    *   Push to `main` branch on Frontend/Backend repos to trigger deployment.
