```
kubectl apply -k github.com/ceph/ceph-csi/deploy/kubernetes/cephcsi-operator/v3.2.0/

```

```
kubectl create secret generic ceph-secret \
  --from-literal=key=<your-ceph-client-key> \
  --namespace=<namespace>

```

```
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: ceph-rbd
  annotations:
    storageclass.kubernetes.io/is-default-class: "true"  # Mark this as the default StorageClass
provisioner: rbd.csi.ceph.com
parameters:
  clusterID: <ceph-cluster-id>  # Replace with your Ceph cluster ID
  pool: rbd  # The Ceph pool where RBD images are stored
  imageFormat: "2"  # Image format (default is 2 for newer versions of Ceph)
  imageFeatures: layering  # Optional feature to enable RBD layering
  fsType: ext4  # File system type, change if needed (e.g., xfs, ext4)
  csi.storage.k8s.io/provisioner-secret-name: ceph-secret  # Secret containing Ceph credentials
  csi.storage.k8s.io/provisioner-secret-namespace: <namespace>  # Namespace where the secret is stored
  csi.storage.k8s.io/controller-expand-secret-name: ceph-secret  # Secret for expanding PVCs
  csi.storage.k8s.io/controller-expand-secret-namespace: <namespace>  # Namespace for the secret
  csi.storage.k8s.io/node-stage-secret-name: ceph-secret  # Secret for node-level access
  csi.storage.k8s.io/node-stage-secret-namespace: <namespace>  # Namespace for the secret

reclaimPolicy: Retain  # Retain the volume even after the PVC is deleted (optional)
volumeBindingMode: WaitForFirstConsumer  # Optional: Wait for pod scheduling before binding the volume

```