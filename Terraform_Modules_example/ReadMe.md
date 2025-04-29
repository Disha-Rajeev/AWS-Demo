# Terrafrom Modules Example

This is Demo of Terraform modules.
You have to mention your specifics in Terraform_Modules_example/main.tf file.

You can check the generic setup in Terraform_Modules_example/modules/ec2-instance folder. 
Once after verifying every setup is what you are looking for, then proceed with the following steps,

### Terraform installation

```bash
https://developer.hashicorp.com/terraform/install
```
Install based on your system specifications

### AWS installation

```bash
https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html
```
Install based on your system specification

### AWS Configure

```bash
aws configure
```
Find your access key and secret access key from your AWS profile. Give the defualt region and output type.

### Terrafrom Steps

```bash
terraform init  
``` 
Initializes the terrafrom.

```bash
terraform plan
``` 
Plans the setup you are looking for, Here instance setup and requirements will be planned according to the code.

```bash
terraform apply  
``` 
Will apply all of the setting and create ec2 instance in this given example

Once finished working on and testing your projects make sure to delete the instance if you are using for personal experiment.
```bash
terraform destroy  
``` 
