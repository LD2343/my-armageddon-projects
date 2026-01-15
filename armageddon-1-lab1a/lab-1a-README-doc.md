examples: https://github.com/cloudposse/terraform-example-module

# Foundational Elements
1. Module Overview: A brief description in the README.md explaining the module's purpose and the problem it solves.
2. Detailed Inputs: A comprehensive list of all input variables, including their types, default values, and clear descriptions, often in a machine-generated table for accuracy.
3. Useful Outputs: A summary of the module's outputs, detailing what each output represents and how it can be used by other configurations or modules.
Comprehensive Examples: An examples/ directory or section in the README that provides simple, runnable configurations showing how to use the module in different scenarios.
4. Requirements: A clear specification of required Terraform and provider versions.
5. Licensing and Contributing Guidelines: Information on the project's license (e.g., Apache 2.0) and a CONTRIBUTING.md file with guidelines for new contributors. 


getting started

If you have an existing repository that was started using the terragrunt-infrastructure-modules-example repository as a starting point, follow the migration guide for help in adjusting your existing configurations to take advantage of the patterns outlined in this repository.

To use this repository, you'll want to fork this repository into your own Git organization.

The steps for doing this are the following:

Create a new Git repository in your organization (e.g. GitHub, GitLab).

[!TIP] You typically shouldn't have any sensitive information in this repository, as it will only contain generic infrastructure patterns that can be provisioned in any environment, but you might want to have this repository be private regardless.

Create a bare clone of this repository somewhere on your local machine.

git clone --bare https://github.com/gruntwork-io/terragrunt-infrastructure-catalog-example.git
Push the bare clone to your new Git repository.

cd terragrunt-infrastructure-catalog-example.git
git push --mirror <YOUR_GIT_REPO_URL> # e.g. git push --mirror git@github.com:acme/terragrunt-infrastructure-catalog-example.git
Remove the local clone of the repository.

cd ..
rm -rf terragrunt-infrastructure-catalog-example.git
(Optional) Delete the contents of this usage documentation from your fork of this repository.

(Optional) Create a release for the new repository (e.g. GitHub, GitLab). You'll want to do this early and often as you make changes to the infrastructure patterns in your fork.


prerequisites