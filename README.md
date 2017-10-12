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
@angular/cli: 1.4.6
node: 6.11.3
os: linux x64
```

```
$ docker run -it mlaurie/aws-angular-builder aws --version
aws-cli/1.11.169 Python/2.7.9 Linux/4.10.0-35-generic botocore/1.7.24
```

```
$ docker run -it mlaurie/aws-angular-builder yarn --version
0.27.5
```

## Versions

| Tag | Angular CLI | AWS CLI |
|---|---|---|
| `latest` | `1.4.6` | `1.11.169` |
| `1.4.6` | `1.4.6` | `1.11.169` |
| `1.4.5` | `1.4.5` | `1.11.166` |
| `1.4.4` | `1.4.4` | `1.11.162` |
| `1.4.3` | `1.4.3` | `1.11.158` |
| `1.4.1` | `1.4.1` | `1.11.150` |

See [VERSIONS.md](https://github.com/MattLaurie/aws-angular-builder/blob/master/VERSIONS.md) for full version history.

**Note** from `1.4.3` onwards the version will track the Angular CLI version.  e.g. `mlaurie/aws-angular-builder:1.4.6` will be using Angular CLI 1.4.6.  Let me know if this causes an issue.

You can find more details about changes between versions in [CHANGELOG.md](https://github.com/MattLaurie/aws-angular-builder/blob/master/CHANGELOG.md).

The `latest` version will always be updated in response to releases of the Angular CLI and AWS CLI tools.

It is recommended to use a tagged version (e.g. `mlaurie/aws-angular-builder:1.4.6`) within any continuous build system to 
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
  name: mlaurie/aws-angular-builder:1.4.6

clone:
  depth: 1

pipelines:
  default:
    - step:
        script:
        - npm install
        - ng build
  branches:
    master:
      - step:
          script:
          - npm install
          - ng build --prod
          - sh ./deploy.sh
```

Note you can update the image version `mlaurie/aws-angular-builder:1.4.6` used to the tagged version you require.
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
