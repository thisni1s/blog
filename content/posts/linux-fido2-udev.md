---
title: "Nutzung von U2F USB Keys unter Linux"
date: 2020-02-16T18:00:52+01:00
draft: false
tags:
  - linux
  - fido2
  - u2f
  - opensuse
  - lang:german
---

Viele U2F-Keys werden nicht nativ in Linux unterstützt, hier ein kurzer
Guide wie man seinen U2F-Key in Linux einbindet. Ich benutze hier
OpenSUSE Tubleweed.

## Auf Udev prüfen

Zuerst finde ich heraus ob meine Distribution Udev benutzt. Dazu unter
OpenSUSE folgenden Befehl ins Terminal eingeben:

``` shell
zypper if udev
```

Wichtig ist, dass im Output bei `Installiert: Ja` steht, und die Version
mindestens 188 oder höher ist.

## Udev Regel anlegen

Wir fügen nun eine neue Udev Regel hinzu um unserer Distribution
mitzuteilen wie sie mit dem U2F-Key umgehen soll. Zum Glück gibt es von
Yubico schon eine fertige Udev Regel in der viele U2F-Keys bereits
eingetragen sind. Diese könnt ihr
[*hier*](https://github.com/Yubico/libu2f-host/blob/master/70-u2f.rules "Yubico Udev Liste")
herunterladen. Die Liste ist gut kommentiert und Ihr solltet erst einmal
gucken ob ihr eurer U2F Gerät bereits dort findet. Wenn es bereits in
der Liste steht könnt ihr den nächsten Schritt überspringen.

### Neues Gerät der Liste hinzufügen

Mein U2F-Stick war bereits auf der Liste eingetragen. Ist eurer nicht
eingetragen müsst ihr der Liste einen weiteren Eintrag hinzufügen. Dazu
gebt ihr folgenden Befehl im Terminal ein, ohne den U2F-Stick
eingesteckt zu haben.

``` shell
lsusb
```

``` shell
Bus 002 Device 002: ID 05e3:0620 Genesys Logic, Inc.
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 006: ID 08bb:27c4 Texas Instruments PCM2704C stereo audio DAC
Bus 001 Device 005: ID 05e3:0610 Genesys Logic, Inc. 4-port hub
Bus 001 Device 004: ID 1397:0507 BEHRINGER International GmbH
Bus 001 Device 003: ID 046a:010d Cherry GmbH MX-Board 3.0 Keyboard
Bus 001 Device 002: ID 04d9:a079 Holtek Semiconductor, Inc.
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
```

Und den Selben Befehl nochmal mit eingestecktem Stick:

``` shell
lsusb
```

``` shell
Bus 002 Device 002: ID 05e3:0620 Genesys Logic, Inc.
Bus 002 Device 001: ID 1d6b:0003 Linux Foundation 3.0 root hub
Bus 001 Device 006: ID 08bb:27c4 Texas Instruments PCM2704C stereo audio DAC
Bus 001 Device 005: ID 05e3:0610 Genesys Logic, Inc. 4-port hub
Bus 001 Device 004: ID 1397:0507 BEHRINGER International GmbH
Bus 001 Device 003: ID 046a:010d Cherry GmbH MX-Board 3.0 Keyboard
Bus 001 Device 002: ID 04d9:a079 Holtek Semiconductor, Inc.
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
```

Wenn man beide Ausgaben betrachtet erkennt man, den Eintrag den der
U2F-Stick erzeugt hat. In diesem Fall:
`Bus 001 Device 011: ID 2ccf:0880`. Die beiden Hex Zahlen am ende sind
die Vendorid und die Productid. Mit deren Hilfe fügen wir der Liste
einen neuen Eintrag hinzu. Öffnet die Liste mit dem Texteditor eurer
Wahl und fügt diese Zeilen hinzu:

``` shell
# Name eures Keys
KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="2ccf", ATTRS{idProduct}=="0880", TAG+="uaccess", GROUP="plugdev", MODE="0660"
```


Wichtig ist natürlich, dass ihr `2ccf` und `0880` durch eure Vendorid
und Productid austauscht.

### Liste speichern

Die gespeicherte Liste muss nun in den Richtigen Ordner verschoben
werden. Angenommen sie liegt in eurem Downloads Ordner gebt ihr
folgendes ein:

``` shell
sudo mv ~/Downloads/70-u2f.rules /etc/udev/rules.d/70-u2f.rules
```

Und das wars. Nun solltet ihr euren U2F-Key nutzen können!
