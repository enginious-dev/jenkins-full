### Description
Jenkins image with bundled OpenJDK-11, Maven-3.6.3 and Docker-20.10.4

For k8s use follow this sample `yml` file:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: jenkins-full-deployment
  labels:
    app: jenkins
spec:
  replicas: 1
  selector:
    matchLabels:
      app: jenkins
  template:
    metadata:
      labels:
        app: jenkins
    spec:
      volumes:
      - name: jenkins-data
        persistentVolumeClaim:
          claimName: jenkins-vc
      - name: dind-storage
        emptyDir: { }
      containers:
      - name: jenkins
        image: enginious/jenkins-full:latest
        env:
        - name: DOCKER_HOST
          value: "tcp://localhost:2375"
        volumeMounts:
        - name: jenkins-data
          mountPath: /var/jenkins_home/
          readOnly: false
      - name: dind
        image: docker:dind
        env:
          - name: DOCKER_TLS_CERTDIR
            value: ""
        securityContext:
          privileged: true
        volumeMounts:
        - name: dind-storage
          mountPath: /var/lib/docker
```

### After setup
We defined env vars (already included in `PATH`):
```shell
DOCKER_HOME=/opt/docker
MAVEN_HOME=/opt/maven
```
Simply configure these in *Manage Jenkins -> Global Tool Configuration*, all done! 
