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
@angular/cli: 1.0.0-rc.1
node: 6.9.5
os: linux x64
```

```
$ docker run -it mlaurie/aws-angular-builder aws --version
aws-cli/1.11.61 Python/2.7.9 Linux/4.4.0-64-generic botocore/1.5.24
```

## Versions
 
| Tag | Angular CLI | AWS CLI |
|---|---|---|
| `latest` | `1.0.0-rc.1` | `1.11.61` |
| `1.0.7` | `1.0.0-rc.1` | `1.11.61` |
| `1.0.6` | `1.0.0-rc.1` | `1.11.60` |
| `1.0.5` | `1.0.0-rc.1` | `1.11.59` |
| `1.0.4` | `1.0.0-rc.1` | `1.11.58` |
| `1.0.3` | `1.0.0-rc.1` | `1.11.57` |
| `1.0.2` | `1.0.0-rc.1` | `1.11.56` |
| `1.0.1` | `1.0.0-rc.0` | `1.11.52` |
| `1.0.0` | `1.0.0-beta.32.3` | `1.11.52` |

You can find more details about changes between versions in [CHANGELOG.md](https://github.com/MattLaurie/aws-angular-builder/blob/master/CHANGELOG.md).

The `latest` version will always be updated in response to releases of the Angular CLI and AWS CLI tools.

It is recommended to use a tagged version (e.g. `mlaurie/aws-angular-builder:1.0.7`) within any continuous build system to 
  ensure known versions of the tools are used.

## Example: Using with Bitbucket Pipelines

The primary use case for this Docker container is to integrate with 
  [Bitbucket Pipelines](https://bitbucket.org/product/features/pipelines) such that an Angular project can be built and deployed 
  to S3.
  
For example, the following configuration will accomplish two things:

1. any push to a non-master branch will perform a basic build
1. any push to a master branch will perform a production build and then push the resulting files to a S3 bucket   

`bitbucket-pipelines.yml`:
```
image:
  name: mlaurie/aws-angular-builder:1.0.7

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
          - ng build -prod -aot -e prod
          - sh ./deploy.sh
```

Note you can update the image version `mlaurie/aws-angular-builder:1.0.7` used to the tagged version you require.
  You can use `latest` but please be aware that `latest` will track the latest versions of the tools which 
  may contain breaking changes.

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
  within Bitbucket Pipelines.  It is recommended to use secret environment variables for the AWS credentials.

Note that both `bitbucket-pipelines.yml` and `deploy.sh` need to be within the repository.
