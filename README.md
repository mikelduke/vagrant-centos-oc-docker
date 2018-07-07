# vagrant-centos-oc-docker
Vagrantfile and scripts for an openshift demo VM on centos with docker

* install virtualbox
* install vagrant
* ```vagrant up```
* ```vagrant ssh```

start openshift cluster ```oc cluster up```

or try the sample script ```cd /vagrant/ && ./startup.sh```

you can even run oc with istio ```cd /vagrant && ./startup-with-istio.sh``` 
It takes a bit to start, run ```oc get po --all-namespaces``` to check if all the pods have finished starting.

Make sure git is configured to clone the repo with unix line endings LF not Windows CRLF, or you will need to convert the files in a text editor.
