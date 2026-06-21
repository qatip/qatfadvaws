# Print-Statefile.ps1
# Lab 4 - Remote State & Multiple Environments on AWS
# Shows whether Terraform is currently using no state, local state, or an AWS S3 remote backend.
#
# Intended lab flow:
# 1. Before terraform init/apply: no state file should be present.
# 2. After first local terraform apply: local terraform.tfstate should be present.
# 3. After backend migration: backend cache should show the selected S3 bucket/key.

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$BackendCachePath = ".terraform/terraform.tfstate"
$LocalStatePath   = "terraform.tfstate"
$LockFilePath     = ".terraform.lock.hcl"

function Read-JsonFile {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    return (Get-Content -Path $Path -Raw | ConvertFrom-Json)
}

function Get-ConfigValue {
    param(
        [Parameter(Mandatory = $true)]
        [object]$Config,

        [Parameter(Mandatory = $true)]
        [string]$Name
    )

    if ($null -eq $Config) {
        return "<missing>"
    }

    if ($Config.PSObject.Properties.Name -contains $Name) {
        $Value = $Config.$Name

        if ($null -ne $Value -and "$Value".Trim().Length -gt 0) {
            return "$Value"
        }
    }

    return "<missing>"
}

function Get-FileStatus {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Path
    )

    if (Test-Path -Path $Path) {
        $Item = Get-Item -Path $Path
        return "present, size $($Item.Length) bytes, modified $($Item.LastWriteTime)"
    }

    return "not present"
}

function Write-Section {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Title
    )

    Write-Host ""
    Write-Host $Title
    Write-Host ("-" * $Title.Length)
}

Write-Host ""
Write-Host "Terraform State Location Check"
Write-Host "=============================="
Write-Host "Working folder: $(Get-Location)"

$HasBackendCache = Test-Path -Path $BackendCachePath
$HasLocalState   = Test-Path -Path $LocalStatePath
$HasLockFile     = Test-Path -Path $LockFilePath

Write-Section "File check"
Write-Host "terraform.tfstate:            $(Get-FileStatus $LocalStatePath)"
Write-Host ".terraform/terraform.tfstate: $(Get-FileStatus $BackendCachePath)"
Write-Host ".terraform.lock.hcl:          $(Get-FileStatus $LockFilePath)"

if (-not $HasBackendCache -and -not $HasLocalState) {
    Write-Section "Interpretation"
    Write-Host "No Terraform state file has been found in this folder."
    Write-Host ""
    Write-Host "This is the expected result before running terraform init/apply for the first time."
    Write-Host ""
    exit 0
}

if (-not $HasBackendCache -and $HasLocalState) {
    Write-Section "State location"
    Write-Host "LOCAL STATE"
    Write-Host ""
    Write-Host "Terraform state is currently stored in the local terraform.tfstate file."
    Write-Host "No backend cache exists yet in .terraform/terraform.tfstate."
    Write-Host ""
    Write-Host "This is expected after a local apply, before migrating to the S3 backend."
    Write-Host ""
    exit 0
}

$Cache = Read-JsonFile -Path $BackendCachePath

if (-not ($Cache.PSObject.Properties.Name -contains "backend") -or $null -eq $Cache.backend) {
    Write-Section "Interpretation"
    Write-Host "Terraform has created a .terraform/terraform.tfstate file, but no backend identity was found in it."
    Write-Host "If a local terraform.tfstate file is also present, Terraform is still effectively using local state."
    Write-Host ""
    exit 0
}

$BackendType = $Cache.backend.type
$Config      = $Cache.backend.config

Write-Section "Backend identity"
Write-Host "Backend type: $BackendType"

if ($BackendType -eq "s3") {
    $Bucket      = Get-ConfigValue -Config $Config -Name "bucket"
    $Key         = Get-ConfigValue -Config $Config -Name "key"
    $Region      = Get-ConfigValue -Config $Config -Name "region"
    $Encrypt     = Get-ConfigValue -Config $Config -Name "encrypt"
    $UseLockfile = Get-ConfigValue -Config $Config -Name "use_lockfile"

    Write-Host ""
    Write-Host "REMOTE STATE - AWS S3"
    Write-Host "Bucket:       $Bucket"
    Write-Host "Key:          $Key"
    Write-Host "Region:       $Region"
    Write-Host "Encryption:   $Encrypt"
    Write-Host "S3 lock file: $UseLockfile"
    Write-Host ""

    Write-Section "Interpretation"
    Write-Host "Terraform is configured to store state remotely in S3."
    Write-Host "The key value identifies the selected state file."
    Write-Host ""
    Write-Host "For this lab, the key should change as you move between environments:"
    Write-Host "  default.tfstate"
    Write-Host "  dev.tfstate"
    Write-Host "  test.tfstate"
    Write-Host "  prod.tfstate"
    Write-Host ""

    if ($UseLockfile -eq "true") {
        Write-Host "Locking is enabled using Terraform's S3 lockfile approach."
        Write-Host "A temporary .tflock object may appear in the S3 bucket while Terraform is running."
    }
    else {
        Write-Host "S3 lockfile support is not shown as enabled in the cached backend configuration."
        Write-Host "Check that the backend block includes: use_lockfile = true"
    }

    Write-Host ""
    exit 0
}

if ($BackendType -eq "local") {
    $Path = Get-ConfigValue -Config $Config -Name "path"

    Write-Host ""
    Write-Host "LOCAL STATE"
    Write-Host "Path: $Path"
    Write-Host ""

    Write-Section "Interpretation"
    Write-Host "Terraform is currently using the local backend."
    Write-Host "This is expected before the S3 backend block is added and terraform init -migrate-state is run."
    Write-Host ""
    exit 0
}

Write-Host ""
Write-Host "Backend configuration:"
if ($null -ne $Config) {
    $Config.PSObject.Properties | ForEach-Object {
        Write-Host ("{0}: {1}" -f $_.Name, $_.Value)
    }
}

Write-Section "Interpretation"
Write-Host "Terraform is using a backend type that this lab script does not specifically recognise."
Write-Host "Expected backend types for this lab are local and s3."
Write-Host ""
