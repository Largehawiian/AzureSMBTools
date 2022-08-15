function Join-AzureSMBAccount {
    param(
        [parameter(Mandatory = $True)][String]$SubscriptionId,
        [parameter(Mandatory = $True)][String]$ResourceGroupName,
        [parameter(Mandatory = $True)][String]$StorageAccountName,
        [parameter(Mandatory = $True)][String]$SamAccountName,
        [parameter(Mandatory = $True)][String]$OuDistinguishedName
    )
    Set-ExecutionPolicy -ExecutionPolicy Bypass Process
    If (Get-Module -ListAvailable Az.Network) {
        Import-module Az.Network
    }
    Else {
        Install-module Az.Network -Confirm:$False
        Import-module Az.Network
    }
    If (Get-Module -ListAvailable Az.Storage) {
        Import-module Az.Storage
    }
    Else {
        Install-module Az.Storage -Confirm:$False
        Import-module Az.Storage
    }
    If (Get-Module -ListAvailable Az.Resources) {
        Import-module Az.Resources
    }
    Else {
        Install-module Az.Resources -Confirm:$False
        Import-module Az.Resources
    }
    $DomainAccountType = "ComputerAccount"
    $EncryptionType = "AES256"
    Invoke-WebRequest -Uri "https://github.com/Azure-Samples/azure-files-samples/releases/download/v0.2.4/AzFilesHybrid.zip" -OutFile "AzFilesHybrid.Zip"
    Expand-Archive -Path AzFilesHybrid.Zip
    .\CopyToPSPath.ps1
    Import-Module -Name AzFilesHybrid
    Select-AzSubscription -SubscriptionId $SubscriptionId
    Connect-AzAccount
    Join-AzStorageAccount `
        -ResourceGroupName $ResourceGroupName `
        -StorageAccountName $StorageAccountName `
        -SamAccountName $SamAccountName `
        -DomainAccountType $DomainAccountType `
        -OrganizationalUnitDistinguishedName $OuDistinguishedName `
        -EncryptionType $EncryptionType
}