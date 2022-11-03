import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

void main()  async{

  // Set `enableInDevMode` to true to see reports while in debug mode
  // This is only to be used for confirming that reports are being
  // submitted as expected. It is not intended to be used for everyday
  // development.

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( );


  /*await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );*/


  FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

  // Pass all uncaught errors from the framework to Crashlytics.
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

  /*SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.green,
  ));*/

  runZoned<Future<void>>(() async {
    runApp(MyApp());
    // ignore: deprecated_member_use
  }, onError: FirebaseCrashlytics.instance.recordError);

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });

  //runApp(MyApp());
}

/*Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp().whenComplete(() => {

   // FirebaseCrashlytics.instance.isCrashlyticsCollectionEnabled(true),
    print(' App NAme ${FirebaseCrashlytics.instance.app.name}')
  });



// Elsewhere in your code
  //FirebaseCrashlytics.instance.crash();
  */ /*runZonedGuarded(() {
    runApp(RecruiterApp());
    // runApp(MyApp());
  }, (error, stackTrace) {
    print('runZonedGuarded: Caught error in my root zone.');
    FirebaseCrashlytics.instance.recordError(error, stackTrace);
  });

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(RecruiterApp());
    //runApp(MyApp());
  });*/ /*

  runApp( MyApp());
}*/
