# Project Missisippi

To deploy a _Windows_ or _Linux_ _Virtual Machine_ to _Azure_, using _Bicep_, it's easier if the vm module splitted into two separate files for [Windows](./vm_windows.bicep) and [Linux](./vm_linux.bicep).

To create a _Virtual Machine_, it's also needed to create several resources, such as _Virtual Network_, _Public IP_, _Network Security Group_, _Network Interface_, and _Storage Account_.

In this project, there is a [vm_commons.bicep](./vm_commons.bicep) file that contains the resources that are common to both _Windows_ and _Linux_ _Virtual Machines_.

The [vm_windows.bicep](./vm_windows.bicep) file contains only the _Windows_ _Virtual Machine_ resource, and the reference to the [vm_commons.bicep](./vm_commons.bicep) module.

The [vm_linux.bicep](./vm_linux.bicep) file contains only the _Linux_ _Virtual Machine_ resource, and the reference to the [vm_commons.bicep](./vm_commons.bicep) module.

[vm.bicepparam](./vm.bicepparam) is the parameter file for both of the _Virtual Machine_ modules.

Both [vm_windows.bicep](./vm_windows.bicep) and [vm_linux.bicep](./vm_linux.bicep) files have the following parameters to create common resources and vm specific resources:

```bicep
param creds object

param common object
```

The `creds` parameter is used to pass `username` and `password`, or `username` and `sshkey` pairs for the _Virtual Machine_, based on the _Operating System_.

The `common` parameter is used to pass the `addressPrefix`, `dnsLabelPrefix`, `virtualNetworkName`, `subnetName`, `publicIpName`, `networkSecurityGroupName`, `nicName`, `publicIPAllocationMethod`, `subnetPrefix`, `publicIpSku` and `storageAccountName` for the _Virtual Machine_.

## References

- [Creating Ubuntu Virtual Machine using Bicep](https://learn.microsoft.com/en-us/azure/virtual-machines/linux/quick-create-bicep?tabs=CLI)
- [Creating Windows Virtual Machine using Bicep](https://learn.microsoft.com/en-us/azure/virtual-machines/windows/quick-create-bicep?tabs=CLI)
