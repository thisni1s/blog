---
title: "Pfsense Telekom"
date: 2020-03-14T17:56:55+01:00
draft: false
---

# Pfsense anmeldung bei der Telekom mit PPPoE

Um die eigene Pfsense-Box mit dem Internet zu verbinden, muss man sich
mithilfe von PPPoE bei der Telekom einloggen. Normalerweise muss ihr ein
Modem vorgeschaltet sein, dass sich im Bridge Modus befindet. Mehrfaches
einloggen per PPPoE ist bei der Telekom nicht mehr möglich.

## VLAN anlegen

Zunächst muss ein VLAN angelegt werden, da die Telekom das Internet mit
der VLAN ID 7 tagged. Dafür klickt man auf
`Interaces -> Assignments -> VLANs -> Add`.

Als Parent Interface, muss das Interface ausgewählt werden, dass mit dem
Modem verbunden ist. Der VLAN Tag ist 7. Am Ende kann noch eine
Beschreibung hinzugefügt werden.

![VLAN Erstellung](/static/vlan.png)

## PPPoE Interace erstellen

Als nächstes muss ein PPPoE Interface erstellt werden. Dafür klickt man
auf `Interfaces -> Assignments -> PPPs -> Add`.\
Der Link Type ist PPPoE, als Link Interface muss man das eben erstellte
VLAN Interface auswählen. Der Username setzt sich zusammen aus der
Anschlusskennung, der T-Online Nummer und der Mitbenutzernummer, direkt
hintereinander geschrieben mit \@t-online.de am Ende. Das Kennwort ist
das Kennwort das die Telekom im Brief mit der Anschlusskennung
mitgeschickt hat.

Mit einem Klick auf `Display Advanced` kann noch der Periodic Reset
eingestellt werden.

![PPPoE Erstellung](/static/pppoe.png)

## Interface zuweisen

Danach muss das PPPoE interface dem WAN Interface zugewiesen werden.
Dafür geht man bei `Interaces -> Assignments` und klickt bei WAN im
Dropdown Menü auf das PPPoE Interface.

Nun auf `Save` klicken und die Verbindung wird aufgebaut.
