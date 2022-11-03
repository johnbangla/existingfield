import 'dart:io';

import 'package:buro_employee/localization/Language/languages.dart';
import 'package:buro_employee/repository/models/login_user.dart';
import 'package:buro_employee/repository/network/buro_repository.dart';
import 'package:buro_employee/sessionmanager/session_manager.dart';
import 'package:buro_employee/theme/colors.dart';
import 'package:buro_employee/utilities/analytics.dart';
import 'package:buro_employee/utilities/common_methods.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../app.dart';
import 'package:buro_employee/repository/bloc/login/verify_otp_cubit.dart';
//This class has been used for Login verification with OTP through Mobile or Email

class LoginVerification extends StatefulWidget {
  static const routeName = '/loginVerification';
  late final LoginUser arguments;

  LoginVerification(this.arguments, {Key? key}) : super(key: key);

  @override
  _LoginVerificationState createState() => _LoginVerificationState();
}

class _LoginVerificationState extends State<LoginVerification> {
  String otpCode = "";
  var selectedLang;
  late VerifyOtpCubit bloc;
  var repository = BuroRepository();

  @override
  void initState() {
    // TODO: implement initState

    bloc = context.read<VerifyOtpCubit>();

    CommonMethods.getSelectedLang().then((value) => {
          selectedLang = value,
          print('Selecetdlang in Login Verification $selectedLang value $value')
        });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var user = widget.arguments;
    var mobile = widget.arguments.data.mobile;
    var width = MediaQuery.of(context).size.width / 2;
    return Scaffold(body: Builder(
      builder: (BuildContext context) {
        return Column(
          children: [
            Flexible(
              flex: 2,
              child: CommonMethods.topBanner(width),
            ),
            Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.only(left: 25, right: 25),
                  child: ListView(
                    children: [
                      SizedBox(
                        height: 35,
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Text(
                            Languages.of(context)!.verificationCode,
                            style: TextStyle(fontSize: 28, color: Colors.black),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Text(
                            '${Languages.of(context)!.otpTextMobile} $mobile',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 14,
                                color: ColorResources.GREY_DARK_SIXTY),
                          )),
                      SizedBox(
                        height: 25,
                      ),
                      otpField(),
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Text(
                            Languages.of(context)!.recoverCodeMessage,
                            style: TextStyle(
                                color: ColorResources.GREY_DARK_SIXTY),
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Text(
                            Languages.of(context)!.tryDifferentMobileNumber,
                            style: TextStyle(
                                color: ColorResources.APP_THEME_COLOR),
                          )),
                      SizedBox(
                        height: 25,
                      ),
                      ElevatedButton(
                          //style: ButtonStyle(),
                          style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                            primary: ColorResources.APP_THEME_COLOR,
                            minimumSize: const Size.fromHeight(50), // NEW
                          ),
                          onPressed: () async {
                            if (otpCode.length == 4) {
                              try {
                                showLoaderDialog(context);
                                final result =
                                    await InternetAddress.lookup('google.com');
                                if (result.isNotEmpty &&
                                    result[0].rawAddress.isNotEmpty) {
                                  var response = await user.data.otpToMobile
                                      ? bloc.verifyOtp(
                                          mobileOtp: otpCode, emailOtp: '')
                                      : bloc.verifyOtp(
                                          mobileOtp: '', emailOtp: otpCode);

                                  response.then((value) => {
                                        print('Value in response $value'),

                                        if (value!.success)
                                          {
                                            print("Success Condition"),
                                            sessionManager.setIsLoggedIn(true),
                                            repository
                                                .getBranchList()
                                                .whenComplete(() => {
                                                Navigator.pop(context),
                                               Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LandingScreen(
                                                          title:
                                                              'BURO Employee',
                                                        ))),
                                            })


                                          }
                                        else
                                          {
                                            if (selectedLang == 'en')
                                              {
                                                CommonMethods.showMessage(
                                                    context,
                                                    '${value.messageEn}',
                                                    Colors.red),
                                              }
                                            else
                                              {
                                                CommonMethods.showMessage(
                                                    context,
                                                    '${value.messageBn}',
                                                    Colors.red),
                                              }
                                          }
                                      });
                                }
                              } on SocketException catch (_) {
                                Navigator.pop(context);
                                CommonMethods.showMessage(
                                    context,
                                    Languages.of(context)!.internetErrorText,
                                    Colors.red);
                              }
                            } else {
                              CommonMethods.showMessage(
                                  context,
                                  '${Languages.of(context)!.otpValidation}',
                                  Colors.red);
                            }

                          },
                          child: Text(
                            Languages.of(context)!.submitButton,
                            style: TextStyle(color: ColorResources.WHITE),
                          ))
                    ],
                  ),
                ))
          ],
        );
      },
    ));
  }

  static showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Connecting...")),
        ],
      ),
    );

    showDialog(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Widget otpField() {
    return OTPTextField(
      length: 4,
      width: MediaQuery.of(context).size.width,
      fieldWidth: 58,
      otpFieldStyle: OtpFieldStyle(
          backgroundColor: ColorResources.OTP_FIELD_COLOR,
          borderColor: Colors.white,
          focusBorderColor: Colors.orangeAccent),
      style: TextStyle(fontSize: 17, color: Colors.black),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.box,
      onCompleted: (pin) {
        print("Completed: " + pin);
        setState(() {
          otpCode = pin;
        });
      },
      onChanged: (pin) {
        setState(() {
          otpCode = pin;
        });
      },
    );
  }
}


