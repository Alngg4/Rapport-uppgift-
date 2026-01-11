# Jag utför enkla säkerhetskontroller i Windows med PowerShell
# 1. Analys av Event Viewer
# 2. Kontroll av grundläggande säkerhetsinställningar
# 3. Kontroll av uppdateringsstatus

Write-Host "Jag startar säkerhetskontroller i Windows..." -ForegroundColor Green
Write-Host ""

# 1. Analys av Event Viewer

Write-Host "1. Jag analyserar Event Viewer efter misslyckade inloggningar" -ForegroundColor Green

# Jag hämtar de senaste misslyckade inloggningarna (Event ID 4625)
$failedLogins = Get-WinEvent -FilterHashtable @{
    LogName = "Security"
    Id = 4625
} -MaxEvents 10

if ($failedLogins.Count -gt 0) {
    Write-Host "Misslyckade inloggningar har upptäckts." -ForegroundColor Green
} else {
    Write-Host "Inga misslyckade inloggningar hittades." -ForegroundColor Green
}

Write-Host ""

# 2. Härdning av säkerhetsinställningar

Write-Host "2. Jag kontrollerar grundläggande säkerhetsinställningar" -ForegroundColor Green

# Kontrollera att Windows-brandväggen är aktiverad
$firewall = Get-NetFirewallProfile | Select-Object Name, Enabled

$firewall | ForEach-Object {
    Write-Host "Brandvägg ($($_.Name)): Aktiverad = $($_.Enabled)" -ForegroundColor Green
}

Write-Host ""

# 3. Kontroll av uppdateringsstatus

Write-Host "3. Jag kontrollerar uppdateringsstatus" -ForegroundColor Green

# Kontrollera om systemet har installerade uppdateringar
$updates = Get-HotFix

if ($updates.Count -gt 0) {
    Write-Host "Systemet har installerade säkerhetsuppdateringar." -ForegroundColor Green
} else {
    Write-Host "Inga uppdateringar hittades." -ForegroundColor Green
}

Write-Host ""
Write-Host "Alla säkerhetskontroller i Windows är slutförda." -ForegroundColor Green