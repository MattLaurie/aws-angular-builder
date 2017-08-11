# AWS Angular builder

A simple Docker container to build Angular apps with [Angular CLI](https://cli.angular.io/) and then push the resulting 
  build into [AWS](https://aws.amazon.com) environments such as [S3](http://docs.aws.amazon.com/AmazonS3/latest/dev/Welcome.html).
  
## Getting started

```
$ docker run -it mlaurie/aws-angular-builder ng --version
    _                      _                 ____ _     ___
   / \   _ __   __ _ _   _| | __ _ _ __     / ___| |   |_ _|
  / △ \ | '_ \ / _` | | | | |/ _` | '__|   | |   | |    | |
 / ___ \| | | | (_| | |_| | | (_| | |      | |___| |___ | |
/_/   \_\_| |_|\__, |\__,_|_|\__,_|_|       \____|_____|___|
               |___/
@angular/cli: 1.3.0
node: 6.11.2
os: linux x64
```

```
$ docker run -it mlaurie/aws-angular-builder aws --version
aws-cli/1.11.132 Python/2.7.9 Linux/4.4.0-89-generic botocore/1.5.95
```

```
$ docker run -it mlaurie/aws-angular-builder yarn --version
0.24.6
```

## Versions

| Tag | Angular CLI | AWS CLI |
|---|---|---|
| `latest` | `1.3.0` | `1.11.132` |
| `1.3.0` | `1.3.0` | `1.11.132` |
| `1.2.10` | `1.2.8` | `1.11.131` |
| `1.2.9` | `1.2.7` | `1.11.129` |
| `1.2.8` | `1.2.6` | `1.11.127` |
| `1.2.7` | `1.2.4` | `1.11.125` |
| `1.2.6` | `1.2.2` | `1.11.122` |
| `1.2.5` | `1.2.1` | `1.11.120` |
| `1.2.4` | `1.2.1` | `1.11.119` |
| `1.2.3` | `1.2.1` | `1.11.118` |
| `1.2.2` | `1.2.0` | `1.11.117` |
| `1.2.1` | `1.2.0` | `1.11.116` |
| `1.2.0` | `1.2.0` | `1.11.115` |
| `1.1.11` | `1.1.3` | `1.11.113` |
| `1.1.10` | `1.1.3` | `1.11.112` |
| `1.1.9` | `1.1.3` | `1.11.111` |
| `1.1.8` | `1.1.3` | `1.11.110` |
| `1.1.7` | `1.1.3` | `1.11.109` |
| `1.1.6` | `1.1.2` | `1.11.108` |
| `1.1.5` | `1.1.2` | `1.11.107` |
| `1.1.4` | `1.1.1` | `1.11.105` |
| `1.1.3` | `1.1.1` | `1.11.104` |
| `1.1.2` | `1.1.1` | `1.11.102` |
| `1.1.1` | `1.1.1` | `1.11.100` |
| `1.1.0` | `1.1.0` | `1.11.97` |
| `1.0.33` | `1.0.6` | `1.11.93` |
| `1.0.32` | `1.0.4` | `1.11.91` |
| `1.0.31` | `1.0.4` | `1.11.90` |
| `1.0.30` | `1.0.4` | `1.11.89` |
| `1.0.29` | `1.0.3` | `1.11.86` |
| `1.0.28` | `1.0.3` | `1.11.85` |
| `1.0.27` | `1.0.3` | `1.11.84` |
| `1.0.26` | `1.0.2` | `1.11.83` |
| `1.0.25` | `1.0.1` | `1.11.82` |
| `1.0.24` | `1.0.0` | `1.11.80` |
| `1.0.23` | `1.0.0` | `1.11.79` |
| `1.0.22` | `1.0.0` | `1.11.76` |
| `1.0.21` | `1.0.0` | `1.11.75` |
| `1.0.20` | `1.0.0` | `1.11.74` |
| `1.0.19` | `1.0.0` | `1.11.73` |
| `1.0.18` | `1.0.0` | `1.11.72` |
| `1.0.17` | `1.0.0` | `1.11.71` |
| `1.0.16` | `1.0.0` | `1.11.70` |
| `1.0.15` | `1.0.0` | `1.11.68` |
| `1.0.14` | `1.0.0` | `1.11.67` |
| `1.0.13` | `1.0.0` | `1.11.66` |
| `1.0.12` | `1.0.0-rc.4` | `1.11.66` |
| `1.0.11` | `1.0.0-rc.4` | `1.11.65` |
| `1.0.10` | `1.0.0-rc.4` | `1.11.64` |
| `1.0.9` | `1.0.0-rc.4` | `1.11.63` |
| `1.0.8` | `1.0.0-rc.2` | `1.11.63` |
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

It is recommended to use a tagged version (e.g. `mlaurie/aws-angular-builder:1.3.0`) within any continuous build system to 
  ensure known versions of the tools are used.

The latest stable version of Node will be used which is currently `6.11`.

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
  name: mlaurie/aws-angular-builder:1.3.0

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

Note you can update the image version `mlaurie/aws-angular-builder:1.3.0` used to the tagged version you require.
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
