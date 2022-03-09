# My Infrastructure Project

## Requirements

- python
- `~/.private` encrypted vault mounted for various passwords and keys
- ansible
- terraform

## setup

- `ansible-galaxy install -r requirements.yml` (not implemented at time of writing this)
  - `ansible-galaxy role install -r requirements.yml`
  - `ansible-galaxy collection install -r requirements.yml`
- `apache2-utils` contains `htpasswd` which can come in useful (e.g *htpasswd -nb
  username password*)

# Terraform

Uses Oracle Object storage for state.  Free account gets 10GB for free. 

Either `cd terraform/cloud` and run terraform command manually, or use the 
makefile in the root of the project.

* `make tfinit`
* `make tfplan`
* `make tfapply`

Terraform will only create instances, and configure dns. Any further software
configuration need to be done separately using Ansible (see below).

On Linode it will also manage the Linode firewall and assign new instances to 
this firewall.  SSH port number are changed to something more obscure.

# Ansible

## Dependencies

To install galaxy roles and collections:

* `make reqs`
* `make forcereqs`


* `make decrypt`
* `make encrypt`


## Structure

Ansible playbooks exists at 2 levels:  bootstrap and role.

### bootstrap

Bootstrap playbooks ensure that the deploy user and default non-root user
exists and that the keys to connect are copied to the host.
It may also rename the host if required (usually only needed for local raspberry pi's).

This is usually intended to be run only once and may not work if run again
due to hosts being renamed, etc.

I also update the package metadata at this point.   I do not actually install anything yet
but want to make sure package metadata exists.  Some roles expect it to be present and do 
not update packages before attempting to install anything, and this prevent things from breaking.

* `make bootstrap-raspbian` 

This will create the users and copy the keys. (some slight differences per environment - check
the makefile and actual playbooks)

* `HOSTNAME=newhostname make bootstrap-raspbian` 

This will also rename the host. Not relevant in every environment.   I prefer to run it through 
once without the new hostname just to confirm connectivity, and rerun with the new hostname.    
A reboot will be forced if a new hostname is specified.

### role based setup setup

The second stage is the repeatable role-based setup. This should be designed to run multiple times
without breaking anything.  The inventory file is used for role to host mappings. Everything else 
is including in these steps, and it is recommended to add the security roles as early in the playbook
as possible.

* `make feedserver`


The only exception is the dnsserver role, which has name resolution issues when it is down itself for updates,
so there is a intermediate step to get the actual pihole installation working as early as possible.

* `make dnssserver_local`
* install pihole manually
* `make dnsserver`


## Vault tools

Scripts to encrypt sensitive information into ansible vault.  Personal preference is
for vault files to be manually and explicitly included where needed, and not form
part of host_vars.   The password file option is included on the command line and
points to a encrypted volume on disk that can be mounted and unmounted when required.

Two scripts:
- encrypt passwords:  save both the encrypted password and password hash to a yaml file.  if one is not needed then it van be manually deleted.
- encrypt file contents:  save both file contents and file name to a yaml file.  I typically use this for certificates that need to be deployed.


## deploy user

New user, used with ssh key logins, passwordless sudo enabled.  Never use this
user for anything except remote ansible connections.

## run.sh script

The main script to configure the system.   Don't blindly run this more than once. For me
the main use is initial configuration of my own systems, so parts of it will cause
problems if run again.

Requires a yaml as first parameter.  A possible second argument to specify a single host
if the playbook does not limit itself to a single host.


# Thanks

Thanks to https://github.com/selfhostedshow/infra for a few ideas.



# raspbian: 

use pi
- all deploy
- all renamed

# cloud:

use root
all rsmit
- all deploy
- rename optional

# local ubuntu:

use rsmit
- all deploy
- rename optional

# desktop

use rsmit
- all deploy
- rename optional
