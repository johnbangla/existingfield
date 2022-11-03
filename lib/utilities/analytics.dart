import 'package:firebase_analytics/firebase_analytics.dart';

class Analytics {
  final FirebaseAnalytics _firebaseAnalytics = FirebaseAnalytics.instance;

  Analytics() {
    _firebaseAnalytics.setAnalyticsCollectionEnabled(false);
    _firebaseAnalytics.setAnalyticsCollectionEnabled(true);
  }

  Future<void> setCurrentScreen(
      String screenName, String overrideClassName) async {
    await _firebaseAnalytics.setCurrentScreen(
      screenName: screenName,
      screenClassOverride: overrideClassName,
    );
  }

  Future<void> setUserProperty(String userid) async {
    //_firebaseAnalytics.setUserId(id)
    await _firebaseAnalytics.setUserProperty(name: 'userId', value: userid);
    
  }

  Future<void> setUserId(String userid) async {
    //_firebaseAnalytics.setUserId(id)
    await _firebaseAnalytics.setUserId(id: "User $userid");

  }

  FirebaseAnalytics get firebaseAnalytics => _firebaseAnalytics;
}

final analytics = Analytics();