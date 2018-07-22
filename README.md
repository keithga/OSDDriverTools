# OSDDriverTools
Tools for the management of BIOS Firmware versions and settings

Currently Supporting Dell and HP. Lenovo not supported. 

# Setup

* This system was designed arround an MDT LiteTouch Deployment Share. 
* It can then be exported to a MDT Litetouch USB Media Share.
* There is a Sample Task Sequence under Server\ts.xml

There are two groups of scripts:

## Server

Scripts that help setup the server components for BIOS Firmware and settings

### Update-ServerBIOSSettingsTools.ps1 

You must install the Dell CCTK and HP BIOS Config Utilities manually

Once installed locally on your machine, you can *then* run this script to copy the necessary bits to the MDT Deployment Share. 

### Update-ServerBIOSFirware.ps1

Use this script to programatically download the correct BIOS Firmware updates for each selected Make/Model.

The script will use the out-gridview powershell cmdlet to allow you to select each Firmware Updates.

In addition to the selected Firmware Updates, this tool will also create a Dell.clixml and HP.clixml manifest on the MDT Litetouch Deployment Share for each client to parse. 

### Import-ServerBIOSSettings.ps1

This is an optional script. 

The BIOS Settings script that runs on the clients *expects* the BIOS Settings file to exist in a specific location on the deployment share, based on the Make and model. 

If you have already created BIOS Configuration scripts for a specific Make and Model of machine and didn't save the file in the specific format necessary this script would import each file and automatically copy the file to the correct location in the MDT LiteTouch Deployment Share.

## Client

Scripts that perform processing on the clients

### Update-ClientBIOSCommon.ps1

Common Library functions used by Update-ClientBIOSCommon.ps1 and Update-ClientBIOSSettings.ps1

### CheckPoint-ClientBIOSSettings.ps1

Script used to capture the BIOS Settings on the local machine and copy to the server.

WARNING: You *MUST* have permissions on the MDT Litetouch Server to run this command.

### Update-ClientBIOSFirmware.ps1

Update the BIOS Firmware on the local machine. 

This script will look into the Dell.clixml or HP.clixml control file on the MDT LiteTouch deployment share for the associated binary, and will then run the associated binary.

### Update-ClientBIOSSettings.ps1

This script will look on the MDT LiteTouch deployment share for the Make\ModelNumber.ini control Settings file and execute using the Dell or HP tools
