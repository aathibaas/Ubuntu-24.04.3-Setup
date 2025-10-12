#!/bin/bash
# ========================================
# VPS Setup Script für Ubuntu 24.04.3 LTS
# Erstellt von Aathithjan Baasgaran
# ========================================

set -e  # Stoppe bei Fehler

# Root-Prüfung
if [ "$EUID" -ne 0 ]; then
  echo "❌ Bitte mit sudo oder als root ausführen."
  exit 1
fi

echo "🔧 Starte VPS-Systemsetup..."

# 1. System aktualisieren
echo "📦 Update & Upgrade"
apt update && apt full-upgrade -y
apt autoremove -y
apt autoclean -y

# 2. Automatische Sicherheitsupdates aktivieren
echo "🛡️ Aktiviere unattended-upgrades"
apt install -y unattended-upgrades
cat <<EOF > /etc/apt/apt.conf.d/20auto-upgrades
APT::Periodic::Update-Package-Lists "1";
APT::Periodic::Download-Upgradeable-Packages "1";
APT::Periodic::AutocleanInterval "7";
APT::Periodic::Unattended-Upgrade "1";
EOF

# 3. Tools installieren
echo "🧰 Installiere chrony, fail2ban, ufw, nano"
apt install -y chrony fail2ban ufw nano

# 4. nano als Standardeditor setzen
echo "✍️ Setze nano als Standardeditor"
update-alternatives --install /usr/bin/editor editor /usr/bin/nano 10
update-alternatives --set editor /usr/bin/nano

# 5. Chrony konfigurieren (nur Cloudflare & METAS)
echo "⏰ Konfiguriere Chrony"
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

# 6. UFW konfigurieren (SSH freigeben)
echo "🧱 Konfiguriere UFW Firewall"
ufw default deny incoming
ufw default allow outgoing
ufw allow ssh
ufw --force enable

# 7. Fail2Ban aktivieren
echo "🚨 Aktiviere Fail2Ban"
systemctl enable fail2ban
systemctl start fail2ban

echo "✅ VPS-Setup abgeschlossen!"

