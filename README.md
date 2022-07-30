# Tibco Archival
 
This project is developed to migrate on-premise acknowledgment files to the S3 (AWS Simple Storage Service) bucket. The on-premise files are XML files that are encrypted using GnuPG (i.e GPG) and zipped. This project is responsible for extracting and decrypt those files and again encrypting them using AWS KMS CMK (Customer managed key) and finally storing them inside the S3 bucket. The storage class of the object is decided based on the timestamp in the filename. If the files are older than 3 months then the storage class is automatically set to Glacier else the files are moved inside Standard class.
 
---
 
#### Main AWS Services utilized
 
- AWS Lambda
- AWS S3
- AWS Key Management Service
- AWS VPC
- AWS S3 Endpoint
- AWS CloudWatch
 
#### Getting started
 
There are two ways to run this project: 
1. Build the package using local maven installation and then take the compiled jar and manually upload it in the lambda. The jar file will be generated inside the target folder.
 
2. Create a Jenkins pipeline and point it to use the **Jenkinsfile** provided inside the repo, it will automatically compile and upload the java archive in a preconfigured S3 bucket, you can use the URL of that S3 object and paste it in the Lambda. 
 
> Note: For this step to work properly, you need to configure maven inside Jenkins and you also need an Ansible server.
 
#### Configuration of the required AWS architecture
 
All the necessary resources required to run this project can be configured by creating a Jenkins job and running the CloudFormation script provided inside this repository [wis-archive-playbook](https://github.aus.thenational.com/wis-ansible/wis-archive-playbook)
 
#### Lambda environment variables
 
- **batchSize** : number of files that will be processed in single invocation of lambda. (default 200)
- **bucketName** : name of the destination bucket where the files will be stored once they are processed successfully.
- **http_proxy** : http proxy used by the KMS services inside the private VPC to connect to other services like KMS.
- **https_proxy** : https proxy used for the same functionality as http_proxy
- **keyArn** : ARN of the customer managed key that is used to encrypt the files inside source bucket.
- **no_proxy**: it is used for communication within VPC and the services that have dedicated VPC Endpoint.
- **passphrase**: passphrase of the GPG secret key.
- **privateKeyBucket**: bucket inside which the private GPG key is stored.
- **region**: region in which the lambda function is deployed.
- **sourceBucketName**: source bucket from which the files are picked for processing.
- **sourcePath**: path inside the EFS used for storing and processing the files temporarily.
 
#### Testing
 
 
You can invoke the lambda function manually to test the archival process.
 
##### Steps:
    
1. Put some files in the **source** S3 bucket.
2. Search for the lambda function and switch to the test tab.
3. In the input for the test delete the sample provided their and just type ""
4. Click on test.
5. The files inside the source s3 bucket will be deleted and processed files will be present inside the archival bucket.
    
# test
