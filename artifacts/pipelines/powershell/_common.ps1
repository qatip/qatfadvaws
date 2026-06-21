$ErrorActionPreference = "Stop"

function Get-LabRoot {
    return "C:\qatfadvaws-local"
}

function Get-EnvPath {
    param(
        [Parameter(Mandatory=$true)]
        [ValidateSet("dev","test","prod")]
        [string]$Environment
    )

    $labRoot = Get-LabRoot
    return Join-Path $labRoot ("lab6\guided\envs\" + $Environment)
}

function Get-NetworkPinnedVersion {
    param(
        [Parameter(Mandatory=$true)]
        [ValidateSet("dev","test","prod")]
        [string]$Environment
    )

    $mainTf = Join-Path (Get-EnvPath $Environment) "main.tf"

    if (-not (Test-Path $mainTf)) {
        throw "Unable to locate $mainTf"
    }

    $content = Get-Content -Raw $mainTf

    $match = [regex]::Match(
        $content,
        'terraform-aws-module-network\.git\?ref=v(\d+\.\d+\.\d+)'
    )

    if (-not $match.Success) {
        throw "Unable to determine network module version in $mainTf"
    }

    return $match.Groups[1].Value
}

function Compare-Version {
    param(
        [string]$VersionA,
        [string]$VersionB
    )

    return ([version]$VersionA).CompareTo([version]$VersionB)
}

function Test-PromotionGate {
    param(
        [ValidateSet("dev","test","prod")]
        [string]$Environment
    )

    switch ($Environment) {

        "dev" {
            Write-Host "DEV has no promotion gate."
            return
        }

        "test" {

            $devVersion  = Get-NetworkPinnedVersion "dev"
            $testVersion = Get-NetworkPinnedVersion "test"

            Write-Host ""
            Write-Host "Detected module versions:"
            Write-Host "network  dev-$devVersion  test-$testVersion"
            Write-Host ""

            if ((Compare-Version $testVersion $devVersion) -gt 0) {
                throw "Promotion blocked: test network ($testVersion) is ahead of dev network ($devVersion). Promote in order."
            }

            Write-Host "Gate passed: test is not ahead of dev"
        }

        "prod" {

            $testVersion = Get-NetworkPinnedVersion "test"
            $prodVersion = Get-NetworkPinnedVersion "prod"

            Write-Host ""
            Write-Host "Detected module versions:"
            Write-Host "network  test-$testVersion  prod-$prodVersion"
            Write-Host ""

            if ((Compare-Version $prodVersion $testVersion) -gt 0) {
                throw "Promotion blocked: prod network ($prodVersion) is ahead of test network ($testVersion). Promote in order."
            }

            Write-Host "Gate passed: prod is not ahead of test"
        }
    }
}

function Invoke-Terraform {
    param(
        [ValidateSet("dev","test","prod")]
        [string]$Environment
    )

    $envPath = Get-EnvPath $Environment

    Push-Location $envPath

    try {

        terraform init --upgrade -input=false

        if ($LASTEXITCODE -ne 0) {
            throw "terraform init --upgrade failed"
        }

        terraform plan -input=false

        if ($LASTEXITCODE -ne 0) {
            throw "terraform plan failed"
        }

        terraform apply -auto-approve -input=false

        if ($LASTEXITCODE -ne 0) {
            throw "terraform apply failed"
        }

    }
    finally {
        Pop-Location
    }
}

function Invoke-Promotion {
    param(
        [ValidateSet("dev","test","prod")]
        [string]$Environment
    )

    Write-Host ""
    Write-Host "=================================================="
    Write-Host "Terraform Apply ($Environment)"
    Write-Host "=================================================="
    Write-Host ""

    Test-PromotionGate $Environment

    Invoke-Terraform $Environment

    Write-Host ""
    Write-Host "Completed successfully."
}