

## Download Files/Folders from AWS S3
- Download Folders
  ```sh
  aws s3 cp s3://path/to/some/folder ./local_folder --recursive
  # or
  aws s3 sync s3://path/to/some/folder ./local_folder --recursive
  ```


## Statistics on Buckets with Many Files
1. `(# files)` can be consulted with commands like the following:
  ```bash
  aws s3 ls s3://path/to/your/large/bucket/ --human-readable --summarize | tail -2
  Total Objects: 43223
     Total Size: 41.0 GiB
  ```

