echo "# 🚀 Terraform + Flask App on AWS EC2

This project demonstrates how to provision AWS infrastructure using Terraform and deploy a simple Flask web application on an EC2 instance.

---

## 📁 Project Structure

\`\`\`
├── main.tf            # Terraform resources: VPC, EC2, SG, etc.
├── variables.tf       # Variable definitions (e.g., VPC CIDR block)
├── app.py             # Simple Flask web application
├── README.md          # Project documentation
├── .gitignore         # Git ignored files
\`\`\`

---

## 🧩 What This Project Does

- Provisions AWS infrastructure using Terraform:
  - VPC, Subnet, Route Table, Internet Gateway
  - Security Group with SSH and HTTP access
  - EC2 instance using \`t3.micro\` (Free Tier eligible)
- Transfers and runs a Flask app using Terraform \`file\` and \`remote-exec\` provisioners

---

## 🖥️ Flask App

A basic Flask app (\`app.py\`) that shows:

\`\`\`
Congratulations! You have done your first complete demo.
\`\`\`

---

## ⚙️ Prerequisites

- Terraform
- AWS CLI with configured credentials (\`~/.aws/credentials\`)
- Python 3.x (for Flask)
- OpenSSH key pair in \`~/.ssh/id_rsa\` and \`~/.ssh/id_rsa.pub\`
- Git

---

## 🛠️ Setup Instructions

### 1. Clone the repository

\`\`\`bash
git clone https://github.com/Disha-Rajeev/AWS-Demo.git
cd AWS-Demo
\`\`\`

### 2. Customize variables

Edit \`variables.tf\` if needed (e.g., VPC CIDR)

### 3. Initialize and apply Terraform

\`\`\`bash
terraform init
terraform apply
\`\`\`

### 4. Access the app

Once deployed, copy the EC2 Public IP and visit:

\`\`\`
http://<public-ip>:5000
\`\`\`

---

## 🧹 Cleanup

To delete all provisioned resources:

\`\`\`bash
terraform destroy
\`\`\`

---

## 🛡️ Security Tips

- Never push your private key (\`id_rsa\`) to GitHub.
- Use \`.gitignore\` to exclude sensitive files.

---

## 🎯 Learning Outcomes

- Use Terraform for real-world infrastructure provisioning
- Automate app deployment with EC2 + SSH + provisioners
- Understand basic networking and resource dependencies on AWS

---

## 📜 License

This project is licensed under the MIT License." > README.md
