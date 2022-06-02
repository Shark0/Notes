# Push Over SSH + Telegram Notification
```
pipeline {
    agent any
    stages {
        stage('Build Project') {
        	steps([$class: 'BapSshPromotionPublisherPlugin']) {
            	sshPublisher(
                	continueOnError: false, failOnError: true,
                	publishers: [
                    	sshPublisherDesc(
                        	configName: "dev",
                        	verbose: true,
                        	transfers: [
                            	sshTransfer(execCommand: "sh /home/root/project/build.sh")
                        	]
                    	)
                	]
            	)
        	}
        }
    post {
        success {
    	    telegramSend(message:'專案開發環境建置成功',chatId:${channelId})
        }
        failure {
            telegramSend(message:'專案開發環境建置失敗',chatId:${channelId})
        }    
    }
}
```