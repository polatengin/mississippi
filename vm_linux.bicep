param location string = resourceGroup().location

param creds object = {
  username: ''
  password: ''
  sshKey: ''
}

param common object = {
  vmName: ''
  addressPrefix: ''
  dnsLabelPrefix: ''
  networkSecurityGroupName: ''
  nicName: ''
  publicIPAllocationMethod: ''
  publicIpName: ''
  publicIpSku: ''
  storageAccountName: ''
  subnetName: ''
  subnetPrefix: ''
  virtualNetworkName: ''
}

module vm_commons './vm_commons.bicep' = {
  name: common.vmName
  params: {
    location: location
    addressPrefix: common.addressPrefix
    dnsLabelPrefix: common.dnsLabelPrefix
    networkSecurityGroupName: common.networkSecurityGroupName
    nicName: common.nicName
    publicIPAllocationMethod: common.publicIPAllocationMethod
    publicIpName: common.publicIpName
    publicIpSku: common.publicIpSku
    storageAccountName: common.storageAccountName
    subnetName: common.subnetName
    subnetPrefix: common.subnetPrefix
    virtualNetworkName: common.virtualNetworkName
  }
}

resource vm_linux 'Microsoft.Compute/virtualMachines@2023-09-01' = {
  name: common.vmName
  location: location
  properties: {
    hardwareProfile: {
      vmSize: 'Standard_D2s_v5'
    }
    osProfile: {
      computerName: common.vmName
      adminUsername: creds.username
      linuxConfiguration: {
        disablePasswordAuthentication: true
        ssh: {
          publicKeys: [
            {
              path: '/home/${creds.username}/.ssh/authorized_keys'
              keyData: creds.sshKey
            }
          ]
        }
      }
    }
    storageProfile: {
      imageReference: common.vmImageReference
      osDisk: {
        createOption: 'FromImage'
        managedDisk: {
          storageAccountType: 'StandardSSD_LRS'
        }
      }
      dataDisks: [
        {
          diskSizeGB: 1023
          lun: 0
          createOption: 'Empty'
        }
      ]
    }
    networkProfile: {
      networkInterfaces: [
        {
          id: vm_commons.outputs.nic_id
        }
      ]
    }
    diagnosticsProfile: {
      bootDiagnostics: {
        enabled: true
        storageUri: vm_commons.outputs.blob_endpoint
      }
    }
  }
}
