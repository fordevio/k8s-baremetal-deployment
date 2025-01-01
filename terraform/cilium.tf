
resource "helm_release" "cilium" {
  name = "cilium"
  repository = "https://helm.cilium.io/" 
  chart = "cilium"
  version = "1.16.5"
  namespace = "kube-system"
  set {
    name  = "hubble.relay.enabled"
    value = "true"
  }

  set {
    name  = "hubble.ui.enabled"
    value = "true"
  }

  set {
    name="prometheus.enabled"
    value = true
  }

  set {
    name="operator.prometheus.enabled"
    value = true 
  }

  set {
    name="hubble.metrics.enableOpenMetrics"
    value = true
  }

  set {
    name="kubeProxyReplacement"
    value = true 
    
  }

  set {
    name="gatewayAPI.enabled"
    value = true 
  }
  

}