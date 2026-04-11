# IP Geolocation Attack Map

A Python script that parses a web server access log, extracts attacker IP addresses, performs geolocation lookups via the Azure Maps API, and renders an interactive world map showing the geographic origin of each attack.

---

## Scenario

A simulated cyberattack has generated a web server access log (`access.log`) containing thousands of entries from malicious source IPs spread across the globe. The goal is to extract every unique attacker IP, determine which country it originates from, and visualize the full attack surface on an interactive world map.

---

## How It Works

1. Opens `logs/access.log` and reads it line by line
2. Uses regex to extract every IPv4 address from each log entry
3. Deduplicates the full IP list using `list(set(...))`
4. Iterates through unique IPs and calls `getCountry(ip)` from `azuremaps.py`
5. The Azure Maps Geolocation API returns an ISO country code for each IP
6. Results are written to `js/found.js` as a JavaScript data object
7. `index.html` loads `found.js` and renders country-sized circles via D3.js / Datamaps

```python
# Extract and deduplicate IPs from the log
for line in file:
    found = re.findall(r'\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}', line)
    ips.extend(found)

unique_ips = list(set(ips))

# Geolocate each IP and build the map dataset
for ip in unique_ips:
    country = azuremaps.getCountry(ip)
    if country:
        toJson.append({"user": ip, "country": country})
```

---

## Results

![Attack Map](screenshot.png)

| Metric | Value |
|---|---|
| Total IPs in log | ~1,380 |
| Unique attacker IPs | 127 |
| Countries identified | 8 |
| Top attacker country | Russia (RU) |

---

## Concepts Demonstrated

| Concept | Implementation |
|---|---|
| Regex & Log Parsing | `re.findall()` extracts IPv4 addresses from each log line |
| Data Deduplication | `list(set(...))` removes duplicate IPs before API calls |
| REST API Integration | `requests.get()` calls Azure Maps Geolocation endpoint |
| JSON Data Pipeline | Geolocation results written to `found.js` for map consumption |
| Error Handling | `try/except` skips IPs that return unexpected API responses |
| Secure Credentials | API key loaded from environment variable, never hardcoded |
| D3.js Integration | Python output feeds a JavaScript map library (Datamaps + D3) |

---

## Real-World Context

IP geolocation mapping is a standard technique in threat intelligence and incident response. Security teams use it to:

- Attribute attacks to geographic regions or known threat actor locations
- Visualize attack distribution across a network during an active incident
- Identify patterns in log data (e.g., a sudden spike from a specific country)
- Feed data into SIEM dashboards for ongoing monitoring

Tools like Splunk, Elastic SIEM, and many SOC platforms include built-in geolocation mapping built on the same concept demonstrated here.

---

## Requirements

- Python 3
- `requests` library (`pip install requests`)
- Azure Maps API key
- Kali Linux (or any system with Python 3)

```bash
# Set your API key (never hardcode secrets)
export AZURE_MAPS_KEY=your_key_here

# Run the script
python3 assignment8.py

# Open the map
firefox index.html
```

---

## Disclaimer

This script was developed strictly for educational purposes in a controlled lab environment using simulated log data. Do not use this tool against systems or logs you do not own or have explicit authorization to analyze.
