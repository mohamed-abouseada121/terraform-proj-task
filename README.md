# 🚀 Obelion Cloud Automation Assessment - Project Submission

This repository contains the full Infrastructure as Code (Terraform) and Automation (GitHub Actions) solution for the Obelion Cloud Automation Assessment.

---

## 🏗️ Architecture Overview

The solution implements two **independent** web applications on AWS:
1.  **Frontend Project:** A Node.js based monitoring dashboard (Uptime Kuma).
2.  **Backend Project:** A Laravel PHP API connected to a secure MySQL Database.

### 1. Networking (`modules/networking`)
*   **Custom VPC:** `10.0.0.0/16` hosting all resources.
*   **Security Groups (Open Access):**
    *   **Frontend SG:** Allows traffic from anywhere (`0.0.0.0/0`) on ports  **22** (SSH), and **3001** (Uptime Kuma).
    *   **Backend SG:** Allows traffic from anywhere (`0.0.0.0/0`) on ports **8080** (Laravel) and **22** (SSH) for accessibility.
    *   **Database SG:** Strictly private, allowing access ONLY from the Backend Server on port 3306.

### 2. Compute (`modules/compute`)
*   **Dynamic AMI:** Automatically fetches the latest Ubuntu 22.04 LTS image.
*   **Frontend Server:** `t3.micro` instance running Dockerized Uptime Kuma.
*   **Backend Server:** `t3.micro` instance running Laravel with PHP 8.2.

### 3. Database (`modules/database`)
*   **RDS MySQL 8:** Deployed in a purely **Private Subnet** (No Internet Access).
*   **Storage:** `gp3` storage for optimized performance.

---

## ✅ Task Group B: CI/CD & Automation Results

### 1. Frontend Automation (Uptime Kuma)
*   **Workflow:** `.github/workflows/frontend-deploy.yml`
*   **Mechanism:** Docker Compose via GitHub Actions.
*   **Result:** Triggers automatically on push to `main` and deploys to the Frontend EC2.
*   **Proof:**

![Uptime Kuma Dashboard](uptime-kuma.png)
*Figure 1: Uptime Kuma dashboard accessible publicly.*

### 2. Backend Automation (Laravel)
*   **Workflow:** `.github/workflows/backend-deploy.yml`
*   **Mechanism:** Shell Scripting via SSH.
*   **Process:** Clones code, injects `.env` variables securely, and runs `php artisan migrate`.
*   **Proof:**

![Laravel Welcome Page](laravel.png)
*Figure 2: Laravel Application connected to Private RDS.*

### 3. CloudWatch Monitoring
*   **Setup:** CPU Alerts configured via Terraform w/ SNS Notifications.
*   **Result:** Email alerts sent when CPU exceeds 50%.

| Frontend Alert | Backend Alert |
| :---: | :---: |
| ![Frontend Alert](frontend_alert.png) | ![Backend Alert](backend_alert.png) |

---

## 🚀 Deployment Instructions

### Prerequisites
*   Terraform installed.
*   AWS Credentials configured.

### Steps
1.  **Provision:**
    ```bash
    terraform init
    terraform apply -auto-approve
    ```
2.  **Access:**
    *   **Frontend:** `http://<FRONTEND_IP>:3001`
    *   **Backend:** `http://<BACKEND_IP>:8080`

---



