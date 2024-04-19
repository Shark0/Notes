# Gitlab

## Ci CD 教學

### [youtube教學](https://www.youtube.com/watch?v=qP8kir2GUgo)
* 在專案資料夾第一層建立 .gitlab-ci.yml檔
* 撰寫測試pipeline
* 撰寫建置image
  * 撰寫Dockerfile在專案資料夾第一層
  * 在gitlab專案裝設定repository帳號(REGISTRY_USER) / 密碼(REGISTRY_PASSWORD)的project variable
* 發佈image
  * 在gitlab專案設定deploy server的ssh key(SSH_KEY)
  * 撰寫ssh command

### .gitlab-ci.yml 範例
```
variables:
    IMAGE_NAME: ${image_name}
    IMAGE_TAG: ${image_tag}  
${run_test_job_name}:
    stage: test
    image: {run_test_docker_image_name:version}
    befor-script:
        - ${intstall_test_tool_command1}
        - ${intstall_test_tool_command2}
    script: 
        - ${test_script_command1}
        - ${test_script_command2}
${build_image_job_name}:
    stage: build
    image: docker:20.10.16
    service:
        - docker:20.10.16-dind
    variables:
        DOCKER_TLS_CERTDIR: "certs/"        
    befor-script:
        - docker login -u $REGISTRY_USER -p $REGISTRY_PASSWORD
    script: 
        - docker build -t $IMAGE_NAME:$IMAGE_TAG .
        - docker push $IMAGE_NAME:$IMAGE_TAG
${deploy_image_job_name}:
    stage: deploy
    script:
        - ssh -i StrictHostKeyChecking=no -i $SSH_KEY ${user}@${deploy_server_host} "
            ${deploy_command}
        "
```