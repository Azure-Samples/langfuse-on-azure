param name string
param location string = resourceGroup().location
param tags object = {}

param containerEnvId string
param secrets array = []
param env array = []
param imageName string
param targetPort int = 80

resource containerApp 'Microsoft.App/containerapps@2022-03-01' = {
  name: name
  location: location
  tags: tags
  identity: {
    type: 'None'
  }
  properties: {
    managedEnvironmentId: containerEnvId
    configuration: {
      activeRevisionsMode: 'Single'
      ingress: {
        external: true
        targetPort: targetPort
      }
      secrets: secrets
    }
    template: {
      containers: [
        {
          image: imageName
          name: name
          env: env
          resources: {
            cpu: '0.5'
            memory: '1Gi'
          }
        }
      ]
      scale: {
        maxReplicas: 10
      }
    }
  }
}

output imageName string = imageName
output name string = containerApp.name
output uri string = 'https://${containerApp.properties.configuration.ingress.fqdn}'