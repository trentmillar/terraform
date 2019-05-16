# Terraform Basics

Basic network and instance creation.

###OpenStack on RapidAccessControl/Cybera

Testing out Cybera but unfortunately there are limitations such as no access to routers, load balancers, only one predefined external network, and one floating IP.

I also found associating the floating IP to an instance failed.

from the `openstack` directory you can run, `terraform plan` then `terraform apply`, you will be promted for your tenant name, user name, and password. All of which can be downloaded off your cybera dashboard in the `OpenStack RC File v{n}` link 

