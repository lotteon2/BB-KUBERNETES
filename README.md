## file usage 
### config-local-create.sh 
```shell
Enter your GitHub username: 
Enter your GitHub personal access token: 
Enter your encrypt secret key: 
```
#### execute file 
```shell 
mac: sh config-local-create.sh
wsl: ./config-local-create.sh
```

### down-selected.sh
끄고 싶은 서비스를 선택해서 종료할 수 있다. 

### off.sh
모든 서비스를 종료한다 

### one-start.sh
원하는 서비스를 선택해서 켤 수 있다. 

### pv-remote.sh 
모든 persistence volume 설정을 삭제할 수 있다 

### start.sh 
kafka, redis, mongodb, discovery, config, api geteway, orderquery를 켜고 나머지 원하는 서비스를 켤 수 있다. 

### terminate.sh 
모든 service, persistence volume, statefulset, db config 등 모든 설정 및 서비스를 종료한다. 

