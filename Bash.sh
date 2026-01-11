#!/bin/bash

#  Syftet är att analysera loggar, kontrollera nätverkstrafik och se om systemet är uppdaterat.

# Resultatet sparas i en säkerhetsrapport

LOGGFIL="sakerhetsrapport_linux.txt"

#  Jag skapar en funktion för loggning så att all information sparas med datum och tid.
logga() {
    echo "$(date '+%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOGGFIL"
}

#  Jag skriver en tydlig rubrik och dagens datum i rapporten.
echo "SÄKERHETSRAPPORT – LINUX" > "$LOGGFIL"
echo "Datum: $(date '+%Y-%m-%d')" >> "$LOGGFIL"
echo "-----------------------------------" >> "$LOGGFIL"

#  Jag markerar i loggen att säkerhetskontrollen startar.
logga "Jag startar säkerhetskontrollen."

echo "" >> "$LOGGFIL"

#  Här analyserar jag systemloggar för att upptäcka misslyckade inloggningsförsök.
logga "1. Jag analyserar systemloggar efter misslyckade inloggningar."

if [ -f /var/log/auth.log ]; then
    #  Jag räknar hur många gånger ett inloggningsförsök har misslyckats.
    ANTAL=$(grep -i "failed password" /var/log/auth.log | wc -l)
    logga "Antal misslyckade inloggningsförsök: $ANTAL"
else
    #  Om loggfilen inte finns dokumenterar jag detta i rapporten.
    logga "Loggfilen /var/log/auth.log hittades inte."
fi

echo "" >> "$LOGGFIL"

#  Här kontrollerar jag aktuell nätverkstrafik för att se aktiva anslutningar.
logga "2. Jag kontrollerar aktiv nätverkstrafik."

#  Jag listar alla aktiva TCP- och UDP-anslutningar samt öppna portar.
ss -tuna >> "$LOGGFIL"
logga "Aktiva nätverksanslutningar har listats."

echo "" >> "$LOGGFIL"

#  Här kontrollerar jag om det finns tillgängliga systemuppdateringar.
logga "3. Jag kontrollerar om det finns tillgängliga uppdateringar."

UPPDATERINGAR=$(apt list --upgradable 2>/dev/null | wc -l)

if [ "$UPPDATERINGAR" -gt 1 ]; then
    #  Jag informerar om att uppdateringar bör installeras för att minska säkerhetsrisker.
    logga "Det finns tillgängliga uppdateringar som bör installeras."
else
    #  Om inga uppdateringar finns noterar jag att systemet är uppdaterat.
    logga "Systemet är uppdaterat."
fi

echo "" >> "$LOGGFIL"

#  Jag avslutar säkerhetskontrollen och loggar att den är klar.
logga "Säkerhetskontrollen är slutförd."
