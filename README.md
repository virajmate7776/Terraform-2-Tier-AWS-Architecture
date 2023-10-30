

# Two Tier Architecture Application on AWS using Terraform


<br>
<br>
<br>


  ![image](https://github.com/virajmate7776/Terraform-2-Tier-AWS-Architecture/assets/117629972/36f2079f-3b1d-4e80-97d2-35cd79a44066)


<br> 
<br>



### Prerequisite

<br>

1.	Code Editor installed on your machine(VS Code) 

2.	Terraform installed on your machine 

3.	Basic understanding and working knowledge about different services like EC2, VPC, Security groups, RDS, Route53, Load Balancer, Auto Scaling groups and Amazon Certificate Manager, CloudFront.

<br>

### Create IAM User

<br>

1.	Click on the user tab in the left corner. now click on the add user button on the top right corner and give the name to the user.

<br>

2.	Now we need to attach the Policy for the user. We should follow the Principle of least privilege but we need to use many services to here you can give AdministratorAccess. but it is not at all advisable to give AdministratorAccess OR we can attach the policy accordingly. 
<br>

3.	Now click on the next button and click on the Create User button.

<br>
 
![image](https://github.com/virajmate7776/Terraform-2-Tier-AWS-Architecture/assets/117629972/8c56808b-e17c-4a81-b387-7241de3089ea)

<br>

![image](https://github.com/virajmate7776/Terraform-2-Tier-AWS-Architecture/assets/117629972/4994993c-aa55-4a39-bbf5-8df5b2d906a8)

<br>

![image](https://github.com/virajmate7776/Terraform-2-Tier-AWS-Architecture/assets/117629972/9dda696b-13de-4477-9f21-03bf5178350f)


<br>

 

### Create Access and Secret Key

<br>

1.	Select the user that you have created just now. click on the security credentials tab. below you will find an option with the name Create Acess key just click on it. 

<br>

2.	After that select CLI and mark the checkbox below and click on the Next button, give some description about it. and then click on the Create Access key button here you will see your Access Key ID and Secret Key. 

<br>

3.	Make sure to download it because you won't be able to see it once you close your window. and remember DO NOT SHARE THE KEY with anyone.

<br> 

![image](https://github.com/virajmate7776/Terraform-2-Tier-AWS-Architecture/assets/117629972/5f8b86af-9e9c-4d1e-b940-e449d52617a2)

<br>

![image](https://github.com/virajmate7776/Terraform-2-Tier-AWS-Architecture/assets/117629972/ed8ccf82-defb-4438-9a57-081fee1e2367)

<br> 





### Write Terraform files

<br>

   Now write code for your infrastructure. but before you jump on it we are going to   best practices while writing code.

<br>

Store state files on remote location

<br>

1.	Storing state files on remote location is always a good practice 

<br>

2.	So let's first create an s3 bucket to save the state file on a remote location.  just head over to s3 and click on create bucket button, give any name to your bucket and click on Create a bucket.


 

![image](https://github.com/virajmate7776/Terraform-2-Tier-AWS-Architecture/assets/117629972/e889d4cc-80a3-48be-927e-842776826c81)

<br>

![image](https://github.com/virajmate7776/Terraform-2-Tier-AWS-Architecture/assets/117629972/9dc8c5f4-721a-4f4f-8c8c-79c065f8acdf)

<br>

### Create DynamoDB table for State-locking 

<br>

1.	Create DynamoDB table for State-locking so that we can keep tfstate file consistent while working on a collaborative project

<br>

2.	Go to the DynamoDB service dashboard and click on create table button. Give your table name whatever you want but in Partition Key give the name LockID (NOTE: it is case sensitive) then only DynamoDB will be able to lock the file and release the file. and then click on create table button. The locking system is just like the semaphore that we have studied in the Operating system and here tfstate file is a critical section, so two processes should not access it simultaneously.


<br>

![image](https://github.com/virajmate7776/Terraform-2-Tier-AWS-Architecture/assets/117629972/ce84d2e1-31a3-45ff-8662-746bc8258a2f)

<br>

![image](https://github.com/virajmate7776/Terraform-2-Tier-AWS-Architecture/assets/117629972/15d3c535-e90c-498a-90c4-6f7fb21b649d)



<br>


 

 

### Create a Hosted Zone in Route 53

<br>

1.	In this case, I have used my custom domain name registered with GoDaddy.

<br>

2.	Register your domain name in Route 53 and create a Hosted Zone with the same name as your Domain Name.

<br>

3.	Now will route traffic through our custom domain. 

<br>

![image](https://github.com/virajmate7776/Terraform-2-Tier-AWS-Architecture/assets/117629972/96054c5b-09c4-48b7-8fd8-ca37e40d7a44)

<br>

![image](https://github.com/virajmate7776/Terraform-2-Tier-AWS-Architecture/assets/117629972/8b75c213-4b3e-4bf9-b537-aae4a74f54bf)

<br> 

 






 
<br>
 

1.	After creating Hosted Zone in Route 53, go to GoDaddy’s website, login to your account with your username and password. 

<br>

2.	Go to Domains, select your domain name and go to manage dns.

<br>

3.	Click on Edit nameservers and copy and paste the nameservers given by AWS in route 53 for your domain name.

<br>




 
![image](https://github.com/virajmate7776/Terraform-2-Tier-AWS-Architecture/assets/117629972/2cbbc791-702b-4617-8f3e-96da213ae005)

<br>

![image](https://github.com/virajmate7776/Terraform-2-Tier-AWS-Architecture/assets/117629972/1ee3051c-a7f7-44e8-a0a7-db6bfcd69026)

<br>

![image](https://github.com/virajmate7776/Terraform-2-Tier-AWS-Architecture/assets/117629972/a9770b0d-5596-4cc2-84fc-cf56dedaf3ba)



 <br>
 <br>


  


1.	Make sure you have a valid certificate in Issued status, if not , create one and use the domain name on which you are planning to host your application.

2.	Go to AWS console then go to AWS Certificate Manager (ACM) and create request a certificate.


 <br>

![image](https://github.com/virajmate7776/Terraform-2-Tier-AWS-Architecture/assets/117629972/78630f07-894d-478e-a4c8-29ec84751972)


<br>

![image](https://github.com/virajmate7776/Terraform-2-Tier-AWS-Architecture/assets/117629972/c068623c-0bb7-4934-832c-5553026f1acf)

<br>


![image](https://github.com/virajmate7776/Terraform-2-Tier-AWS-Architecture/assets/117629972/51bb91da-7fac-4c7e-b6f2-13dcb9d00ce5)

 
<br>

 
<br>



### Create AWS profile for terraform user and provide Access key and Secret key for the user.

 <br>
 
![image](https://github.com/virajmate7776/Terraform-2-Tier-AWS-Architecture/assets/117629972/0212842e-3f76-419d-8496-5c52032f74bd)

<br>
<br>


Now Execute Terraform Commands

<br>

1.	terraform init 

<br>

This initializes Terraform in a directory, downloading any required providers. It should be run once when setting up a new Terraform config.

<br>



![image](https://github.com/virajmate7776/Terraform-2-Tier-AWS-Architecture/assets/117629972/b00b2725-a723-4aeb-a426-1a8a807e81d8)

<br>




 




2.	terraform plan 

<br>

This generates an execution plan to show what Terraform will do when you call apply. You can use this to preview the changes Terraform will make.

<br>

![image](https://github.com/virajmate7776/Terraform-2-Tier-AWS-Architecture/assets/117629972/8880b370-de65-49e9-ba8e-3d9916234ecb)


<br>


3.	terraform apply 

<br>

This executes the actions proposed in the plan and actually provisions or changes your infrastructure.

 ![image](https://github.com/virajmate7776/Terraform-2-Tier-AWS-Architecture/assets/117629972/0f354c5d-99f6-4e13-b8b9-fbd26c0fc2cb)

<br>

### Outputs

<br>

#### 1	VPC

 <br>

![image](https://github.com/virajmate7776/Terraform-2-Tier-AWS-Architecture/assets/117629972/14b9e1f6-0ca6-4a91-8a34-b36237f060d9)


<br>

#### 2	Routing Table

<br>

 ![image](https://github.com/virajmate7776/Terraform-2-Tier-AWS-Architecture/assets/117629972/f406843d-53a9-4d70-aa3d-225dae848625)

<br>


#### 3	NAT gateways

 <br>

![image](https://github.com/virajmate7776/Terraform-2-Tier-AWS-Architecture/assets/117629972/9962a141-b71f-4cc8-9f19-a9253fde66de)

<br>

#### 4	Security Groups

<br>

 ![image](https://github.com/virajmate7776/Terraform-2-Tier-AWS-Architecture/assets/117629972/830f23c5-2d36-44b7-8f16-f5ac2fb22fc1)

<br>

#### 5	Launch Templates

<br> 


![image](https://github.com/virajmate7776/Terraform-2-Tier-AWS-Architecture/assets/117629972/78ea580f-c522-4c49-b325-1eda0a3a6f8b)

<br>


#### 6	Auto Scaling Groups

 <br>

![image](https://github.com/virajmate7776/Terraform-2-Tier-AWS-Architecture/assets/117629972/11ad717c-eb85-4551-a1ed-27626fcd54a6)

<br>

7	EC2 Servers

<br>

 ![image](https://github.com/virajmate7776/Terraform-2-Tier-AWS-Architecture/assets/117629972/fcba949f-0f12-4eb7-9e0f-20f512cfab6f)


<br>

#### 8	Application Load Balancer

<br>

 ![image](https://github.com/virajmate7776/Terraform-2-Tier-AWS-Architecture/assets/117629972/2a4a6564-698e-4aad-aec1-064ca6f00282)

<br>

#### 9	Target Groups

<br>

 ![image](https://github.com/virajmate7776/Terraform-2-Tier-AWS-Architecture/assets/117629972/512d2d50-db99-4079-9455-a9bccf6e7232)


<br>


#### 10	RDS Instance

<br>

![image](https://github.com/virajmate7776/Terraform-2-Tier-AWS-Architecture/assets/117629972/9b6f8c5a-0a63-4d73-96f3-93d20beafba2)

<br>
 

#### 11	Route 53 Record

<br>


 ![image](https://github.com/virajmate7776/Terraform-2-Tier-AWS-Architecture/assets/117629972/9d1fc52b-b8ce-41a3-ad17-fccda9e44a90)


<br>

#### 12	CloudFront Distribution

<br>

![image](https://github.com/virajmate7776/Terraform-2-Tier-AWS-Architecture/assets/117629972/6ee0487e-4a5d-43a5-b2b5-93f6fd5108f2)

 
<br>


Now Copy the Public Domain Name of Load Balancer and paste it on the browser.

   <br>
   
   We can access our Application on Browser using Public Domain Name of Application Load Balancer.

<br>
 
![image](https://github.com/virajmate7776/Terraform-2-Tier-AWS-Architecture/assets/117629972/95e15259-dfd1-4c72-9fa1-fb65d2b6cc51)

<br>

We can also access our Application using CloudFronts Domain Name.

 
<br>

![image](https://github.com/virajmate7776/Terraform-2-Tier-AWS-Architecture/assets/117629972/6d937730-92ed-43eb-8ccc-2dce05418c17)

 <br>






<br>


 


 


 

We can  see the State file (terraform.tfstate) in s3 bucket in json format.

<br>

![image](https://github.com/virajmate7776/Terraform-2-Tier-AWS-Architecture/assets/117629972/f66e2cd7-e9c7-414b-a572-8c2d901b8d14)

<br> 

We can Also see the lock has generated in DynamoDB table.

<br>

![image](https://github.com/virajmate7776/Terraform-2-Tier-AWS-Architecture/assets/117629972/46b35bfc-834c-4cca-94b1-c7033c668f79)

<br>

![image](https://github.com/virajmate7776/Terraform-2-Tier-AWS-Architecture/assets/117629972/b31d1aea-d98b-444e-b2f1-cb24964d2462)

<br>

![image](https://github.com/virajmate7776/Terraform-2-Tier-AWS-Architecture/assets/117629972/71ccf6ee-f4bd-4ba0-a146-fab97f7d254e)

<br> 

![image](https://github.com/virajmate7776/Terraform-2-Tier-AWS-Architecture/assets/117629972/0f0f54dd-762f-43df-a63c-c2cda7e4c476)

 <br>

 

At last, do not forget to run terraform destroy command to destroy all the created resources.



