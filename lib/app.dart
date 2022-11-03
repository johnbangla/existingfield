import 'dart:convert';
import 'dart:typed_data';
import 'package:buro_employee/config/route.dart';
import 'package:buro_employee/repository/bloc/apply_cubit/apply_cubit.dart';
import 'package:buro_employee/repository/bloc/approval_details/approval_details_cubit.dart';
import 'package:buro_employee/repository/bloc/approval_request/approval_request_cubit.dart';
import 'package:buro_employee/repository/bloc/bill_bloc/bill_bloc_cubit.dart';
import 'package:buro_employee/repository/bloc/bill_details/bill_details_cubit.dart';
import 'package:buro_employee/repository/bloc/bill_req_list_cubit/bill_req_list_cubit.dart';
import 'package:buro_employee/repository/bloc/change_password/change_pass_cubit.dart';
import 'package:buro_employee/repository/bloc/forgot_pass_verification/forgot_pass_verification_cubit.dart';
import 'package:buro_employee/repository/bloc/login/generate_otp_cubit.dart';
import 'package:buro_employee/repository/bloc/home_cubit/home_cubit.dart';
import 'package:buro_employee/repository/bloc/module/module_cubit.dart';
import 'package:buro_employee/repository/bloc/my_request/request_cubit.dart';
import 'package:buro_employee/repository/bloc/plan_approval_cubit/plan_approval_cubit.dart';
import 'package:buro_employee/repository/bloc/plan_approval_details_cubit/plan_approval_details_cubit.dart';
import 'package:buro_employee/repository/bloc/plan_detail_cubit/plan_detail_cubit.dart';
import 'package:buro_employee/repository/bloc/plan_list_cubit/plan_list_cubit.dart';
import 'package:buro_employee/repository/bloc/request_details/request_details_cubit.dart';
import 'package:buro_employee/repository/bloc/reset_pass/reset_pass_cubit.dart';
import 'package:buro_employee/repository/bloc/sub_module/sub_module_cubit.dart';
import 'package:buro_employee/repository/network/buro_repository.dart';
import 'package:buro_employee/repository/bloc/login/login_cubit.dart';
import 'package:buro_employee/repository/bloc/login/verify_otp_cubit.dart';
import 'package:buro_employee/sessionmanager/session_manager.dart';
import 'package:buro_employee/theme/colors.dart';
import 'package:buro_employee/theme/styles.dart';
import 'package:buro_employee/views/home/change_password.dart';
import 'package:buro_employee/views/home/employee_profile.dart';
import 'package:buro_employee/views/home/home_page.dart';
import 'package:buro_employee/views/login/login_screen.dart';
import 'package:buro_employee/views/login/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'localization/Language/languages.dart';
import 'localization/locale_constants.dart';
import 'localization/localizations_delegate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

//import 'package:package_info/package_info.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class MyApp extends StatefulWidget {
  static GlobalKey<NavigatorState> materialKey = GlobalKey();

  static void setLocale(BuildContext context, Locale newLocale) {
    var state = context.findAncestorStateOfType<_MyAppState>();
    state!.setLocale(newLocale);
  }

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Locale? _locale = null;
  final appRouter = AppRouter();

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  @override
  void didChangeDependencies() {
    print("Log didChangeDependencies called My App");

    getLocale().then((locale) {
      setState(() {
        _locale = locale;
      });
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    return _InitProviders(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: MyApp.materialKey,
        onGenerateRoute: appRouter.onGenerateRoute,
        initialRoute: SplashScreen.routeName,
        navigatorObservers: <NavigatorObserver>[observer],
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        locale: _locale,
        supportedLocales: [
          Locale('en', ''),
          Locale('bn', ''),
        ],
        localizationsDelegates: [
          AppLocalizationsDelegate(),
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale?.languageCode &&
                supportedLocale.countryCode == locale?.countryCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first;
        },
      ),
    );
  }
}

class LandingScreen extends StatefulWidget {
  static const routeName = '/landing';

  static route() =>
      MaterialPageRoute(builder: (_) => LandingScreen(title: "title"));

  LandingScreen({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  int _currentIndex = 0;
  var selectedLang;
  var isSelected = <bool>[true, false];
  var appVersion;
  String selectedText = "English";
  bool isChanged = true;

  final List<Widget> _children = [
    HomeScreen(), //0
    EmployeeProfile(), //1
    ChangePassword(), //2
  ];

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
    getSelectedLang().then((value) => {
          selectedLang = value,
          print('selectedLang in app.dart  $selectedLang'),
          if (selectedLang.toString().isEmpty)
            {
              print('In First Condition'),
              selectedText = 'বাংলা',
            }
          else if (selectedLang.toString() == 'bn')
            {
              print('In Second Condition'),
              selectedText = 'English',
            }
          else if (selectedLang.toString() == 'en')
            {print('In Third Condition'), selectedText = 'বাংলা'},

    setState(() {}),
        });



    /*getPackageInfo().then((value) =>
        {appVersion = value.version, print('Version ${value.buildNumber}')});*/
    final bloc = context.read<ModuleCubit>();
    bloc.getModule();
  }

  Future<void> _initPackageInfo() async {
    //final PackageInfo info = await ;
    /*setState(() {
      _packageInfo = info.;
    });*/
  }

  Future<String> getSelectedLang() async {
    return await sessionManager.selectedLang;
  }

  /* Future< PackageInfo> getPackageInfo() async {
    return await PackageInfo.fromPlatform();
  }*/

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    var bang = false;
    var eng = false;
    isSelected = <bool>[bang, eng];
    /* Future.delayed(Duration(milliseconds: 10000)).then((_) {
      if (selectedLang == 'bn') {
        selectedText = 'বাংলা';
      } else
        selectedText = 'English';

      if (this.mounted) {
        // check whether the state object is in tree
        setState(() {
          // make changes here
        });
      }
    });*/
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ModuleCubit, ModuleState>(
      listener: (context, state) {
        if (state is ModuleErrorState) {
          /* Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("Network Error"),
            ),
          );*/
        }
      },
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if (state is ModuleInitial) {
          return Scaffold(
              endDrawer: _endDrawer(),
              body: Center(
                child: CircularProgressIndicator(),
              ));
        } else if (state is ModuleLoading) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: ColorResources.APP_THEME_COLOR,
                title: Text(
                  '${Languages.of(context)?.labelWelcome}',
                  style: Styles.titleStyle,
                ),
              ),
              endDrawer: _endDrawer(),
              body: Center(
                child: CircularProgressIndicator(),
              ));
        } else if (state is ModuleLoaded) {
          var prflImgSrc = base64Decode(state.module.data.imgEmp);
          var supervisor = state.module.data.supervisor;
          var name = state.module.data.employeeName;
          var designation = state.module.data.designationName;
          var employeeCode = state.module.data.employeeCode;

          sessionManager.setSupervisorInfo(supervisor);
          var messageBn = state.module.data.broadcastMsgBn;
          var messageEn = state.module.data.broadcastMsgEn;

          return Scaffold(
            endDrawer: _endDrawerWIthImage(prflImgSrc, name, designation),
            key: _scaffoldKey,
            body: Builder(builder: (BuildContext context) {
              return Stack(
                children: [
                  Container(
                    height: 310,
                    child: Stack(
                      children: [
                        ClipPath(
                          clipper: OvalBottomBorderClipper(),
                          child: Container(
                            color: ColorResources.APP_THEME_COLOR,
                            height: 350.0,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: ColorResources.APP_THEME_COLOR,
                              radius: 60,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 5, bottom: 5),
                                child: ClipOval(
                                  child: Image.memory(prflImgSrc),
                                ),
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 107),
                                child: Column(
                                  //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      name,
                                      style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                          color:
                                              ColorResources.NAME_TEXT_COLOR),
                                    ),
                                    Text(
                                      designation,
                                      style: GoogleFonts.inter(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 14,
                                          color: ColorResources.WHITE),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text('Employee ID',
                                        style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            color:
                                                ColorResources.NAME_TEXT_COLOR),
                                        textAlign: TextAlign.left),
                                    Text(employeeCode,
                                        style: GoogleFonts.inter(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12,
                                            color: ColorResources.WHITE),
                                        textAlign: TextAlign.start)
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 30, right: 15),
                          child: Align(
                              alignment: Alignment.topRight,
                              child: IconButton(
                                color: Colors.white,
                                icon: Icon(Icons.menu),
                                onPressed: () {
                                  Scaffold.of(context).openEndDrawer();

                                  //}
                                },
                              )),
                        )
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.topCenter,
                    padding: new EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * .23,
                    ),
                    child: new Container(
                        //height: 500.0,
                        width: MediaQuery.of(context).size.width,
                        child: _children[_currentIndex]),
                  ),
                ],
              );
            }),
          );
        } else if (state is ModuleErrorState) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: ColorResources.APP_THEME_COLOR,
                title: Text(
                  '${Languages.of(context)?.labelWelcome}',
                  style: Styles.titleStyle,
                ),
              ),
              endDrawer: _endDrawer(),
              body: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  color: ColorResources.PAGE_BACKGROUND,
                  child: RefreshIndicator(
                    onRefresh: refresh,
                    child: Center(
                      child: Container(
                        child: Text('Network Error'),
                      ),
                    ),
                  ),
                ),
              ));
        } else {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: ColorResources.APP_THEME_COLOR,
                title: Text(
                  '${Languages.of(context)?.labelWelcome}',
                  style: Styles.titleStyle,
                ),
              ),
              endDrawer: _endDrawer(),
              body: Center(
                child: Container(
                  child: Text('Error'),
                ),
              ));
        }
      },
    );
  }

  Drawer _endDrawer() {
    return Drawer(
      elevation: 10,
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '',
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: ColorResources.NAME_BLACK_COLOR),
                      ),
                      Text(
                        '',
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: ColorResources.NAME_BLACK_COLOR),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: ColorResources.GREY_THIRTY,
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(Languages.of(context)!.home,
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: ColorResources.NAME_BLACK_COLOR)),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop(); // onTabTapped(0);
                      setState(() {
                        _currentIndex = 0;
                      });
                    },
                    child: Text(Languages.of(context)!.myHome,
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: ColorResources.APP_THEME_COLOR)),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(Languages.of(context)!.profile,
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: ColorResources.NAME_BLACK_COLOR)),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      setState(() {
                        _currentIndex = 1;
                      });
                    },
                    child: Text(Languages.of(context)!.myProfile,
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: ColorResources.APP_THEME_COLOR)),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(Languages.of(context)!.language,
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: ColorResources.NAME_BLACK_COLOR)),
                  TextButton(
                    onPressed: () {
                      isChanged = !isChanged;
                      setState(() {
                        if (isChanged == true) {
                          selectedText = "English";
                          changeLanguage(context, 'en');
                        } else {
                          selectedText = "বাংলা";
                          changeLanguage(context, 'bn');
                        }
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text('$selectedText',
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: ColorResources.APP_THEME_COLOR)),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Languages.of(context)!.password,
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: ColorResources.NAME_BLACK_COLOR),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      setState(() {
                        _currentIndex = 2;
                      });
                    },
                    child: Text(Languages.of(context)!.changePassword,
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: ColorResources.APP_THEME_COLOR)),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: ColorResources.GREY_THIRTY,
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                  onPressed: logOut,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text('${Languages.of(context)!.logout}',
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: ColorResources.LIGHT_YELLOW)),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: ColorResources.GREY_THIRTY,
            ),
          ],
        ),
      ),
    );
  }

  Drawer _endDrawerWIthImage(
      Uint8List profileImage, String name, String designation) {
    return Drawer(
      elevation: 10,
      child: Container(
        color: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: CircleAvatar(
                    backgroundColor: ColorResources.WHITE,
                    radius: 40,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5, bottom: 5),
                      child: ClipOval(
                        child: Image.memory(profileImage),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                            color: ColorResources.NAME_BLACK_COLOR),
                      ),
                      Text(
                        designation,
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: ColorResources.NAME_BLACK_COLOR),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: ColorResources.GREY_THIRTY,
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(Languages.of(context)!.home,
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: ColorResources.NAME_BLACK_COLOR)),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop(); // onTabTapped(0);
                      setState(() {
                        _currentIndex = 0;
                      });
                    },
                    child: Text(Languages.of(context)!.myHome,
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: ColorResources.APP_THEME_COLOR)),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(Languages.of(context)!.profile,
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: ColorResources.NAME_BLACK_COLOR)),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      setState(() {
                        _currentIndex = 1;
                      });
                    },
                    child: Text(Languages.of(context)!.myProfile,
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: ColorResources.APP_THEME_COLOR)),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(Languages.of(context)!.language,
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                          color: ColorResources.NAME_BLACK_COLOR)),
                  TextButton(
                    onPressed: () {
                      isChanged = !isChanged;
                      print('Selected Text $selectedText');
                      if (isChanged == true) {
                        selectedText = "বাংলা";
                        changeLanguage(context, 'en');
                      } else {
                        selectedText = "English";
                        changeLanguage(context, 'bn');
                      }
                      setState(() {});
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text('$selectedText',
                          style: GoogleFonts.inter(
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              color: ColorResources.APP_THEME_COLOR)),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Languages.of(context)!.password,
                    style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: ColorResources.NAME_BLACK_COLOR),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pop();
                      setState(() {
                        _currentIndex = 2;
                      });
                    },
                    child: Text(Languages.of(context)!.changePassword,
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: ColorResources.APP_THEME_COLOR)),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: ColorResources.GREY_THIRTY,
            ),
            SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                  onPressed: logOut,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text('${Languages.of(context)!.logout}',
                        style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: ColorResources.LIGHT_YELLOW)),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            Divider(
              height: 1,
              thickness: 1,
              color: ColorResources.GREY_THIRTY,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> logOut() async {
    Navigator.of(context).pop();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Languages.of(context)!.dialogHeader),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(Languages.of(context)!.logOutText),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(Languages.of(context)!.no),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the Dialog
              },
            ),
            TextButton(
              child: Text(Languages.of(context)!.yes),
              onPressed: () async {
                sessionManager.setIsLoggedIn(false);
                sessionManager.setUserID('');
                sessionManager.setPassword('');
                Navigator.pop(context);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ));
              },
            ),
          ],
        );
      },
    );
  }

  Future refresh() {
    return Future.delayed(
      Duration(seconds: 1),
      () {
        final bloc = context.read<ModuleCubit>();
        bloc.getModule();
        //initState();
        /// adding elements in list after [1 seconds] delay
        /// to mimic network call
        ///
        /// Remember: [setState] is necessary so that
        /// build method will run again otherwise
        /// list will not show all elements

        // showing snackbar
        // CommonMethods.showMessage(context, "Refreshed", Colors.green);
      },
    );
  }
}

class _InitProviders extends StatelessWidget {
  final Widget child;

  const _InitProviders({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginCubit>(
          create: (BuildContext context) =>
              LoginCubit(buroRepository: BuroRepository()),
        ),
        BlocProvider<VerifyOtpCubit>(
          create: (BuildContext context) => VerifyOtpCubit(BuroRepository()),
        ),
        BlocProvider<ModuleCubit>(
          create: (BuildContext context) => ModuleCubit(BuroRepository()),
        ),
        BlocProvider<SubModuleCubit>(
          create: (context) => SubModuleCubit(BuroRepository()),
        ),
        BlocProvider<RequestCubit>(
          create: (context) => RequestCubit(BuroRepository()),
        ),
        BlocProvider<RequestDetailsCubit>(
          create: (context) => RequestDetailsCubit(BuroRepository()),
        ),
        BlocProvider<ApprovalRequestCubit>(
          create: (context) => ApprovalRequestCubit(BuroRepository()),
        ),
        BlocProvider<ApprovalDetailsCubit>(
          create: (context) => ApprovalDetailsCubit(BuroRepository()),
        ),
        BlocProvider<HomeCubit>(
          create: (context) => HomeCubit(BuroRepository()),
        ),
        BlocProvider<ChangePasswordCubit>(
          create: (context) => ChangePasswordCubit(BuroRepository()),
        ),
        BlocProvider<GenerateOtpCubit>(
          create: (BuildContext context) =>
              GenerateOtpCubit(buroRepository: BuroRepository()),
        ),
        BlocProvider<ForgotPassVerificationCubit>(
          create: (BuildContext context) =>
              ForgotPassVerificationCubit(buroRepository: BuroRepository()),
        ),
        BlocProvider<BillBlocCubit>(
          create: (BuildContext context) =>
              BillBlocCubit(buroRepository: BuroRepository()),
        ),
        BlocProvider<BillReqListCubit>(
          create: (BuildContext context) => BillReqListCubit(BuroRepository()),
        ),
        BlocProvider<ResetPassCubit>(
          create: (BuildContext context) => ResetPassCubit(BuroRepository()),
        ),
        BlocProvider<BillDetailsCubit>(
          create: (BuildContext context) => BillDetailsCubit(BuroRepository()),
        ),
        BlocProvider<PlanListCubit>(
          create: (BuildContext context) => PlanListCubit(BuroRepository()),
        ),
        BlocProvider<PlanDetailCubit>(
          create: (BuildContext context) => PlanDetailCubit(BuroRepository()),
        ),
        BlocProvider<PlanApprovalCubit>(
          create: (BuildContext context) => PlanApprovalCubit(BuroRepository()),
        ),
        BlocProvider<PlanApprovalDetailsCubit>(
          create: (BuildContext context) =>
              PlanApprovalDetailsCubit(BuroRepository()),
        ),
        BlocProvider<ApplyCubit>(
          create: (BuildContext context) => ApplyCubit(BuroRepository()),
        )
      ],
      child: child,
    );
  }
}
