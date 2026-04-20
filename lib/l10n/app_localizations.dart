import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_nl.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('nl'),
  ];

  /// No description provided for @navCentral.
  ///
  /// In de, this message translates to:
  /// **'Zentrale'**
  String get navCentral;

  /// No description provided for @navSettings.
  ///
  /// In de, this message translates to:
  /// **'Einstellungen'**
  String get navSettings;

  /// No description provided for @navInfo.
  ///
  /// In de, this message translates to:
  /// **'Info'**
  String get navInfo;

  /// No description provided for @homeAlarmCentral.
  ///
  /// In de, this message translates to:
  /// **'ALARM-ZENTRALE'**
  String get homeAlarmCentral;

  /// No description provided for @homeSystemReady.
  ///
  /// In de, this message translates to:
  /// **'System aktiv & bereit'**
  String get homeSystemReady;

  /// No description provided for @homeAlarm.
  ///
  /// In de, this message translates to:
  /// **'ALARM'**
  String get homeAlarm;

  /// No description provided for @homeTapToActivate.
  ///
  /// In de, this message translates to:
  /// **'Tippen zum Auslösen'**
  String get homeTapToActivate;

  /// No description provided for @homeKeepDeviceReady.
  ///
  /// In de, this message translates to:
  /// **'Halte das Gerät griffbereit'**
  String get homeKeepDeviceReady;

  /// No description provided for @homeNoEmergencyCall.
  ///
  /// In de, this message translates to:
  /// **'Kein Notruf · Nur akustische Abschreckung'**
  String get homeNoEmergencyCall;

  /// No description provided for @homeReady.
  ///
  /// In de, this message translates to:
  /// **'BEREIT'**
  String get homeReady;

  /// No description provided for @alarmActiveBanner.
  ///
  /// In de, this message translates to:
  /// **'⚠  ALARM AKTIV  ⚠'**
  String get alarmActiveBanner;

  /// No description provided for @alarmWord.
  ///
  /// In de, this message translates to:
  /// **'ALARM'**
  String get alarmWord;

  /// No description provided for @alarmActiveWord.
  ///
  /// In de, this message translates to:
  /// **'AKTIV'**
  String get alarmActiveWord;

  /// No description provided for @alarmTriggered.
  ///
  /// In de, this message translates to:
  /// **'Alarm wurde ausgelöst'**
  String get alarmTriggered;

  /// No description provided for @alarmStop.
  ///
  /// In de, this message translates to:
  /// **'ALARM STOPPEN'**
  String get alarmStop;

  /// No description provided for @settingsTitle.
  ///
  /// In de, this message translates to:
  /// **'Einstellungen'**
  String get settingsTitle;

  /// No description provided for @settingsSectionAlarmSignal.
  ///
  /// In de, this message translates to:
  /// **'ALARMSIGNAL'**
  String get settingsSectionAlarmSignal;

  /// No description provided for @settingsSiren.
  ///
  /// In de, this message translates to:
  /// **'Sirene'**
  String get settingsSiren;

  /// No description provided for @settingsSirenSubtitle.
  ///
  /// In de, this message translates to:
  /// **'Klassisches Alarm-Signal des Geräts'**
  String get settingsSirenSubtitle;

  /// No description provided for @settingsDog.
  ///
  /// In de, this message translates to:
  /// **'Hundegebell'**
  String get settingsDog;

  /// No description provided for @settingsDogSubtitle.
  ///
  /// In de, this message translates to:
  /// **'Bellender Hund als Abschreckung'**
  String get settingsDogSubtitle;

  /// No description provided for @settingsCustomFile.
  ///
  /// In de, this message translates to:
  /// **'Eigene Datei'**
  String get settingsCustomFile;

  /// No description provided for @settingsCustomFileSubtitle.
  ///
  /// In de, this message translates to:
  /// **'MP3, WAV, OGG oder M4A auswählen'**
  String get settingsCustomFileSubtitle;

  /// No description provided for @settingsSectionGeneral.
  ///
  /// In de, this message translates to:
  /// **'ALLGEMEIN'**
  String get settingsSectionGeneral;

  /// No description provided for @settingsVibration.
  ///
  /// In de, this message translates to:
  /// **'Vibration'**
  String get settingsVibration;

  /// No description provided for @settingsVibrationSubtitle.
  ///
  /// In de, this message translates to:
  /// **'Vibration beim Alarm aktivieren'**
  String get settingsVibrationSubtitle;

  /// No description provided for @settingsKeepScreenOn.
  ///
  /// In de, this message translates to:
  /// **'Bildschirm wach halten'**
  String get settingsKeepScreenOn;

  /// No description provided for @settingsKeepScreenOnSubtitle.
  ///
  /// In de, this message translates to:
  /// **'Display bei aktivem Alarm eingeschaltet lassen'**
  String get settingsKeepScreenOnSubtitle;

  /// No description provided for @settingsSectionLanguage.
  ///
  /// In de, this message translates to:
  /// **'SPRACHE'**
  String get settingsSectionLanguage;

  /// No description provided for @settingsSectionApp.
  ///
  /// In de, this message translates to:
  /// **'APP'**
  String get settingsSectionApp;

  /// No description provided for @settingsVersion.
  ///
  /// In de, this message translates to:
  /// **'Version'**
  String get settingsVersion;

  /// No description provided for @settingsVersionValue.
  ///
  /// In de, this message translates to:
  /// **'1.0.0 · Gestalten Sass'**
  String get settingsVersionValue;

  /// No description provided for @infoTitle.
  ///
  /// In de, this message translates to:
  /// **'Sicherheit & Info'**
  String get infoTitle;

  /// No description provided for @infoNoEmergencyTitle.
  ///
  /// In de, this message translates to:
  /// **'KEIN NOTRUF'**
  String get infoNoEmergencyTitle;

  /// No description provided for @infoNoEmergencyBody.
  ///
  /// In de, this message translates to:
  /// **'SmartAlarm sendet kein Notruf-Signal, nutzt kein GPS und ruft keine Hilfe. Die App dient ausschließlich zur akustischen Abschreckung. Sie macht laut auf dich aufmerksam, mehr nicht.'**
  String get infoNoEmergencyBody;

  /// No description provided for @infoWhatIsTitle.
  ///
  /// In de, this message translates to:
  /// **'WAS IST SMARTALARM?'**
  String get infoWhatIsTitle;

  /// No description provided for @infoWhatIsBody.
  ///
  /// In de, this message translates to:
  /// **'SmartAlarm ist dein persönlicher Notalarm, immer dabei, sofort einsatzbereit. Mit einem einzigen Tipp auf den großen roten Button löst du einen lauten Alarm aus und ziehst sofort Aufmerksamkeit auf dich. Egal wo du bist: SmartAlarm reagiert ohne Verzögerung.'**
  String get infoWhatIsBody;

  /// No description provided for @infoUseCasesTitle.
  ///
  /// In de, this message translates to:
  /// **'TYPISCHE EINSATZSITUATIONEN'**
  String get infoUseCasesTitle;

  /// No description provided for @infoUseCaseRvTitle.
  ///
  /// In de, this message translates to:
  /// **'Wohnmobil & Camping'**
  String get infoUseCaseRvTitle;

  /// No description provided for @infoUseCaseRvBody.
  ///
  /// In de, this message translates to:
  /// **'Auf einsamen Stellplätzen oder abseits der Zivilisation schnell auf sich aufmerksam machen.'**
  String get infoUseCaseRvBody;

  /// No description provided for @infoUseCaseOutdoorTitle.
  ///
  /// In de, this message translates to:
  /// **'Outdoor & Wandern'**
  String get infoUseCaseOutdoorTitle;

  /// No description provided for @infoUseCaseOutdoorBody.
  ///
  /// In de, this message translates to:
  /// **'Für Wanderer, Jogger und Radfahrer in abgelegenen Gebieten, auch ohne Mobilfunknetz nutzbar.'**
  String get infoUseCaseOutdoorBody;

  /// No description provided for @infoUseCasePublicTitle.
  ///
  /// In de, this message translates to:
  /// **'Öffentlicher Raum'**
  String get infoUseCasePublicTitle;

  /// No description provided for @infoUseCasePublicBody.
  ///
  /// In de, this message translates to:
  /// **'Bei bedrohlichen Situationen auf der Straße, im öffentlichen Verkehr oder auf dem Schulweg.'**
  String get infoUseCasePublicBody;

  /// No description provided for @infoUseCaseSeniorsTitle.
  ///
  /// In de, this message translates to:
  /// **'Senioren & Alleinreisende'**
  String get infoUseCaseSeniorsTitle;

  /// No description provided for @infoUseCaseSeniorsBody.
  ///
  /// In de, this message translates to:
  /// **'Für Menschen, die alleine leben oder unterwegs sind und schnell Hilfe auf sich ziehen müssen.'**
  String get infoUseCaseSeniorsBody;

  /// No description provided for @infoHowItWorksTitle.
  ///
  /// In de, this message translates to:
  /// **'SO FUNKTIONIERT ES'**
  String get infoHowItWorksTitle;

  /// No description provided for @infoHowTriggerTitle.
  ///
  /// In de, this message translates to:
  /// **'Alarm auslösen'**
  String get infoHowTriggerTitle;

  /// No description provided for @infoHowTriggerBody.
  ///
  /// In de, this message translates to:
  /// **'Tippe auf den großen roten Button auf der Hauptseite. Der Alarm startet sofort mit maximaler Lautstärke.'**
  String get infoHowTriggerBody;

  /// No description provided for @infoHowVolumeTitle.
  ///
  /// In de, this message translates to:
  /// **'Lautstärke & Vibration'**
  String get infoHowVolumeTitle;

  /// No description provided for @infoHowVolumeBody.
  ///
  /// In de, this message translates to:
  /// **'Der Alarm wird mit maximaler Lautstärke ausgegeben. Vibration kann in den Einstellungen ein- oder ausgeschaltet werden.'**
  String get infoHowVolumeBody;

  /// No description provided for @infoHowSoundTitle.
  ///
  /// In de, this message translates to:
  /// **'Alarmsignal wählen'**
  String get infoHowSoundTitle;

  /// No description provided for @infoHowSoundBody.
  ///
  /// In de, this message translates to:
  /// **'Wähle zwischen Sirene, Hundegebell oder einer eigenen Audiodatei (MP3, WAV, OGG, M4A).'**
  String get infoHowSoundBody;

  /// No description provided for @infoHowStopTitle.
  ///
  /// In de, this message translates to:
  /// **'Alarm stoppen'**
  String get infoHowStopTitle;

  /// No description provided for @infoHowStopBody.
  ///
  /// In de, this message translates to:
  /// **'Tippe auf \"Alarm stoppen\" auf dem Alarm-Bildschirm, um den Alarm zu beenden.'**
  String get infoHowStopBody;

  /// No description provided for @infoWhyOfflineTitle.
  ///
  /// In de, this message translates to:
  /// **'WARUM KEINE INTERNETVERBINDUNG?'**
  String get infoWhyOfflineTitle;

  /// No description provided for @infoWhyOfflineBody.
  ///
  /// In de, this message translates to:
  /// **'SmartAlarm wurde bewusst ohne Netzwerkfunktion entwickelt. Das hat mehrere Vorteile: Die App funktioniert überall, auch ohne WLAN oder Mobilfunknetz, in Kellern, auf Berghütten oder im Ausland. Es werden keinerlei Daten gesendet oder empfangen. Und es gibt keine Abhängigkeit von Servern oder Diensten, die ausfallen könnten.\n\nDie Stärke der App liegt in ihrer Einfachheit: Ein Knopfdruck, sofortiger Alarm.'**
  String get infoWhyOfflineBody;

  /// No description provided for @infoPrivacyTitle.
  ///
  /// In de, this message translates to:
  /// **'DATENSCHUTZ'**
  String get infoPrivacyTitle;

  /// No description provided for @infoPrivacyBody.
  ///
  /// In de, this message translates to:
  /// **'SmartAlarm erhebt keine personenbezogenen Daten, benötigt keine Internetverbindung und sendet nichts nach außen. Alle Einstellungen bleiben ausschließlich auf deinem Gerät.'**
  String get infoPrivacyBody;

  /// No description provided for @infoAppInfoTitle.
  ///
  /// In de, this message translates to:
  /// **'APP-INFO'**
  String get infoAppInfoTitle;

  /// No description provided for @infoDeveloper.
  ///
  /// In de, this message translates to:
  /// **'Entwickelt von'**
  String get infoDeveloper;

  /// No description provided for @infoPlatform.
  ///
  /// In de, this message translates to:
  /// **'Plattform'**
  String get infoPlatform;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'it',
    'nl',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'nl':
      return AppLocalizationsNl();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
