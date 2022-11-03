import 'dart:ui';

import 'package:buro_employee/main.dart';
import 'package:buro_employee/sessionmanager/session_manager.dart';
import 'package:buro_employee/utilities/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../app.dart';



const String prefSelectedLanguageCode = "SelectedLanguageCode";

Future<Locale> setLocale(String languageCode, String from) async {
  //print("Log setLocale called in $languageCode ");
  sessionManager.selectedLang.then((value) => {
    //print('Condition Out value $value'),
   if(value != languageCode){
     //print('Condition In'),
     SessionManager().setLang(languageCode)
   }

 }) ;


  return _locale(languageCode);
}

Future<Locale> getLocale() async {
  String languageCode = await sessionManager.selectedLang;
  //print("Log getLocale called in  $languageCode ");
  return _locale(languageCode );
}

Locale _locale(String languageCode)  {
  //print("Log _locale called in $languageCode ");
  //setLanguage(languageCode);
  return languageCode != null && languageCode.isNotEmpty
      ? Locale(languageCode, '')
      : Locale('en', '');
}

void setLanguage(String lang) async{
  //print('Log SetLanguage called $lang');
  if(lang != null && lang.isNotEmpty)
    await setLocale(lang,'setLanguage Method');
   else
    await setLocale('en','setLanguage Method');



}

void changeLanguage(BuildContext context, String selectedLanguageCode) async {
  //print("Log changeLanguage ${selectedLanguageCode}");
  var _locale = await setLocale(selectedLanguageCode,'changeLanguage method');
  MyApp.setLocale(context, _locale);
}
