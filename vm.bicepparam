using 'vm_windows.bicep'

var imageReference = {
  'Ubuntu-1804': {
    publisher: 'Canonical'
    offer: 'UbuntuServer'
    sku: '18_04-lts-gen2'
    version: 'latest'
  }
  'Ubuntu-2004': {
    publisher: 'Canonical'
    offer: '0001-com-ubuntu-server-focal'
    sku: '20_04-lts-gen2'
    version: 'latest'
  }
  'Ubuntu-2204': {
    publisher: 'Canonical'
    offer: '0001-com-ubuntu-server-jammy'
    sku: '22_04-lts-gen2'
    version: 'latest'
  }
  'WindowsServer-2022-DataCenter': {
    publisher: 'MicrosoftWindowsServer'
    offer: 'WindowsServer'
    sku: '2022-datacenter-azure-edition'
    version: 'latest'
  }
}

param creds = {
  username: 'azureuser'
  password: '$tr0ngP@ssw0rd1234!'
  sshKey: ''
}

var vmName = 'vm-common'
var OS = 'WindowsServer-2022-DataCenter'

param common = {
  vmName: vmName
  vmImageReference: imageReference[OS]
  addressPrefix: '10.0.0.0/16'
  dnsLabelPrefix: toLower('${vmName}-${uniqueString(vmName)}')
  networkSecurityGroupName: 'default-NSG'
  nicName: 'myVMNic'
  publicIPAllocationMethod: 'Dynamic'
  publicIpName: 'myPublicIP'
  publicIpSku: 'Basic'
  storageAccountName: 'bootdiags${uniqueString(vmName)}'
  subnetName: 'Subnet'
  subnetPrefix: '10.0.0.0/24'
  virtualNetworkName: 'myVNET'
}
