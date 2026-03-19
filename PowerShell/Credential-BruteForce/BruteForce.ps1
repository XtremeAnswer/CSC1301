<#
.SYNOPSIS
    PowerShell Dictionary-Based Credential Brute-Force Simulator
.DESCRIPTION
    Simulates a dictionary attack against a login system using a wordlist
    of the 10,000 most commonly used passwords.
.INPUTS
    Username string and password list file
.OUTPUTS
    Returns matched credentials on success
.NOTES
    Author: Orkhan Gasimov
    Course: CSCI1411 - Scripting & Programming
#>

###################### DO NOT MODIFY #############################
$Path = $PSScriptRoot
cd $Path
##################################################################

function crackLogin {
    param(
        [string]$username,
        [array]$password_list
    )

    foreach ($password in $password_list) {
        $payload = @()
        $payload += $username
        $payload += $password

        Write-Host "--------------"
        Invoke-Expression "& `".\Login.ps1`" $payload" -OutVariable out

        if ($out -eq "Access Granted") {
            return $payload
        }
    }
}

$password_list = Get-Content .\10k-most-common-passwords.txt
$username = "Luke"
$result = crackLogin $username $password_list
Write-Host $result
