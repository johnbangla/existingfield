import 'dart:io';

import 'package:buro_employee/app.dart';
import 'package:buro_employee/localization/Language/languages.dart';
import 'package:buro_employee/repository/bloc/change_password/change_pass_cubit.dart';
import 'package:buro_employee/sessionmanager/session_manager.dart';
import 'package:buro_employee/theme/colors.dart';
import 'package:buro_employee/theme/styles.dart';
import 'package:buro_employee/utilities/common_methods.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> with inputValidation {
  bool _isObscureOld = true;
  bool _isObscureNew = true;
  bool _isObscureConfirm = true;
  final formGlobalKey = GlobalKey<FormState>();
  final oldPassController = TextEditingController();
  final newPassController = TextEditingController();
  final confirmPassController = TextEditingController();
  var oldPassFocusNode = FocusNode();
  var newPassFocusNode = FocusNode();
  var confirmPassFocusNode = FocusNode();
  late ChangePasswordCubit bloc;
  var selectedLang;

  @override
  void dispose() {
    oldPassFocusNode.dispose();
    newPassFocusNode.dispose();
    confirmPassFocusNode.dispose();
    clear();

    super.dispose();
  }

  @override
  initState() {
    super.initState();
    bloc = context.read<ChangePasswordCubit>();

    CommonMethods.getSelectedLang().then((value) => {
          selectedLang = value,
          print('Selecetdlang change password $selectedLang value $value')
        });

    //bloc.initState();
    print('Change password initState called');
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width / 2 - 10;
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16, top: 130),
      child: Container(
          child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(Languages.of(context)!.oldPassText,
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        color: ColorResources.GREY_NINETY))),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
            child: Container(
                child: TextFormField(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: ColorResources.TEXT_FIELD_COLOR,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color: ColorResources.APP_THEME_COLOR,
                          style: BorderStyle.solid,
                          width: 2)),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: ColorResources.TEXT_FIELD_BORDER_COLOR,
                        width: 0.0),
                  ),
                  hintText: Languages.of(context)!.oldPassText,
                  contentPadding: EdgeInsets.all(20),
                  hintStyle: TextStyle(color: ColorResources.GREY_SEVENTY),
                  suffixIcon: IconButton(
                      icon: Icon(_isObscureOld
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isObscureOld = !_isObscureOld;
                        });
                      })),
              keyboardType: TextInputType.visiblePassword,
              obscureText: _isObscureOld,
              cursorColor: Color.fromRGBO(0, 0, 0, 0.1),
              style: TextStyle(color: Colors.black),
              maxLines: 1,
              controller: oldPassController,
              focusNode: oldPassFocusNode,
            )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(Languages.of(context)!.newPassText,
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        color: ColorResources.GREY_NINETY))),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
            child: Container(
                child: TextFormField(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: ColorResources.TEXT_FIELD_COLOR,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color: ColorResources.APP_THEME_COLOR,
                          style: BorderStyle.solid,
                          width: 2)),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: ColorResources.TEXT_FIELD_BORDER_COLOR,
                        width: 0.0),
                  ),
                  hintText: Languages.of(context)!.password,
                  contentPadding: EdgeInsets.all(20),
                  hintStyle: TextStyle(color: ColorResources.GREY_SEVENTY),
                  suffixIcon: IconButton(
                      icon: Icon(_isObscureNew
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isObscureNew = !_isObscureNew;
                        });
                      })),
              keyboardType: TextInputType.visiblePassword,
              obscureText: _isObscureNew,
              cursorColor: Color.fromRGBO(0, 0, 0, 0.1),
              style: TextStyle(color: Colors.black),
              maxLines: 1,
              controller: newPassController,
              focusNode: newPassFocusNode,
            )),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(Languages.of(context)!.confirmPassText,
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        fontStyle: FontStyle.normal,
                        color: ColorResources.GREY_NINETY))),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
            child: Container(
                child: TextFormField(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: ColorResources.TEXT_FIELD_COLOR,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color: ColorResources.APP_THEME_COLOR,
                          style: BorderStyle.solid,
                          width: 2)),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: const BorderSide(
                        color: ColorResources.TEXT_FIELD_BORDER_COLOR,
                        width: 0.0),
                  ),
                  hintText: Languages.of(context)!.confirmPassText,
                  contentPadding: EdgeInsets.all(20),
                  hintStyle: TextStyle(color: ColorResources.GREY_SEVENTY),
                  suffixIcon: IconButton(
                      icon: Icon(_isObscureConfirm
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isObscureConfirm = !_isObscureConfirm;
                        });
                      })),
              keyboardType: TextInputType.visiblePassword,
              obscureText: _isObscureConfirm,
              cursorColor: Color.fromRGBO(0, 0, 0, 0.1),
              style: TextStyle(color: Colors.black),
              maxLines: 1,
              controller: confirmPassController,
              focusNode: confirmPassFocusNode,
            )),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 40, bottom: 10),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () async {
                  if (oldPassController.text.isEmpty) {
                    oldPassFocusNode.requestFocus();
                    CommonMethods.showMessage(
                        context,
                        Languages.of(context)!.oldPassEmptyValidation,
                        Colors.red);
                  } else if (oldPassController.text.length < 5) {
                    CommonMethods.showMessage(context,
                        Languages.of(context)!.fiveDigitValidation, Colors.red);
                  } else if (newPassController.text.isEmpty) {
                    newPassFocusNode.requestFocus();
                    CommonMethods.showMessage(
                        context,
                        Languages.of(context)!.newPassEmptyValidation,
                        Colors.red);
                  } else if (newPassController.text.length < 5) {
                    CommonMethods.showMessage(context,
                        Languages.of(context)!.fiveDigitValidation, Colors.red);
                  } else if (confirmPassController.text.isEmpty) {
                    confirmPassFocusNode.requestFocus();
                    CommonMethods.showMessage(
                        context,
                        Languages.of(context)!.confirmPassEmptyValidation,
                        Colors.red);
                  } else if (confirmPassController.text.length < 5) {
                    confirmPassFocusNode.requestFocus();
                    CommonMethods.showMessage(context,
                        Languages.of(context)!.fiveDigitValidation, Colors.red);
                  } else {
                    if (newPassController.text != confirmPassController.text) {
                      CommonMethods.showMessage(
                          context,
                          Languages.of(context)!.passwordMatchValidation,
                          Colors.red);
                    } else {
                      CommonMethods.showLoaderDialog(context);



                      try {
                        final result = await InternetAddress.lookup(
                            'google.com');
                        if (result.isNotEmpty &&
                            result[0].rawAddress.isNotEmpty) {

                          bloc.submitChangePass(
                              false,
                              oldPassController.text,
                              newPassController.text,
                              confirmPassController.text)
                              .then((value) => {
                            if (value!.success)
                              {
                                if(selectedLang.toString().isEmpty){

                                  print('Empty Condition'),
                                  Navigator.pop(context),
                                  CommonMethods.showMessage(
                                      context,
                                      value.messageEn
                                      ,
                                      Colors.green),
                                  sessionManager.setPassword(
                                      confirmPassController.text),
                                  //clear(),
                                  Navigator.pushNamed(
                                      context, LandingScreen.routeName)

                                }else {
                                  Navigator.pop(context),
                                  CommonMethods.showMessage(
                                      context,
                                      selectedLang == 'en'
                                          ? value.messageEn
                                          : value.messageBn,
                                      Colors.green),
                                  sessionManager.setPassword(
                                      confirmPassController.text),
                                  //clear(),
                                  Navigator.pushNamed(
                                      context, LandingScreen.routeName)

                                }


                                //initState()
                              }
                            else
                              {
                                if(selectedLang.toString().isEmpty){
                                  Navigator.pop(context),
                                  CommonMethods.showMessage(
                                      context,
                                       value.messageEn
                                          ,
                                      Colors.red),
                                } else {
                                  Navigator.pop(context),
                                  CommonMethods.showMessage(
                                      context,
                                      selectedLang == 'en'
                                          ? value.messageEn
                                          : value.messageBn,
                                      Colors.red),
                                }

                              }
                          });

                          //print('connected');
                        }
                      } on SocketException catch (_) {
                        print('not connected');
                        Navigator.pop(context);
                        CommonMethods.showMessage(
                            context,
                            Languages.of(context)!.internetErrorText,
                            Colors.red);
                      }







                    }
                  }
                },
                child: Text(
                  '${Languages.of(context)!.submitButton}',
                  style: Styles.buttonTextStyle,
                ),
                style: ElevatedButton.styleFrom(
                  elevation: 0.0,
                  primary: ColorResources.APP_THEME_COLOR,
                  minimumSize: const Size.fromHeight(50), // NEW
                ),
              ),
            ),
          )
        ],
      )),
    );
  }

  void clear() {
    oldPassController.text = '';
    newPassController.text = '';
    confirmPassController.text = '';
  }
}

mixin inputValidation {
  bool isPasswordValid(String password) => password.length > 5;
}
