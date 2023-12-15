# Home Assistant Add-on: Sync Backups on S3

This add-on is meant to upload HomeAssistant backups to an AWS S3 bucket.

## Prerequisites

In order to use this add-on, you'll need an AWS account with:
- a S3 bucket
- a IAM user with access to the bucket above.

Be aware about all security implications of managing a AWS account and permissions in general.

## Installation

The installation of this add-on is pretty straightforward and no different to installing any other Home Assistant add-on.

1. Click the "Add Add-on Repository To My" button below to open the add-on on your Home Assistant instance, or manually add the repository `https://github.com/dral3x/ha-addons` in the Add-on Store.

    [![Add add-on repository to my Home Assistant](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Fdral3x%2Fha-addons)

2. Click the Home Assistant Show Add-on On My button below to open the add-on on your Home Assistant instance.
3. Click the "Install" button to install the add-on.
4. Enter the Configuration tab to set all missing options.
5. Start the add-on and check the logs for any error.

## Usage

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

## Credits 

This add-on is based on the work of [hassio-backup-s3](https://github.com/mikebell/hassio-backup-s3) and several other forks.