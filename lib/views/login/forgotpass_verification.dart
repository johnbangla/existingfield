import 'dart:io';

import 'package:buro_employee/localization/Language/languages.dart';
import 'package:buro_employee/repository/bloc/forgot_pass_verification/forgot_pass_verification_cubit.dart';
import 'package:buro_employee/repository/models/generate_otp.dart';
import 'package:buro_employee/sessionmanager/session_manager.dart';
import 'package:buro_employee/theme/colors.dart';
import 'package:buro_employee/theme/styles.dart';
import 'package:buro_employee/utilities/common_methods.dart';
import 'package:buro_employee/views/login/reset_password.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//This class has been used for forgot password
// user verification with mobile or email Otp


class ForgotPassVerification extends StatefulWidget {

  static const routeName = '/forgotPassVerification';

  late final GenerateOTP arguments;

  ForgotPassVerification(this.arguments, {Key? key}) : super(key: key);


  @override
  _ForgotPassVerificationState createState() => _ForgotPassVerificationState();
}

class _ForgotPassVerificationState extends State<ForgotPassVerification> {

  String buttonName = "Send";
  TextEditingController phoneController = TextEditingController();
  String otpCode = "";
  var selectedLang;


  @override
  Widget build(BuildContext context) {

    final bloc = context.read<ForgotPassVerificationCubit>();

    var user = widget.arguments;
    var info;
    if(widget.arguments.data!.otpToMobile){
      info= widget.arguments.data!.mobile;
    } else {
      info= widget.arguments.data!.email;
    }


    var width = MediaQuery.of(context).size.width/2;
    print('Width $width  ${MediaQuery.of(context).size.width}');
    return Scaffold(

        body: Builder(builder: (BuildContext context) {
          return Column(children: [
            Flexible(
              flex: 2,
              child: CommonMethods.topBanner(width),),
            Expanded(
                flex: 4,
                child: Padding(padding: EdgeInsets.only(left: 25,right: 25),
                  child: ListView(
                    children: [

                      SizedBox(
                        height: 35,
                      ),
                      Align(
                          alignment: Alignment.center,
                          child: Text(Languages.of(context)!.verificationCode,style: TextStyle(fontSize: 28,color: Colors.black),)),
                      SizedBox(height: 10,),
                      Align(
                          alignment: Alignment.center,
                          child: Text('${Languages.of(context)!.otpTextMobile} $info',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14,color: ColorResources.GREY_DARK_SIXTY),)),

                      SizedBox(height: 25,),
                      otpField(),
                      SizedBox(height: 20,),

                      Align(
                          alignment: Alignment.center,
                          child: Text(Languages.of(context)!.recoverCodeMessage,style: TextStyle(color: ColorResources.GREY_DARK_SIXTY),)),

                      SizedBox(height: 30,),

                      SizedBox(height: 16,),
                      Align(
                          alignment: Alignment.center,
                          child: Text('OTP validation ${user.data!.otpValidity}',style: TextStyle(color: ColorResources.APP_THEME_COLOR),)),

                      SizedBox(height: 25,),

                      ElevatedButton(
                        //style: ButtonStyle(),
                          style: ElevatedButton.styleFrom(
                            elevation: 0.0,
                            primary: ColorResources.APP_THEME_COLOR,
                            minimumSize: const Size.fromHeight(50), // NEW
                          ),
                          onPressed: () async{
                            if (otpCode.length == 4) {
                              CommonMethods.showLoaderDialog(context);
                              selectedLang = await sessionManager.selectedLang;
                              try {
                                final result =
                                await InternetAddress.lookup('google.com');
                                if (result.isNotEmpty &&
                                    result[0].rawAddress.isNotEmpty) {

                                  var response = await user.data!.otpToMobile
                                      ? bloc.verifyOtpResetPass(
                                      mobileOtp: otpCode, emailOtp: '')
                                      : bloc.verifyOtpResetPass(
                                      mobileOtp: '', emailOtp: otpCode);
                                  response.then((value) => {
                                    print('Value ${value}'),
                                    if (value!.success)
                                      {
                                        Navigator.pop(context),

                                        Navigator.pushNamed(context, ResetPassword.routeName,arguments: otpCode)

                                      } else {
                                        if (selectedLang == 'en')
                                          {
                                            showMessage(context,
                                                '${value.messageEn}', Colors.red),
                                          }
                                        else
                                          {
                                            showMessage(context,
                                                '${value.messageBn}', Colors.red),
                                          }
                                      }
                                  }).onError((error, stackTrace) => {
                                    Navigator.pop(context),
                                   // print('On Error  ${error.toString()}')
                                    if (selectedLang == 'en')
                                      {
                                        showMessage(context,
                                            Languages.of(context)!.wrongOtpValidationText, Colors.red),
                                      }
                                    else
                                      {
                                        showMessage(context,
                                            Languages.of(context)!.wrongOtpValidationText, Colors.red),
                                      }


                                  });
                                }
                              } on SocketException catch (_) {
                                Navigator.pop(context);
                                showMessage(
                                    context,
                                    Languages.of(context)!.internetErrorText,
                                    Colors.red);
                              }
                            } else {

                              showMessage(
                                  context,
                                  '${Languages.of(context)!.otpValidation}',
                                  Colors.red);
                            }



                          }, child: Container(
                        height: 56,
                        child: Center(
                          child: Text(
                            Languages.of(context)!.submitButton,
                            style: Styles.buttonTextStyle,
                          ),
                        ),
                      ))

                    ],
                  ),

                ))




          ] );

        }));
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

void showMessage(BuildContext context, String message, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      message,
    ),
    backgroundColor: color,
  ));
}



/*
class ForgotPassVerification extends StatefulWidget {
  static const routeName = '/forgotPassVerification';

  late final GenerateOTP arguments;

  ForgotPassVerification(this.arguments, {Key? key}) : super(key: key);

  //static route() => MaterialPageRoute(builder: (_) => ForgotPassVerification());

  @override
  _ForgotPassVerificationState createState() => _ForgotPassVerificationState();
}

class _ForgotPassVerificationState extends State<ForgotPassVerification> {
  String buttonName = "Send";
  TextEditingController phoneController = TextEditingController();
  String otpCode = "";
  var selectedLang;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ForgotPassVerificationCubit>();

    var user = widget.arguments;

    return Scaffold(body:
        BlocBuilder<ForgotPassVerificationCubit, ForgotPassVerificationState>(
      builder: (context, state) {
        print("State Forget Pass verification State ${state}");


        return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 120,
                ),
                Text(user.data!.otpToMobile == true
                    ? '${Languages.of(context)!.otpTextMobile}'
                    : '${Languages.of(context)!.otpTextEmail}'),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    initialValue: user.data!.otpToMobile == true
                        ? '${user.data!.mobile}'
                        : '${user.data!.email}',
                    enabled: false,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Align(
                  child: Text(
                    "${Languages.of(context)!.digitInfo}",
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  alignment: Alignment.center,
                ),
                SizedBox(
                  height: 50,
                ),
                otpField(),
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 150,
                ),
                InkWell(
                  onTap: () async {

                    if (otpCode.length == 4) {
                      selectedLang = await sessionManager.selectedLang;
                      try {
                        final result =
                            await InternetAddress.lookup('google.com');
                        if (result.isNotEmpty &&
                            result[0].rawAddress.isNotEmpty) {
                          var response = await user.data!.otpToMobile
                              ? bloc.verifyOtpResetPass(
                                  mobileOtp: otpCode, emailOtp: '')
                              : bloc.verifyOtpResetPass(
                                  mobileOtp: '', emailOtp: otpCode);

                          if (state is ForgotPassVerificationLoadedState) {
                            print(
                                'Value At state ${state.data.success}  ${response.toString()}');
                          }
                          response.then((value) => {
                            print('Value ${value}'),
                            if (value!.success)
                              {
                                print("Success Condition"),
                               Navigator.pushNamed(context, ResetPassword.routeName,arguments: otpCode)

                              }
                            else
                              {
                                if (selectedLang == 'en')
                                  {
                                    showMessage(context,
                                        '${value.messageEn}', Colors.red),
                                  }
                                else
                                  {
                                    showMessage(context,
                                        '${value.messageBn}', Colors.red),
                                  }
                              }
                          });
                        }
                      } on SocketException catch (_) {
                        showMessage(
                            context,
                            Languages.of(context)!.internetErrorText,
                            Colors.red);
                      }
                    } else {
                      showMessage(
                          context,
                          '${Languages.of(context)!.otpValidation}',
                          Colors.red);
                    }
                  },
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width - 60,
                    decoration: BoxDecoration(
                        color: Color(0xffff9601),
                        borderRadius: BorderRadius.circular(20)),
                    child: Center(
                      child: Text(
                        "${Languages.of(context)!.submitButton}",
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    ));
    */
/*return Scaffold(
        body: Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 120,
            ),
             Text(user.data!.otpToMobile == true
                ? '${Languages.of(context)!.otpTextMobile}'
                : '${Languages.of(context)!.otpTextEmail}'),

            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: TextFormField(
                 initialValue: user.data!.otpToMobile == true
                    ? '${user.data!.mobile}'
                    : '${user.data!.email}',

                enabled: false,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Align(
              child: Text(
                "${Languages.of(context)!.digitInfo}",
                style: TextStyle(fontSize: 16, color: Colors.black87),
              ),
              alignment: Alignment.center,
            ),
            SizedBox(
              height: 50,
            ),
            otpField(),
            SizedBox(
              height: 40,
            ),
            SizedBox(
              height: 150,
            ),
            InkWell(
              onTap: () async {
                if (otpCode.length == 4) {
                  selectedLang = await sessionManager.selectedLang;
                  try {
                    final result = await InternetAddress.lookup('google.com');
                    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
                      var response = await user.data.otpToMobile
                          ? bloc.verifyOtpResetPass(mobileOtp: otpCode, emailOtp: '')
                          : bloc.verifyOtpResetPass(mobileOtp: '', emailOtp: otpCode);

                      response.then((value) => {
                            if (value!.success)
                              {
                                print("Success Condition"),
                                sessionManager.setIsLoggedIn(true),
                                Navigator.push(context,
                            ResetPassword);

                }
                            else
                              {
                                if (selectedLang == 'en')
                                  {
                                    showMessage(context, '${value.messageEn}',
                                        Colors.red),
                                  }
                                else
                                  {
                                    showMessage(context, '${value.messageBn}',
                                        Colors.red),
                                  }
                              }
                          });
                    }
                  } on SocketException catch (_) {
                    showMessage(context,
                        Languages.of(context)!.internetErrorText, Colors.red);
                  }
                } else {
                  showMessage(context,
                      '${Languages.of(context)!.otpValidation}', Colors.red);
                }

                   },
              child: Container(
                height: 50,
                width: MediaQuery.of(context).size.width - 60,
                decoration: BoxDecoration(
                    color: Color(0xffff9601),
                    borderRadius: BorderRadius.circular(20)),
                child: Center(
                  child: Text(
                    "${Languages.of(context)!.submitButton}",
                    style: TextStyle(
                        fontSize: 17,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ));*//*

  }

  void showMessage(BuildContext context, String message, Color color) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
      ),
      backgroundColor: color,
    ));
  }

  Widget otpField() {
    return OTPTextField(
      length: 4,
      width: MediaQuery.of(context).size.width,
      fieldWidth: 58,
      otpFieldStyle: OtpFieldStyle(
          backgroundColor: Colors.green,
          borderColor: Colors.white,
          focusBorderColor: Colors.orangeAccent),
      style: TextStyle(fontSize: 17, color: Colors.white),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.underline,


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
*/
