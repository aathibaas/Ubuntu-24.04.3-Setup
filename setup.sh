#!/bin/bash

# Exit bei Fehler
set -e

echo "🔧 Starte Server Setup..."

# 1. System aktualisieren & bereinigen
echo "📦 Update & Upgrade"
apt update && apt full-upgrade -y
apt autoremove -y
apt autoclean -y

# 2. Automatische Updates aktivieren (unattended-upgrades)
echo "🛡️ Aktiviere automatische Sicherheitsupdates"
apt install -y unattended-upgrades
dpkg-reconfigure --priority=low unattended-upgrades

# 3. Wichtige Tools installieren
echo "🧰 Installiere chrony, ufw, fail2ban, nano"
apt install -y nano ufw fail2ban chrony

# 4. nano als Standardeditor setzen
echo "✍️ Setze nano als Standardeditor"
update-alternatives --set editor /bin/nano

# 5. Chrony konfigurieren
echo "⏰ Konfiguriere Chrony mit Cloudflare & METAS"
cat <<EOF > /etc/chrony/chrony.conf
pool time.cloudflare.com iburst maxsources 1
pool ntp.metas.ch iburst maxsources 1

driftfile /var/lib/chrony/chrony.drift
rtcsync
makestep 1.0 3
logdir /var/log/chrony
EOF

systemctl restart chrony
systemctl enable chrony

# 6. UFW konfigurieren (nur SSH offen lassen)
echo "🧱 Konfiguriere Firewall (UFW)"
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw --force enable

# 7. Fail2Ban aktivieren
echo "🚨 Aktiviere fail2ban"
systemctl enable fail2ban
systemctl start fail2ban

echo "✅ Server-Setup abgeschlossen!"
