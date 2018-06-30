#!/bin/bash

#start cluster and run a hello world app
oc cluster up
oc new-project hello
oc new-app openshift/hello-openshift
oc expose svc/hello-openshift

sleep 10  #wait for pod to start
curl http://hello-openshift-hello.127.0.0.1.nip.io

oc new-project bookinfo

oc login -u system:admin
oc project bookinfo

oc adm policy add-scc-to-user anyuid -z istio-ingress-service-account -n istio-system
oc adm policy add-scc-to-user anyuid -z default -n istio-system
oc adm policy add-scc-to-user anyuid -z prometheus -n istio-system
oc adm policy add-scc-to-user anyuid -z istio-egressgateway-service-account -n istio-system
oc adm policy add-scc-to-user anyuid -z istio-citadel-service-account -n istio-system
oc adm policy add-scc-to-user anyuid -z istio-ingressgateway-service-account -n istio-system
oc adm policy add-scc-to-user anyuid -z istio-cleanup-old-ca-service-account -n istio-system
oc adm policy add-scc-to-user anyuid -z istio-mixer-post-install-account -n istio-system
oc adm policy add-scc-to-user anyuid -z istio-mixer-service-account -n istio-system
oc adm policy add-scc-to-user anyuid -z istio-pilot-service-account -n istio-system
oc adm policy add-scc-to-user anyuid -z istio-sidecar-injector-service-account -n istio-system

oc adm policy add-scc-to-user privileged -z default -n bookinfo

cd ~
curl -L https://git.io/getLatestIstio | sh -
export PATH=$PWD/istio-0.8.0/bin:$PATH

oc apply -f istio-0.8.0/install/kubernetes/istio-demo.yaml

oc label namespace bookinfo istio-injection=enabled

oc apply -f <(istioctl kube-inject -f istio-0.8.0/samples/bookinfo/kube/bookinfo.yaml)
istioctl create -f istio-0.8.0/samples/bookinfo/routing/bookinfo-gateway.yaml

oc get svc istio-ingressgateway -n istio-system

oc get po --all-namespaces

oc expose svc/productpage
oc expose svc/details
oc expose svc/ratings
oc expose svc/reviews

oc adm policy add-cluster-role-to-user cluster-admin dev
oc project istio-system
oc expose svc/tracing

curl -o /dev/null -s -w "%{http_code}\n" http://productpage-bookinfo.127.0.0.1.nip.io/productpage

# http://tracing-istio-system.127.0.0.1.nip.io/
