# 🧠 VPS Setup Script für Ubuntu 24.04.3 LTS

Dieses Script habe ich erstellt, um meine Ubuntu-Server (z. B. für Projekte wie **Perforce**, **Docker** oder **Game-Server**) schnell, sicher und sauber einzurichten.  
Ziel war ein wiederholbares Setup mit stabilen Basisdiensten, die ich auf jedem meiner VPS brauche.

---

## ⚙️ Funktionen

Das Script automatisiert den kompletten Grundaufbau eines neuen VPS:

### 🧩 System-Update & Bereinigung
Führt ein vollständiges `apt update`, `full-upgrade`, `autoremove` und `autoclean` aus.

### 🔒 Automatische Sicherheitsupdates
Aktiviert `unattended-upgrades`, damit sicherheitsrelevante Updates automatisch eingespielt werden.

### 🧰 Basis-Tools installieren
Installiert essentielle Tools:

- `chrony` → präzise Zeit-Synchronisation  
- `fail2ban` → Schutz vor SSH-Bruteforce-Angriffen  
- `ufw` → einfache Firewall  
- `nano` → als Standard-Editor

### ⏰ Chrony konfigurieren
Nutzt nur zwei zuverlässige Zeitquellen:

- `time.cloudflare.com`  
- `ntp.metas.ch`  

Damit bleibt die Systemzeit präzise, ohne unnötige externe Verbindungen.

### 🧱 UFW (Firewall) konfigurieren
- Blockiert standardmäßig alle eingehenden Verbindungen  
- Erlaubt nur SSH  
- Aktiviert die Firewall automatisch

### 🚨 Fail2Ban aktivieren
- Startet den Dienst  
- Schützt den Server sofort vor zu vielen Login-Versuchen

---

## 🚀 Verwendung

```bash
bash <(curl -s https://raw.githubusercontent.com/aathibaas/Ubuntu-24.04.3-Setup/refs/heads/public/ubuntu-setup.sh | sed 's/\r$//')

```

Das Script **muss als root oder mit sudo** ausgeführt werden.  
Es bricht automatisch ab, falls ein Fehler auftritt (`set -e`).

---

## 🧠 Warum ich das Script geschrieben habe

Ich richte regelmäßig neue VPS-Instanzen für verschiedene Projekte ein – darunter Game-Server, Entwicklungsserver oder Tools wie Perforce.  
Da ich keine Lust hatte, jedes Mal dieselben Grundschritte manuell auszuführen, habe ich dieses Script geschrieben.  
Es sorgt für einheitliche Systeme, spart Zeit und garantiert, dass Sicherheitsfunktionen wie `fail2ban`, `ufw` und automatische Updates immer direkt aktiv sind.  
Kurz gesagt: weniger Tipperei, mehr Fokus auf das eigentliche Projekt.

---

## 🧾 Kompatibilität

Getestet mit:
- **Ubuntu Server 24.04.3 LTS (Noble Numbat)**  
- Funktioniert auch auf allen 24.04.x-Versionen  

Das Script ist für frische Installationen optimiert und funktioniert auf VPS-Umgebungen von Anbietern wie Netcup, Hetzner oder Contabo.

---

## 🧑‍💻 Autor

**Aathithjan Baasgaran**  
