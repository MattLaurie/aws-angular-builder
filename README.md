# AWS Angular builder

A simple Docker container to build Angular apps with [Angular CLI](https://cli.angular.io/) and then push the resulting 
  build into [AWS](https://aws.amazon.com) environments such as [S3](http://docs.aws.amazon.com/AmazonS3/latest/dev/Welcome.html).
  
## Getting started

```
$ docker run -it mlaurie/aws-angular-builder ng --version

                             _                           _  _
  __ _  _ __    __ _  _   _ | |  __ _  _ __         ___ | |(_)
 / _` || '_ \  / _` || | | || | / _` || '__|_____  / __|| || |
| (_| || | | || (_| || |_| || || (_| || |  |_____|| (__ | || |
 \__,_||_| |_| \__, | \__,_||_| \__,_||_|          \___||_||_|
               |___/
@angular/cli: 1.0.0-beta.32.3
node: 6.9.5
os: linux x64
```

```
$ docker run -it mlaurie/aws-angular-builder aws --version
aws-cli/1.11.52 Python/2.7.9 Linux/4.4.0-62-generic botocore/1.5.15
```

## Versions
 
| Tag | Angular CLI | AWS CLI |
|---|---|---|
| `latest` | `1.0.0-beta.32.3`  | `1.11.52`  |
| `1.0.0` | `1.0.0-beta.32.3`  | `1.11.52`  |

You can find more details about changes between versions in [CHANGELOG.md](https://github.com/MattLaurie/aws-angular-builder/blob/master/CHANGELOG.md).

The `latest` version will always be updated as updates are made to the Angular CLI and AWS CLI tools.  A decision will 
  be made in the future as to what changes in the underlying tools constitutes a major bump in this repositories 
  version tag numbers.
 
While it is expected that the `latest` version will be the most commonly used version, it is recommended to use a 
  specific tagged version in your automated builds to ensure that you are always using a known version of the tools.

To use a specific tagged version append it to the repository name e.g. `docker pull mlaurie/aws-angular-builder:1.0.0` for the 
  `1.0.0` version.

## Example: Using with Bitbucket Pipelines

The primary use case for this Docker container is to integrate with 
  [Bitbucket Pipelines](https://bitbucket.org/product/features/pipelines) such that a project can be built and deployed 
  to S3.
  
For example, the following configuration will accomplish two things:

1. any push to a non-master branch will perform a basic build
1. any push to a master branch will perform a production build and then push the resulting files to a S3 bucket   

`bitbucket-pipelines.yml`:
```
image:
  name: mlaurie/aws-angular-builder:latest

clone:
  depth: 1

pipelines:
  default:
    - step:
        script:
        - npm install
        - ng build -aot
  branches:
    master:
      - step:
          script:
          - npm install
          - ng build -prod -aot -e prod --stats-json
          - sh ./deploy.sh
```

Note it is recommended to replace `latest` in `mlaurie/aws-angular-builder:latest` with a specific tagged version listed 
**Versions** above. 

`deploy.sh`:
```
#!/bin/bash
export AWS_ACCESS_KEY_ID=$awsAccessKeyId
export AWS_SECRET_ACCESS_KEY=$awsSecretAccessKeyPassword
export AWS_DEFAULT_REGION=us-east-1

BUCKET_TARGET=$awsBucketTarget

aws s3 cp dist/ s3://$BUCKET_TARGET --recursive --acl public-read
```

Where `$awsAccessKeyId`, `$awsSecretAccessKeyPassword` and `$awsBucketTarget` are environment variables specified 
  within Bitbucket Pipelines.  It's recommended to use secret environment variables for the AWS credentials.

Note that both `bitbucket-pipelines.yml` and `deploy.sh` need to be within the repository.

