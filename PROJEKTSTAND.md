# SmartAlarm — Projektstand

**Datum:** 2026-04-01  
**Entwickler:** Norbert Sass / Gestalten Sass  
**Plattform:** Android (Flutter)

---

## Setup & Umgebung

| Tool | Version | Installationsweg |
|------|---------|-----------------|
| Flutter SDK | 3.41.6 stable | Manuell tar.xz unter `~/development/flutter/` |
| Android SDK | 35/36 | Command Line Tools unter `~/development/android-sdk/` |
| Java | OpenJDK 17.0.18 | apt install openjdk-17-jdk |
| Dart | 3.11.4 | Mit Flutter mitgeliefert |

**PATH-Einträge in `~/.bashrc`:**
```bash
export PATH="$PATH:$HOME/development/flutter/bin"
export ANDROID_HOME="$HOME/development/android-sdk"
export JAVA_HOME="/usr/lib/jvm/java-17-openjdk-amd64"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools"
```

---

## Projekt

**Pfad:** `/home/norbert/claude-code/stich/app/`  
**App-Name:** Alarm  
**Package:** `de.norbertsass.smart_alarm`  
**Version:** 1.0.0+1

---

## Screens

| Screen | Datei | Beschreibung |
|--------|-------|-------------|
| Alarm-Zentrale | `lib/screens/home_screen.dart` | Hauptscreen mit pulsierendem Alarm-Button, Gestalten Sass Branding, Uhrzeit |
| Alarm AKTIV | `lib/screens/alarm_active_screen.dart` | Aktiver Alarm mit Blink-Animation, rotem Rand, Stop-Button |
| Einstellungen | `lib/screens/settings_screen.dart` | Soundauswahl (Sirene/Hundegebell/Eigene Datei), Vibration, Wakelock |
| Info | `lib/screens/info_screen.dart` | Bedienanleitung, App-Info |

---

## Funktionen

- **Manueller Alarm:** Großer roter Button → Alarm auslösen
- **Soundauswahl:** Sirene (nativer Android-Alarm), Hundegebell (CC0-MP3) oder eigene Audiodatei (MP3/WAV/OGG/M4A)
- **Vibration:** Ein/Aus schaltbar, gespeichert via SharedPreferences
- **Wakelock:** Bildschirm bei Alarm wach halten, Ein/Aus schaltbar
- **Animationen:** Pulsierender Button auf Hauptscreen, blinkender Rand + Icon auf Alarm-Screen
- **Branding:** "Gestalten Sass" im Header des Hauptscreens
- **Navigation:** Gemeinsame Bottom-Navigation auf allen Screens (`lib/widgets/bottom_nav.dart`)

---

## Design-System (aus Stitch-Projekt)

**Stitch-Projekt-ID:** `6112471742119694376`  
**Theme:** "The Vigilant Sentinel" — Editorial Brutalism, Dark Mode

| Token | Wert |
|-------|------|
| Background | `#131313` |
| Primary | `#FFB3AC` |
| Primary Container (Alarm-Rot) | `#D32F2F` |
| On Surface | `#E5E2E1` |
| On Surface Variant | `#C8C6C6` (Hellgrau, geändert von Baby-Rosa) |
| Tertiary (Status-Blau) | `#7BD1F8` |
| Headline-Font | Space Grotesk |
| Body-Font | Work Sans |

---

## Assets

| Datei | Beschreibung |
|-------|-------------|
| `assets/sounds/dog_barking.mp3` | Hundegebell, CC0-Lizenz, von bigsoundbank.com |
| `assets/icon.png` | App-Icon: Roter Kreis mit weißem Warndreieck (1024×1024) |
| `assets/icon_512.png` | App-Icon für Google Play (512×512) |
| `assets/feature_graphic.png` | Feature-Grafik für Google Play Store (1024×500) |

---

## Abhängigkeiten (pubspec.yaml)

```yaml
dependencies:
  google_fonts: ^6.2.1        # Space Grotesk + Work Sans
  audioplayers: ^6.1.0        # MP3-Wiedergabe
  vibration: ^2.0.0           # Vibration
  wakelock_plus: ^1.2.8       # Bildschirm wach halten
  shared_preferences: ^2.3.3  # Einstellungen speichern
  flutter_ringtone_player: ^4.0.0  # Nativer Android-Alarmsound
  file_picker: ^8.1.2         # Eigene Audiodatei auswählen

dev_dependencies:
  flutter_launcher_icons: ^0.14.3  # Icon-Generierung
```

---

## Signing / Keystore

| | |
|---|---|
| Keystore-Datei | `gestalten-sass.keystore` (im Projektroot) |
| Alias | `smart_alarm` |
| Passwort | `SmartAlarm2026!` |
| Konfiguration | `android/key.properties` |

**Wichtig:** Keystore sicher aufbewahren (USB-Stick / Cloud-Backup) — ohne ihn sind keine Updates möglich!

---

## APK / Bundle bauen & installieren

```bash
cd ~/claude-code/Stich/smart_alarm

# Debug-Build
flutter build apk --debug
adb install -r build/app/outputs/flutter-apk/app-debug.apk

# Release-APK
flutter build apk --release
adb install -r build/app/outputs/flutter-apk/app-release.apk

# Signiertes App Bundle für Google Play
flutter build appbundle --release
# → build/app/outputs/bundle/release/app-release.aab
```

---

## Google Play Veröffentlichung

**Preis:** 2,99 €  
**Kategorie:** Tools  
**Datenschutz-URL:** `gestalten-sass.de/datenschutzerklaerung/`

| Schritt | Status |
|---------|--------|
| Developer Account angelegt | ✅ |
| Identitätsbestätigung | ⏳ ausstehend |
| Telefonnummer bestätigen | ⏳ nach Identitätsbestätigung |
| Website bestätigt | ✅ |
| App Bundle hochgeladen | ✅ |
| Beschreibungen eingetragen | ✅ |
| Feature-Grafik hochgeladen | ✅ |
| App-Symbol hochgeladen | ✅ |
| Screenshots | ❌ noch ausstehend (mind. 2, selbst machen) |
| Einreichung zur Überprüfung | ❌ erst nach Identitätsbestätigung |

---

## Offene Punkte

- [ ] Warten auf Google-Identitätsbestätigung
- [ ] Telefonnummer bestätigen
- [ ] Screenshots hochladen (mind. 2 vom Smartphone)
- [ ] App zur Überprüfung einreichen
