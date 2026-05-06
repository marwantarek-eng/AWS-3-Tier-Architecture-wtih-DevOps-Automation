# 🚀 3-Tier AWS Infrastructure Automation & Deployment

![Terraform](https://img.shields.io/badge/Terraform-7B42BC?style=for-the-badge&logo=terraform&logoColor=white)
![Ansible](https://img.shields.io/badge/Ansible-EE0000?style=for-the-badge&logo=ansible&logoColor=white)
![AWS](https://img.shields.io/badge/Amazon_AWS-232F3E?style=for-the-badge&logo=amazon-aws&logoColor=white)
![Docker](https://img.shields.io/badge/Docker-2496ED?style=for-the-badge&logo=docker&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
![Node.js](https://img.shields.io/badge/Node.js-43853D?style=for-the-badge&logo=node.js&logoColor=white)

A production-ready, highly secure, and automated 3-tier architecture deployed on Amazon Web Services (AWS). This project provisions the underlying infrastructure using **Terraform**, orchestrates containerized application deployment using **Ansible** & **Docker**, and implements strict network isolation best practices.

👨‍💻 Developed by:
  • Omar Hesham
  • Ahmed Kamel
  • Marwan Tarek
  • Adham Mamdouh

🎓 Affiliation: Information Technology Institute (ITI) - System Administration Intensive Program

---

## 🏗️ Architecture Overview
![AWS 3-Tier Architecture Diagram](<img width="1400" height="782" alt="WhatsApp Image 2026-05-06 at 5 02 49 PM" src="https://github.com/user-attachments/assets/6fe21caa-8650-461c-8b8c-31ee56747c81" />
)

The core objective of this architecture is **Total Total Isolation** and robust security. The traffic flows strictly in a unidirectional path, ensuring that the backend application and database are completely shielded from the public internet.

**Traffic Flow:**
`User` ➔ `External ALB` ➔ `Frontend Subnet (Nginx/HTML)` ➔ `Internal ALB` ➔ `Backend Subnet (Node.js/API)` ➔ `Database Subnet (PostgreSQL RDS)`

### Key Security & Design Features:
*   **VPC & Subnetting:** Custom VPC with 8 Subnets spread across 2 Availability Zones (Multi-AZ) for high availability.
*   **Strict Security Groups:** The Backend EC2 instances only accept traffic from the Internal ALB. The RDS instance only accepts SSL-encrypted traffic from the Backend EC2 instances.
*   **Nginx Reverse Proxy:** The frontend container serves the UI and acts as a reverse proxy, forwarding `/api/*` requests internally to the Backend Load Balancer.
*   **Immutable Infrastructure:** EC2 instances are provisioned via Auto Scaling Groups (ASG) and Launch Templates.
*   **Configuration Management:** Ansible dynamically fetches Terraform outputs (like ALB DNS and RDS endpoints) to configure and deploy Docker containers seamlessly.

---

## 📸 Project Showcase

### 1. The Application (Frontend UI)
A modern, responsive Notes application featuring a Glassmorphism UI/Dark Mode design.

![Frontend Application](https://github.com/OmarHesham249/AWS-3-Tier-Architecture-wtih-DevOps-Automation/blob/main/Screenshots/Application%20from%20browser.png) 

### 2. The API (Backend Response)
Successful communication between the Frontend, Internal ALB, Backend, and PostgreSQL database returning JSON data.

![API Response](https://github.com/OmarHesham249/AWS-3-Tier-Architecture-wtih-DevOps-Automation/blob/main/Screenshots/image%20api-notes.png)

### 3. AWS Console (Target Groups & Health Checks)
Demonstrating healthy EC2 instances dynamically registered to External and Internal Application Load Balancers.

![AWS Target Groups](https://github.com/OmarHesham249/AWS-3-Tier-Architecture-wtih-DevOps-Automation/blob/main/Screenshots/target%20groups.png)

### 4. Infrastructure (VPC & Auto Scaling)
Showcasing the isolated network design and highly available compute resources.

![AWS VPC](https://github.com/OmarHesham249/AWS-3-Tier-Architecture-wtih-DevOps-Automation/blob/main/Screenshots/vpc.png)
![Instances](https://github.com/OmarHesham249/AWS-3-Tier-Architecture-wtih-DevOps-Automation/blob/main/Screenshots/The%204%20instances%20are%20running.png)

### 5. Security & Database Tier
Showcasing the strict Security Groups enforcing total isolation, alongside the fully managed PostgreSQL RDS instance deployed in the private data tier.

![Security Groups](https://github.com/OmarHesham249/AWS-3-Tier-Architecture-wtih-DevOps-Automation/blob/main/Screenshots/security%20groups.png)
![PostgreSQL RDS](https://github.com/OmarHesham249/AWS-3-Tier-Architecture-wtih-DevOps-Automation/blob/main/Screenshots/Database%20CLI.png)

---

## 🛠️ Technology Stack

*   **Infrastructure as Code (IaC):** Terraform (VPC, Subnets, NAT/IGW, Route Tables, ALB, ASG, RDS, Security Groups).
*   **Configuration Management:** Ansible (Docker installation, Environment variable injection, Docker Compose execution).
*   **Containerization:** Docker & Docker Compose (Public images hosted on Docker Hub).
*   **Frontend:** HTML, CSS, Vanilla JavaScript, Nginx (Reverse Proxy).
*   **Backend:** Node.js, Express, `pg` (PostgreSQL Client with SSL verification).
*   **Database:** Amazon RDS (PostgreSQL 15).

---

## ⚙️ How to Deploy

### Prerequisites
*   AWS CLI configured with appropriate permissions.
*   Terraform installed.
*   Ansible installed on a Jump Server/Control Node.
*   An SSH Key pair (`MyKey.pub`) available in your local `~/.ssh/` directory.

### Step 1: Provision Infrastructure (Terraform)
Navigate to the terraform directory and apply the configuration:
```bash
terraform init
terraform plan
terraform apply --auto-approve
```

Take note of the output variables (RDS Endpoint, External ALB DNS, Internal ALB DNS, and Jump Server IP).

### Step 2: Configure Servers (Ansible)
SSH into the provisioned Jump Server, update the inventory.ini with the new private IPs, and run the setup playbook to install Docker:

```bash
ansible-playbook -i inventory.ini setup_docker.yml
```

### Step 3: Deploy the Application (Ansible)
Update the deploy_app.yml with the dynamic endpoints generated by Terraform, then execute the deployment:

```bash
ansible-playbook -i inventory.ini deploy_app.yml
```

### Step 4: Access the App
Navigate to the External_ALB_DNS provided by the Terraform output in your web browser.
