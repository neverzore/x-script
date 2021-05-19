

kubeadm init \
    --control-plane-endpoint "k8s-cluster" --upload-certs \
    --image-repository registry.aliyuncs.com/google_containers \
    --pod-network-cidr=172.19.0.0/16

kubeadm join k8s-cluster:6443 --token iahzqe.n3c4h9c1uosynegj \
    --discovery-token-ca-cert-hash sha256:2d92f470948621a6b5f8d9b668bf65515dc5d4386e2f664c43791601b090e95e \
    --control-plane --certificate-key ca8d2fe0a20b7fbf419aca48b4481f9968d6fce376bbfc80728fbf526c20bae1

kubeadm join k8s-cluster:6443 --token 8jtxmi.7xgqtqbjavwss3z9 \
    --discovery-token-ca-cert-hash sha256:5e057765aaaa6e6e642591b210ed39dec67df643b4cb3a7ca4405641e79c50b9

kubeadm join k8s-cluster:6443 --token 8jtxmi.7xgqtqbjavwss3z9 \
    --discovery-token-ca-cert-hash sha256:5e057765aaaa6e6e642591b210ed39dec67df643b4cb3a7ca4405641e79c50b9 \
    --control-plane --certificate-key 9a92d52e8000c475eb9f4699e11955c3b8431cd189e8c3305ee1571245740b06
# To make kubectl work for your non-root user, run these commands, which are also part of the kubeadm init output:

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
# Alternatively, if you are the root user, you can run:

export KUBECONFIG=/etc/kubernetes/admin.conf

sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
#https://kubernetes.io/zh/docs/setup/production-environment/tools/kubeadm/create-cluster-kubeadm/#pod-network


# Your Kubernetes control-plane has initialized successfully!

# To start using your cluster, you need to run the following as a regular user:

#   mkdir -p $HOME/.kube
#   sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
#   sudo chown $(id -u):$(id -g) $HOME/.kube/config

# Alternatively, if you are the root user, you can run:

#   export KUBECONFIG=/etc/kubernetes/admin.conf

# You should now deploy a pod network to the cluster.
# Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
#   https://kubernetes.io/docs/concepts/cluster-administration/addons/

# You can now join any number of the control-plane node running the following command on each as root:

#   kubeadm join k8s-cluster:6443 --token iahzqe.n3c4h9c1uosynegj \
#     --discovery-token-ca-cert-hash sha256:2d92f470948621a6b5f8d9b668bf65515dc5d4386e2f664c43791601b090e95e \
#     --control-plane --certificate-key ca8d2fe0a20b7fbf419aca48b4481f9968d6fce376bbfc80728fbf526c20bae1

# Please note that the certificate-key gives access to cluster sensitive data, keep it secret!
# As a safeguard, uploaded-certs will be deleted in two hours; If necessary, you can use
# "kubeadm init phase upload-certs --upload-certs" to reload certs afterward.

# Then you can join any number of worker nodes by running the following on each as root:

# kubeadm join k8s-cluster:6443 --token iahzqe.n3c4h9c1uosynegj \
#     --discovery-token-ca-cert-hash sha256:2d92f470948621a6b5f8d9b668bf65515dc5d4386e2f664c43791601b090e95e