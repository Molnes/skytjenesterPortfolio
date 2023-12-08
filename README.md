# skytjenesterPortfolio
## Report
### Choice of cloud services and tools
I chose to use Github Actions as my CI/CD tool, OpenStack as my cloud provider, and Terraform as my IaC tool.
I chose Github Actions because of its ease of use and integration with Github. I chose OpenStack because we get it free from NTNU and I chose a fork of Terraform called OpenTofu because of its popularity and integration with OpenStack.

### My system 

My system is a simple endpoint written in Golang that returns an HTML body with hello world and the current timestamp. It is deployed on a VM in OpenStack and is accessible through a floating IP. The VM is created using Terraform and the deployment is (kinda) done using GitHub Actions (more on that later).

### Architecture Overview
I deploy to a VM in OpenStack with an Ubuntu 22.04 image. The deployment is done by building a docker image and pushing it to Docker Hub. The VM then pulls the image from Docker Hub and runs it. The VM is accessible through a floating IP that is assigned to it when it is created.

It uses a 1cpu 2 GB RAM flavor and a 20 GB volume (which comes standard with the image I chose).

### Development
1. The first iteration was to create a simple endpoint that returns an HTML body with hello world and the current timestamp. This was done using Golang and the net/http package.
2. The second iteration was to create a Dockerfile that builds the application and runs it. This was done using a multi-stage build.
3. The third iteration was to create a Terraform file that creates a VM in OpenStack. This was done using the OpenTofu fork of Terraform.
4. The fourth iteration was to create a Github Actions workflow that builds the application, builds the docker image, pushes it to Docker Hub, and then runs the Terraform file to create the VM.

### Experiences
I had some trouble with the GitHub Actions workflow. NTNU's OpenStack is not accessible from the outside, so while the workflow is capable of creating the infrastructure and deploying the application, it was being blocked by NTNU's firewall.

The workflow can and is testing the application and building the docker image, but it cannot deploy it.
To get around this I had to manually create the infrastructure and deploy the application by running the terraform fork, tofu, locally.

Other than that I had no real difficulties. I had some trouble with the Terraform file, but that was mostly because of my lack of experience with Terraform.