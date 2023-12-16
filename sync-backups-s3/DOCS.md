## Configuration

In the Configuration tab, you'll find all the necessary parameters.

## IAM Permissions Policy 

The sync requires very minimal permissions in order to work. I'll strongly suggest to keep them as minimal as possible.

Here's a policy with required permissions:

```
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowAWSS3Sync",
            "Effect": "Allow",
            "Action": [
                "s3:ListBucket",
                "s3:GetObject",
                "s3:PutObject",
                "s3:DeleteObject",
                "s3:ListBucketMultipartUploads",
                "s3:AbortMultipartUpload"
            ],
            "Resource": [
                "arn:aws:s3:::YOUR-S3-BUCKET-NAME",
                "arn:aws:s3:::YOUR-S3-BUCKET-NAME/*"
            ]
        }
    ]
}
```

## How to use

The add-on does not run all the time, you have to manually start it every time you want your backup to be uploaded remotely.

You could automate the backup generation and remote sync with the following automation:

```
alias: Daily backup
description: Create a full backup every day at 2am and upload it to S3
trigger:
  - platform: time
    at: "02:00:00"
action:
  - service: hassio.backup_full
    data:
      name: "Full Backup of {{as_timestamp(trigger.now)|timestamp_custom('%Y-%m-%d', true)}}"
  - delay:
    minutes: 15
  - service: hassio.addon_start
    data:
      addon: XXXXX_sync-backups-on-s3
```
At 2AM a new backup will be created, and 15 minutes after that, the upload to s3 will start.
