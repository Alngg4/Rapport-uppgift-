# Jag genomför en enkel säkerhetsanalys av olika datakällor.

from datetime import datetime


def read_file_lines(filename):
    # Jag läser in en textfil och returnerar raderna
    try:
        with open(filename, "r", encoding="utf-8") as f:
            return [line.strip() for line in f.readlines()]
    except FileNotFoundError:
        return []


def analyze_processes(processes):
    # Jag identifierar misstänkta processer
    suspicious = ["nc.exe", "netcat", "hydra"]
    findings = []

    for proc in processes:
        if proc.lower() in suspicious:
            findings.append(f"Misstänkt process upptäckt: {proc}")

    return findings


def analyze_logs(logs):
    # Jag analyserar loggar efter varningar och fel
    findings = []

    for line in logs:
        if "failed" in line.lower() or "unauthorized" in line.lower():
            findings.append(f"Misstänkt logghändelse: {line}")

    return findings


def analyze_network(network_data):
    # Jag kontrollerar ovanliga IP-adresser
    findings = []

    for ip in network_data:
        if ip.startswith("10."):
            findings.append(f"Ovanligt nätverk upptäckt: {ip}")

    return findings


def fetch_api_data():
    # Simulerat API-anrop mot central säkerhetsplattform
    # Jag kan inte bekräfta riktig API-data utan faktisk endpoint
    return {
        "alerts": 2,
        "risk_level": "Medium"
    }


def generate_report(findings):
    # Jag genererar en enkel säkerhetsrapport
    report = []
    report.append("SÄKERHETSRAPPORT")
    report.append(f"Datum: {datetime.now()}")
    report.append("-" * 40)

    if not findings:
        report.append("Inga säkerhetsrisker identifierades.")
    else:
        for finding in findings:
            report.append(f"- {finding}")

    return "\n".join(report)


def main():
    processes = read_file_lines("processes.txt")
    logs = read_file_lines("security.log")
    network = read_file_lines("network.txt")

    findings = []
    findings += analyze_processes(processes)
    findings += analyze_logs(logs)
    findings += analyze_network(network)

    api_data = fetch_api_data()
    findings.append(f"API-rapporterad risknivå: {api_data['risk_level']}")

    report = generate_report(findings)

    with open("security_report.txt", "w", encoding="utf-8") as f:
        f.write(report)

    print("Säkerhetsanalys genomförd.")
    print("Rapport skapad: security_report.txt")


if __name__ == "__main__":
    main()
