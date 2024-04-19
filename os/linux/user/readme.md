# User
## User
### Add User
```
adduser ${user}
```
### Delete User
```
userdel -r ${user}
```

### Set User Password
```
passwd ${user}
```

### Change user
``` 
su ${user}
```

## Group
### Create Group
```
sudo groupadd ${group} 
```
### Set User Can Use Sudo
```
usermod -a -G wheel ${user} #wheel群組可以用sudo 
```

### Add User to Group 
```
usermod -a -G ${group1},${group2},${group3} ${user}
```

