# Log Forensics - Incident Response Investigation

A PowerShell-based log analysis tool that simulates a real incident response investigation. Parses over **300,000 lines** of server logs to trace an attacker's activity, identify stolen data, and calculate the financial impact of a data breach.

---

## Scenario

Security monitoring systems flagged a suspicious IP address hitting multiple servers on the network. The investigation uncovered unauthorized login attempts, accessed files, and confirmed sensitive data exfiltration — including Social Security Numbers and credit card data.

---

## What It Does

1. **Traces the attacker's IP** (`187.76.80.202`) across all log files — 475 hits found
2. **Tracks unauthorized logins** under the username `tonystark` — 254 attempts logged
3. **Identifies accessed files** by searching for `.csv` references in the logs
4. **Scans exfiltrated data** for SSN patterns (`\d{3}-\d{2}-\d{4}`)
5. **Scans for credit card numbers** (`\d{16}`)
6. **Calculates breach cost** based on number of records stolen

---

## Sample Output

```
Number of hits: 475
Number of hits: 254
Number of hits: 5
Estimated hacker's stolen credit card data sale: X USD
Estimated hacker's stolen Social Security Number data worth: X USD
Estimated loss and impact of the breach: >$200,000 USD
```

---

## Concepts Demonstrated

| Concept | Implementation |
|---|---|
| Log Parsing | `Select-String` across 300K+ lines |
| Regular Expressions | SSN pattern `\d{3}-\d{2}-\d{4}`, CC pattern `\d{16}` |
| Reusable Functions | `logSearcher` with path, pattern, and display toggle |
| Incident Costing | `incidentCost` calculates financial breach impact |

---

## Requirements

- PowerShell 5.1+ or PowerShell Core (Kali Linux)
- `Logs/` directory containing `access.log` and `auth.log` (course-provided)
- `Data/` directory containing exfiltrated data files (course-provided)

```bash
pwsh LogForensics.ps1
```

---

## Disclaimer

This script was developed strictly for educational purposes in a controlled lab environment.
