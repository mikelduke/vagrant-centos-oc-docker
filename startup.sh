#!/bin/bash

#start cluster and run a hello world app
oc cluster up
oc login -u system:admin
oc new-app openshift/hello-openshift
oc expose svc/hello-openshift

sleep 10  #wait for pod to start
curl http://hello-openshift-myproject.127.0.0.1.nip.io
