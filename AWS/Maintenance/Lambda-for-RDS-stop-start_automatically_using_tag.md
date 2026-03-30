# How_to_Schedule_Lambda-for-RDS-stop-start_automatically_using_tag
### 1. Apply the following tag to RDS instance / cluster
- Please add below tag to all RDS instances which need to auto stop / start.
  - Key = AutoRestart
  - Value = True

