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

var project_prefix = readEnvironmentVariable('PROJECT_PREFIX', '')
var project_suffix = readEnvironmentVariable('PROJECT_SUFFIX', '')

var windows_or_linux = readEnvironmentVariable('WINDOWS_OR_LINUX', 'windows')

param creds = {
  username: 'azureuser'
  password: '$tr0ngP@ssw0rd1234!'
  sshKey: ''
}

var vmName = 'vm-${project_prefix}'
var OS = windows_or_linux == 'windows' ? 'WindowsServer-2022-DataCenter' : 'Ubuntu-2004'

param common = {
  vmName: vmName
  vmImageReference: imageReference[OS]
  addressPrefix: '10.0.0.0/16'
  dnsLabelPrefix: toLower('${vmName}-${project_suffix}-${uniqueString(vmName)}')
  networkSecurityGroupName: 'nsg-${project_prefix}-${uniqueString(vmName)}'
  nicName: 'nic-${project_prefix}-${uniqueString(vmName)}'
  publicIPAllocationMethod: 'Dynamic'
  publicIpName: 'pip-${project_prefix}-${uniqueString(vmName)}'
  publicIpSku: 'Basic'
  storageAccountName: 'bdiags${windows_or_linux}${uniqueString(vmName)}'
  subnetName: 'subnet-${project_prefix}-${uniqueString(vmName)}'
  subnetPrefix: '10.0.0.0/24'
  virtualNetworkName: 'vnet-${project_prefix}-${uniqueString(vmName)}'
}
