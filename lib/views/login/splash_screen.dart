import 'package:buro_employee/config/custom_page_route.dart';
import 'package:buro_employee/localization/Language/languages.dart';
import 'package:buro_employee/sessionmanager/session_manager.dart';
import 'package:buro_employee/theme/colors.dart';
import 'package:buro_employee/utilities/analytics.dart';
import 'package:buro_employee/utilities/asset_paths.dart';
import 'package:buro_employee/utilities/common_methods.dart';
import 'package:buro_employee/views/login/forget_password.dart';
import 'package:buro_employee/views/login/login_screen.dart';
import 'package:buro_employee/views/login/test.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../app.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  static const routeName = '/splash';

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => SplashScreen());
  }

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var myImage;
  @override
  void initState() {
    super.initState();

    myImage= assetsPath.BURO_WHITE_ICON;

    CommonMethods.getSelectedLang().then((value) => {
      //selectedLang = value,
      print('selected Lang Splash $value')

    });

    _navigateToHome();

    final String assetName = 'assetsPath.BURO_WHITE_ICON';
    final Widget svg = SvgPicture.asset(
        assetName,
        semanticsLabel: 'Acme Logo'
    );

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
//1500
  //3000
  void _navigateToHome() async {
    await Future.delayed(Duration(microseconds: 5000), () {});

    var loginStatus = await sessionManager.isLoggedIn;

    if (loginStatus == false) {
      Navigator.pushNamedAndRemoveUntil(
          context, LoginScreen.routeName, (route) => false);
      //Navigator.of(context).push(CustomPageRoute(child: LoginScreen(),axisDirection: AxisDirection.up));
 // Navigator.of(context).push(CustomPageRoute(child: ForgetPassword(),axisDirection: AxisDirection.up));

    } else
      Navigator.pushNamedAndRemoveUntil(
          context, LandingScreen.routeName, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    analytics.firebaseAnalytics.logAppOpen();


    return Scaffold(

      backgroundColor: const Color(0xe1f5fe),

      body: Container(

        color:ColorResources.APP_THEME_COLOR,
        child: Center(
          child: /*Text(
            Languages.of(context)!.loadingText,
            style: TextStyle(color: Colors.white),
          ),*/

          SvgPicture.asset(
              assetsPath.BURO_WHITE_ICON


          ),
        ),
      ),
    );
  }
}
