import 'dart:io';

import 'package:buro_employee/localization/Language/languages.dart';
import 'package:buro_employee/repository/bloc/login/generate_otp_cubit.dart';
import 'package:buro_employee/theme/colors.dart';
import 'package:buro_employee/theme/styles.dart';
import 'package:buro_employee/utilities/common_methods.dart';
import 'package:buro_employee/views/login/forgotpass_verification.dart';
import 'package:buro_employee/views/login/reset_password.dart';
import 'package:buro_employee/widgets/white_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:buro_employee/sessionmanager/session_manager.dart';

class ForgetPassword extends StatefulWidget {
  static const routeName = '/forgetPasswordNew';

  static routensj() => MaterialPageRoute(builder: (_) => ForgetPassword());

  ForgetPassword({Key? key}) : super(key: key);

  /*static route() => MaterialPageRoute(builder: (_) => ForgetPassword());
*/

  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  late GenerateOtpCubit getOtpBloc;
  TextEditingController userIdController = TextEditingController();

  @override
  initState() {




  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width / 2;
    getOtpBloc = context.read<GenerateOtpCubit>();

    return Scaffold(
        body: Builder(builder: (BuildContext context) {
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
                child: Column(
                  children: [
                    SizedBox(
                      height: 35,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          Languages.of(context)!.forgotPassword,
                          style: TextStyle(fontSize: 28, color: Colors.black),
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          Languages.of(context)!.forgotPassHeading,
                          style: TextStyle(
                              fontSize: 14,
                              color: ColorResources.GREY_DARK_SIXTY),
                        )),
                    SizedBox(
                      height: 25,
                    ),
                    WhiteTextField(
                      isNumeric: false,
                      hint: Languages.of(context)!.userHint,
                      controller: userIdController,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                        //style: ButtonStyle(),
                        style: ElevatedButton.styleFrom(
                          primary: ColorResources.APP_THEME_COLOR,
                          minimumSize: const Size.fromHeight(50), // NEW
                        ),
                        onPressed: () async {
                          if (userIdController.text.isNotEmpty) {
                            CommonMethods.showLoaderDialog(context);
                            try {
                              final result =
                                  await InternetAddress.lookup('google.com');
                              if (result.isNotEmpty &&
                                  result[0].rawAddress.isNotEmpty) {
                                getOtpBloc
                                    .getOtp(userIdController.text)
                                    .then((value) => {
                                          print('In  Condition $value'),
                                          if (value.success)
                                            {
                                              print('In Frrst Condition'),
                                              Navigator.pop(context),
                                              sessionManager.setUserID(
                                                  userIdController.text),
                                              Navigator.pushNamed(
                                                  context,
                                                  ForgotPassVerification
                                                      .routeName,
                                                  arguments: value),
                                            }
                                          else
                                            {
                                              print('In Else Condition'),
                                              Navigator.pop(context),
                                              CommonMethods.showMessage(context,
                                                  value.messageEn, Colors.red)
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
                                Languages.of(context)!.userIdEmptyValidation,
                                Colors.red);
                          }

                          /* try {
                            if (userIdController.text.isNotEmpty) {
                              CommonMethods.showLoaderDialog(context);
                              getOtpBloc
                                  .getOtp(userIdController.text)
                                  .then((value) => {
                                        print('In  Condition $value'),
                                        if (value.success)
                                          {
                                            print('In Frrst Condition'),
                                            Navigator.pop(context),
                                            sessionManager.setUserID(
                                                userIdController.text),
                                            Navigator.pushNamed(
                                                context,
                                                ForgotPassVerification
                                                    .routeName,
                                                arguments: value),
                                          }
                                        else
                                          {
                                            print('In Else Condition'),
                                            Navigator.pop(context),
                                            CommonMethods.showMessage(context,
                                                value.messageEn, Colors.red)
                                          }
                                      });
                            } else {
                              CommonMethods.showMessage(
                                  context,
                                  Languages.of(context)!.userIdEmptyValidation,
                                  Colors.red);
                            }
                          } catch (e) {
                            print('In CAtch exception');
                            CommonMethods.showMessage(
                                context, 'User ID not valid', Colors.red);
                          }*/
                        },
                        child: Container(
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
        ],
      );
    }));
  }
}
