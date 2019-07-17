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
    

Angular CLI: 8.1.1
Node: 10.16.0
OS: linux x64
Angular: 
... 

Package                      Version
------------------------------------------------------
@angular-devkit/architect    0.801.1
@angular-devkit/core         8.1.1
@angular-devkit/schematics   8.1.1
@schematics/angular          8.1.1
@schematics/update           0.801.1
rxjs                         6.4.0
```

```
$ docker run -it mlaurie/aws-angular-builder aws --version
aws-cli/1.16.198 Python/2.7.13 Linux/4.15.0-54-generic botocore/1.12.188
```

```
$ docker run -it mlaurie/aws-angular-builder yarn --version
1.16.0
```

## Versions

| Tag | Angular CLI | AWS CLI |
|---|---|---|
| `latest` | `8.1.1` | `1.16.198` |
| `8.1.1` | `8.1.1` | `1.16.198` |
| `7.3.9` | `7.3.9` | `1.16.159` |

See [VERSIONS.md](https://github.com/MattLaurie/aws-angular-builder/blob/master/VERSIONS.md) for full version history.

**Note** from `1.4.3` onwards the version will track the Angular CLI version.  e.g. `mlaurie/aws-angular-builder:8.1.1` will be using Angular CLI 8.1.1.  Let me know if this causes an issue.

You can find more details about changes between versions in [CHANGELOG.md](https://github.com/MattLaurie/aws-angular-builder/blob/master/CHANGELOG.md).

The `latest` version will always be updated in response to releases of the Angular CLI and AWS CLI tools.

It is recommended to use a tagged version (e.g. `mlaurie/aws-angular-builder:8.1.1`) within any continuous build system to 
  ensure known versions of the tools are used.

The latest stable version of Node will be used which is currently `6.11`.

## Building it yourself

The script `check-update.sh` will check for updates for Angular CLI and AWS CLI.  

```
$ ./check-update.sh
Checking for updates
Angular CLI	7.3.9 -> 8.1.1
AWS CLI		1.16.159 -> 1.16.198
Run "check-update.sh -u" to update the Dockerfile
```

Running `check-update.sh` with the `-u` option will update the `Dockerfile` with the updated versions.

```
$ ./check-update.sh -u
Checking for updates
Angular CLI	7.3.9 -> 8.1.1
AWS CLI		1.16.159 -> 1.16.198
Run "check-update.sh -u" to update the Dockerfile
Updated Dockerfile with latest versions
```

Note this all relies on `jq` being installed.  See (https://stedolan.github.io/jq/) for details.


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
  name: mlaurie/aws-angular-builder:8.1.1

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

Note you can update the image version `mlaurie/aws-angular-builder:8.1.1` used to the tagged version you require.
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

