# Reference Architecture  - ASP.NET Core 
This repo provides reference architecture for deploying ASP.NET Core applications using [Habitat](https://habitat.sh) and [Terraform](https://terraform.io). 

>THIS REPO IS CURRENTLY UNDER DEVELOPMENT. Contact [Tom Finch](https://github.com/devopslifter) if you have any questions or want to collaborate.

## Deployed Environment
Fully deploying this environment gets you the following:

- SQL Server VM running SQL Server 2017 Express Edition as a habitat service `core/sqlserver`
- Two Web Servers (appserver1 and appserver2) running `devopslifter/nop-commerce` service binding to the above sql
- Load balancer VM running `core/haproxy` service binding to the above applications

## Demoing the Environment as a Reference Pattern
Clone this repo to a working directory on your development workstation.
cd to `nopcommerce/terraform/aws/`
Change your variables to reflect your region and keys.
Run `terraform init`
Run `terraform app`

Note that it may take upto 15 minutes after `terraform apply` completes before the application can be reached. You can view the habitat supervisor logs on the Windows nodes `Get-Content C:\hab\svc\windows-service\LOGS\Habitat.log -Wait` or Linux node `cat /var/log/messages&`

From a local browser `http://<public_ip_of_loadbalancer>` should bring up the web app.

## Demoing the Environment as Habitat for Applications
You will need access to a Windows workstation to develop the NopCommerce application package. To create a Cloud instance look at https://github.com/chef-cft/habitat_windows_workstation

Clone this repo to a working directory on your Windows development workstation.
Run `Habitat Setup` and ensure you use your own origin and its corresponing personal access token.
Enter a Habitat Studio `hab studio enter` and then build the application `build`.
Upload your newly built package to the habitat depo `hab pkg upload <path to your .hart file>` promote this to stable.

Once you have the application package available from the Habitat depo under your origin you are ready to demo.

***Note do not destroy your cloud Windows workstation if you are using one, it will be needed for the demo***

Clone this repo to a working directory on your development workstation (The machine you will run Terraform from).
cd to `nopcommerce/terraform/aws/`.
Change your variables to reflect your region, keys and Habitat origin.
Run `terraform init`
Run `terraform app`.

Note that it may take upto 15 minutes after `terraform apply` completes before the application can be reached. You can view the habitat supervisor logs on the Windows nodes `Get-Content C:\hab\svc\windows-service\LOGS\Habitat.log -Wait` or Linux node `journalctl -fu hab-sup.service`

From a local browser `http://<public_ip_of_loadbalancer>` should bring up the web app.

On your Windows workstation make a change to the following file in your editor of choice:

`reference-pattern-aspdotnetcore/src/Presentation/Nop.Web/Themes/DefaultClean/Content/css/styles.css`

Modify `background-color` at line 66 to be any colour you want.
Update the `plan.ps1` to be version `0.1.1`.
Enter a Habitat Studio `hab studio enter` and then build the application `build`.
Upload your newly built package to the habitat depo `hab pkg upload <path to your .hart file>`.
RDP to either Windows app servers and show the service log by running `Get-Content C:\hab\svc\windows-service\LOGS\Habitat.log -Wait`.
Promote your new package to stable in the Habitat depo.
Wait for the new service to be loaded on the Windows app server.
***hard refresh*** your website URL (loadbalancer URL) Ctrl and click the Reload button (Windows) or Hold ⇧ Shift and click the Reload button (Mac).
Your website should now show with a new background colour.


## Requirements
- [Terraform](https://terraform.io)
- [AWS](https://aws.amazon.com/)

