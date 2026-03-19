# PowerShell Credential Brute-Force Simulator

A scripted simulation of a dictionary-based brute-force attack built in PowerShell, developed as part of a scripting & programming course at the University of North Georgia.

---

## Overview

This script demonstrates how attackers use wordlists to systematically guess passwords against a login interface. It iterates through a list of 10,000 commonly used passwords, sending each as a credential attempt until access is granted.

While this is a controlled lab environment, the underlying technique mirrors real-world tools like **Hydra** and **Burp Suite's Intruder** — both used regularly in penetration testing.

---

## How It Works

1. Loads a wordlist (`10k-most-common-passwords.txt`) into memory
2. Calls a `crackLogin` function with the target username and wordlist
3. Iterates through each password, building a credential payload `[username, password]`
4. Sends the payload to a simulated login script (`Login.ps1`) via `Invoke-Expression`
5. Checks the response — if `"Access Granted"`, returns the successful credentials and stops

```powershell
function crackLogin {
    param([string]$username, [array]$password_list)

    foreach ($password in $password_list) {
        $payload = @()
        $payload += $username
        $payload += $password

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
```

---

## Concepts Demonstrated

| Concept | Implementation |
|---|---|
| Functions & Parameters | `crackLogin` takes username + wordlist as arguments |
| Loops | `foreach` iterates every password in the wordlist |
| Arrays | `$payload` stores credential pairs |
| External Script Execution | `Invoke-Expression` calls `Login.ps1` |
| Conditional Logic | `if` checks response and returns on match |

---

## Real-World Context

This simulation reflects the basics of a **credential stuffing / dictionary attack**. In actual security assessments, defenders protect against this with:

- **Account lockout policies** — lock account after N failed attempts
- **Rate limiting** — throttle login requests per IP
- **Multi-factor authentication (MFA)** — a stolen password alone isn't enough
- **CAPTCHA** — prevents automated scripts from submitting forms
- **Monitoring & alerting** — flag rapid sequential login failures

Understanding how these attacks work is the first step to building effective defenses.

---

## Setup & Requirements

- PowerShell 5.1+ (or PowerShell Core on Kali Linux)
- `Login.ps1` — simulated login script (provided in course repo)
- `10k-most-common-passwords.txt` — wordlist (provided in course repo)

```bash
# Run the script
pwsh Assignment2.ps1
```

---

## Disclaimer

This script was developed strictly for educational purposes in a controlled lab environment. Unauthorized credential attacks against real systems are illegal and unethical.
