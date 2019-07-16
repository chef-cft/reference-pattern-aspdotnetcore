# Reference Architecture  - ASP.NET Core 
This repo provides reference architecture for deploying ASP.NET Core applications using [Habitat](https://habitat.sh) and [Terraform](https://terraform.io). 

>THIS REPO IS CURRENTLY UNDER DEVELOPMENT. Contact [Tom Finch](https://github.com/devopslifter) if you have any questions or want to collaborate.

## Deployed Environment
Fully deploying this environment gets you the following:

- SQL Server VM running SQL Server 2017 Express Edition as a habitat service `core/sqlserver`
- Two Web Servers (appserver1 and appserver2) running `devopslifter/nop-commerce` service binding to the above sql
- Load balancer VM running `core/haproxy` service binding to the above applications

## Demoing the environment
Clone this repo to a working directory on your development workstation.
Change your variables to reflect your region and keys.
Run `terraform init`
Run `terraform app`

Note that it may take upto 15 minutes after `terraform apply` completes before the application can be reached. You can view the habitat supervisor logs on the Windows nodes `Get-Content C:\hab\svc\windows-service\LOGS\Habitat.log -Wait` or Linux node `cat /var/log/messages&`

From a local browser `http://<public_ip_of_loadbalancer>` should bring up the web app.

## Requirements
- [Terraform](https://terraform.io)
- [AWS](https://aws.amazon.com/)

