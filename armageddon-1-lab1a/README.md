# my-armageddon-project-1
### Group Leader: Omar Fleming
### Team Leader: Larry Harris
### First meeting 01-04-25
### Time: 2pm - 4:30 est.
----

Members present: 
- Larry Harris
- Kelly D Moore
- Dennis Shaw
- Logan T
- Tre Bradshaw
- Bryce Williams
- Jasper Shivers (Jdollas)
- Ted Clayton
- Torray
- Zeek-Miller
- Jay Mallard

-----
Minutes:
- created and instructed everyone to create a Terraform repo in Github to share notes and test the Terraform builds
- went through Lab 1a discussed, seperated Larry's main.tf into portions. We tested trouble shot, spun up the code. Dennis will upload to github and after Larry looks through it, will make it available for everyone to download
- everyone inspect, test and come back with any feedback, suggestions and or comments
- Here is the 1st draft diagram. We want to hear if you guys have any feedback or suggestions for this as well.
  

![first draft diagram](./screen-captures/lab1a-diagram.png)

-------
### Project Infrastructure
VPC name  == bos_vpc01  
Region = US East 1   
Availability Zone
- us-east-1a
- us-east-1b 
- CIDR == 10.26.0.0/16 

|Subnets|||
|---|---|---|
|Public|10.26.101.0/24|10.26.102.0/24|  
|Private|10.26.101.0/24| 10.26.102.0/24|

### .tf file changes 
- Security Groups for RDS & EC2

    - RDS (ingress)
    - mySQL from EC2

- EC2 (ingress)
    - student adds inbound rules (HTTP 80, SSH 22 from their IP)

*** reminder change SSH rule!!!

