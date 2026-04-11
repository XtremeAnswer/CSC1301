# CSCI1411 - Scripting & Programming

A collection of scripting projects completed as part of the **Scripting & Programming** course at the **University of North Georgia (UNG)**. Each project applies scripting concepts to real-world cybersecurity scenarios across three languages.

**Languages:** PowerShell · Bash · Python  
**Environment:** Kali Linux (VMware)  
**Author:** Orkhan Gasimov

---

## Projects

### PowerShell

| Project | Description | Concepts |
|---|---|---|
| [Credential Brute-Force](./PowerShell/Credential-BruteForce) | Dictionary-based password attack simulator against a login system | Functions, loops, arrays, external script execution |
| [Log Forensics](./PowerShell/Log-Forensics) | Incident response investigation parsing 300K+ lines of server logs to trace an attacker and calculate breach cost | Regex, log parsing, reusable functions |

### Bash

| Project | Description | Concepts |
|---|---|---|
| [Pentest Report Generator](./Bash/Pentest-Report) | Automated penetration testing script that scans a target, exploits the vsftpd 2.3.4 backdoor via Metasploit, and generates an HTML security report | nmap, Metasploit, functions, pipes, argument handling |

### Python
| Project | Description | Concepts |
|---|---|---|
| [IP Geolocation Attack Map](./Python/Attack-Map) | Parses a web server access log to extract and deduplicate attacker IPs, performs geolocation lookups via the Azure Maps API, and renders an interactive world map of attack origins | Regex, REST APIs, JSON, data pipelines, D3.js integration |

---

## Course Topics

- PowerShell & Bash scripting for information security
- Log parsing and text analysis with Regular Expressions
- Flow control, functions, and data pipelines
- Python scripting for security automation

---

## About

I'm a Cybersecurity student at UNG building hands-on skills in scripting, network forensics, and penetration testing. This repository tracks my progress through scripting fundamentals and their real-world security applications.
