# injecting drivers into an offline image
[heres the refence doc for powershell](https://docs.microsoft.com/en-us/powershell/module/dism/add-windowsdriver?view=windowsserver2022-ps).

the neat part of this is that most manufacturers have driver packs design for this:

> [Dell Command | Deploy Driver Packs for Enterprise Client OS Deployment](https://www.dell.com/support/kbdoc/en-us/000124139/dell-command-deploy-driver-packs-for-enterprise-client-os-deployment?lang=en)


place the contents of those big archive in this location. this file wont get copied.

delete drivers not relavant to you for a smaller final image.


