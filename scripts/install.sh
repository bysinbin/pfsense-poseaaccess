#!/bin/sh
set -e
echo "=== Installing PoseaAccess (Identity & Exemption Management) for pfSense ==="
if [ "$(id -u)" -ne 0 ]; then
    echo "[!] Error: Run as root."
    exit 1
fi
SCRIPT_DIR="$(cd "$(dirname "$0")/.." 2>/dev/null && pwd)"
if [ ! -d "${SCRIPT_DIR}/pfsense-pkg" ]; then
    TMP_DIR="/tmp/poseaaccess_install"
    rm -rf "${TMP_DIR}"
    mkdir -p "${TMP_DIR}"
    fetch -q -o "${TMP_DIR}/main.tar.gz" "https://github.com/bysinbin/pfsense-poseaaccess/archive/refs/heads/main.tar.gz"
    tar -xzf "${TMP_DIR}/main.tar.gz" -C "${TMP_DIR}"
    SCRIPT_DIR="${TMP_DIR}/pfsense-poseaaccess-main"
fi

mkdir -p /usr/local/pkg /usr/local/www /var/etc/poseafilter
cp "${SCRIPT_DIR}/pfsense-pkg/usr/local/pkg/poseaaccess.inc" /usr/local/pkg/poseaaccess.inc
cp "${SCRIPT_DIR}/pfsense-pkg/usr/local/pkg/poseaaccess.xml" /usr/local/pkg/poseaaccess.xml
cp "${SCRIPT_DIR}/pfsense-pkg/usr/local/www/poseaaccess.php" /usr/local/www/poseaaccess.php

php -r '
require_once("/etc/inc/config.inc");
global $config;
$found = false;
foreach ($config["installedpackages"]["package"] ?? [] as $p) {
    if (($p["name"] ?? "") === "poseaaccess") { $found = true; break; }
}
if (!$found) {
    $config["installedpackages"]["package"][] = [
        "name" => "poseaaccess",
        "descr" => "PoseaAccess Identity & Exemption Management for pfSense",
        "website" => "https://github.com/bysinbin/pfsense-poseaaccess",
        "version" => "1.0.0",
        "status" => "Stable",
        "configurationfile" => "poseaaccess.xml"
    ];
}
$mfound = false;
foreach ($config["installedpackages"]["menu"] ?? [] as $m) {
    if (($m["name"] ?? "") === "PoseaAccess") { $mfound = true; break; }
}
if (!$mfound) {
    $config["installedpackages"]["menu"][] = [
        "name" => "PoseaAccess",
        "section" => "Services",
        "url" => "/poseaaccess.php"
    ];
}
write_config("Installed PoseaAccess package");
'
echo "[+] PoseaAccess successfully installed!"
