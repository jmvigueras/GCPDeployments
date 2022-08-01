# Deployment of FortiGate-VM HA on the Google Cloud Platform (GCP)
## Introduction
A Terraform script to deploy FortiGate-VM HA (A-P) on GCP multi Virtual Private Cloud (VPC)

## Requirements
* [Terraform](https://learn.hashicorp.com/terraform/getting-started/install.html) >= 0.12.0
* Terraform Provider for Google Cloud Platform >=2.11.0
* Terraform Provider for Google Cloud Platform Beta >=2.13
* Terraform Provider for random 2.2.1
* Terraform Provider for template 2.1.2
* A [GCP OAuth2 access token](https://developers.google.com/identity/protocols/OAuth2)

## Deployment overview
Terraform deploys the following components:
   - A VPC with one public subnet - port1 FTG
   - A VPC INTERNAL - port2 FTG
   - A VPC SPOKE1 - port4 FTG
   - A VPC SPOKE2 - port5 FTG
   - A VPC MGMT and HA - port 3 FTG for management and ha
   - Two FortiGate-VM instances with five NICs
   - Firewall rules for allowing traffic to public interface from internal, spoke1 and spoke2, also between spokes.

## Deployment
To deploy the FortiGate-VM to GCP:
1. Clone the repository.
2. Obtain a GCP OAuth2 token and input it in the vars.tf file.
3. Customize variables in the `vars.tf` file as needed.
4. Initialize the providers and modules:
   ```sh
   $ cd XXXXX
   $ terraform init
    ```
5. Submit the Terraform plan:
   ```sh
   $ terraform plan
   ```
6. Verify output.
7. Confirm and apply the plan:
   ```sh
   $ terraform apply
   ```
8. If output is satisfactory, type `yes`.

Output will include the information necessary to log in to the FortiGate-VM instances:
```sh
FortiGate-HA-Cluster-IP = XXX.XXX.XXX.XXX
FortiGate-HA-Master-MGMT-IP = XXX.XXX.XXX.XXX
FortiGate-HA-Slave-MGMT-IP = XXX.XXX.XXX.XXX
FortiGate-Password = <password here>
FortiGate-Username = admin
```

## Destroy the instance
To destroy the instance, use the command:
```sh
$ terraform destroy
```

# Support
Fortinet-provided scripts in this and other GitHub projects do not fall under the regular Fortinet technical support scope and are not supported by FortiCare Support Services.
For direct issues, please refer to the [Issues](https://github.com/fortinet/fortigate-terraform-deploy/issues) tab of this GitHub project.
For other questions related to this project, contact [github@fortinet.com](mailto:github@fortinet.com).

## License
[License](https://github.com/fortinet/fortigate-terraform-deploy/blob/master/LICENSE) © Fortinet Technologies. All rights reserved.