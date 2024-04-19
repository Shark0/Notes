# Service
## Create service
```
SC CREATE ${service} binPath= ${bin_path} start= auto DisplayName= "${service_name}" binPath= "${service_exe_path}"
```
## Stop service
```
SC STOP ${service_name}
```
## Delete service
```
SC DELETE ${service_name}
```