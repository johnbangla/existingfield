import 'package:flutter/material.dart';
import 'package:buro_employee/localization/Language/language_bn.dart';
import 'package:buro_employee/localization/Language/language_en.dart';
import 'package:buro_employee/localization/Language/languages.dart';

class AppLocalizationsDelegate extends LocalizationsDelegate<Languages> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    //print('Log AppLocalizationsDelegate isSupported called');
    return [ 'bn','en'].contains(locale.languageCode);

  }

  @override
  Future<Languages> load(Locale locale) {
    //print('Log AppLocalizationsDelegate load called');
    return  _load(locale);
  }

  static Future<Languages> _load(Locale locale) async {

    //print('Log AppLocalizationsDelegate _load called');

    //print("Language Code ${locale.languageCode}");
    switch (locale.languageCode) {
      case 'en':
        {
          //print("Log _load english switch called");
          return LanguageEn();
        }



      case 'bn':
        {
          //print("Log _load bangla switch called");
          return LanguageBn();
        }

      default:
        {
          //print("Log _load default english called");
          return LanguageEn();
        }
    }
  }

  @override
  bool shouldReload(LocalizationsDelegate<Languages> old) {
    //print('Log AppLocalizationsDelegate shouldReload called');

    return false;
  }
}
