## Steps to deploy custom autonity binary for investigating acn peers count issue

### 1. Download custom binary using curl 

```
curl -L -o autonity https://github.com/clearmatics/services-testnet-agc/raw/master/autonity-v1.0.2-alpha-test/autonity

```

### 2. Check Autonity version it show commit message as below-
```
./autonity version 

Autonity
Version: 1.0.2-alpha
Git Commit: 545a8f94ada16fa7703faa3ef70948cd3fc3d15d
Git Commit Date: 20250128
Architecture: amd64
Protocol Versions: [66]
Go Version: go1.22.0
Operating System: linux
```

### 3. Pause the validator node and wait for the current epoch to end
```
aut validator pause --validator <validator_address> | aut tx sign - | aut tx send -
```

### 4. Stop the validator node
```
systemctl stop autonity
```

### 5. Replace the autonity binary, run Step 2 again to confirm it is copied correctly.

### 6. Start the autonity node
```
systemctl stop autonity
```

### 7. Wait for it to sync fully to the latest height

### 8. Activate the validator and wait for the current epoch to end
```
aut validator activate --validator <validator_address> | aut tx sign - | aut tx send -
```
### 9. Share logs - Upload the syslogs manually to the bucket
```
gsutil cp "compressed_log_file_name" "gs://autonity-bakerloo-logs-zuka116"
```
