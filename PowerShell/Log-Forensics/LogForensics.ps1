<#
.SYNOPSIS
    Log Forensics - Incident Response Investigation
.DESCRIPTION
    Parses 300K+ lines of server logs to investigate a suspicious IP address.
    Identifies unauthorized access attempts, exfiltrated files, and stolen
    sensitive data (SSNs and credit card numbers) to calculate breach impact.
.INPUTS
    Access.log, Auth.log, Data files
.OUTPUTS
    Investigation findings and estimated financial loss
.NOTES
    Author: Orkhan Gasimov
    Course: CSCI1411 - Scripting & Programming
#>
 
###################### DO NOT MODIFY #############################
$Path = $PSScriptRoot
cd $Path
##################################################################
 
#----------------------------------------------------------[Helper Functions]----------------------------------------------------------
 
function howMany($obj) {
    Write-Host "Number of hits: " $obj.count
    return $obj.count
}
 
function incidentCost($cc, $ssn) {
    $totalUsers = $cc + $ssn
    Write-Host "Estimated hacker's stolen credit card data sale: " ($cc * 5) " USD"
    Write-Host "Estimated hacker's stolen Social Security Number data worth: " ($ssn * 1) " USD"
    Write-Host "Estimated loss and impact of the breach: " ($totalUsers * 150) " USD"
    return $totalUsers * 150
}
 
#----------------------------------------------------------[Investigation]----------------------------------------------------------
 
# Step 1 - Find all log entries tied to the suspicious IP
$findings = Select-String -Path "./Logs/*" -Pattern "187.76.80.202"
$findings
howMany $findings
 
# Step 2 - Build a reusable log search function
function logSearcher($dir, $text, $showLogs) {
    $results = Select-String -Path $dir -Pattern $text
 
    if ($showLogs -eq $true) {
        $results
    }
 
    return howMany $results
}
 
# Step 3 - Track attacker's username activity across logs
$results1 = logSearcher "./Logs/*" "tonystark" $True
 
# Step 4 - Identify files accessed by the attacker
$results2 = logSearcher "./Logs/*" "csv"
 
# Step 5 - Scan exfiltrated data files for Social Security Numbers
$ssnResults = logSearcher "./Data/*" "\d{3}-\d{2}-\d{4}"
 
# Step 6 - Scan exfiltrated data files for Credit Card Numbers
$ccResults = logSearcher "./Data/*" "\d{16}"
 
# Step 7 - Calculate total financial impact of the breach
incidentCost $ccResults $ssnResults

