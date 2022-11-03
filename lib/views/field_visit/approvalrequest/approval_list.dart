import 'dart:io';

import 'package:buro_employee/localization/Language/languages.dart';
import 'package:buro_employee/repository/bloc/approval_request/approval_request_cubit.dart';
import 'package:buro_employee/repository/models/ApprovalRequestInfo.dart';
import 'package:buro_employee/theme/colors.dart';
import 'package:buro_employee/theme/styles.dart';
import 'package:buro_employee/utilities/analytics.dart';
import 'package:buro_employee/utilities/common_methods.dart';
import 'package:buro_employee/utilities/constants.dart';
import 'package:buro_employee/views/field_visit/approvalrequest/approval_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../app.dart';
import '../field_visit_main.dart';

class ApprovalList extends StatefulWidget {
  static const routeName = '/approvalList';

  static route() => MaterialPageRoute(builder: (_) => ApprovalList());

  @override
  State<StatefulWidget> createState() => _ApprovalListState();
}

class _ApprovalListState extends State<ApprovalList> {
  var selectedLang;
  var bloc;

  @override
  void initState() {
    CommonMethods.getSelectedLang().then(
        (value) => {selectedLang = value, print('Selecetdlang $selectedLang')});

    bloc = context.read<ApprovalRequestCubit>();
    bloc.getApprovalList();
    //super.initState();
  }

  Future refresh() {
    return Future.delayed(
      Duration(seconds: 1),
      () {
        bloc = context.read<ApprovalRequestCubit>();
        bloc.getApprovalList();
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    analytics.setCurrentScreen('Approval List', 'Stateful widget');
  }

  Future<bool> _willPopCallback() async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => FieldVisitMain()));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: ColorResources.APP_THEME_COLOR,
            title: Center(
              child: Text(
                '${Languages.of(context)!.approvalListTitle}',
                style: Styles.appBarTextStyle,
              ),
            ),
          ),
          body: BlocConsumer<ApprovalRequestCubit, ApprovalRequestState>(
            listener: (context, state) {
              if (state is ApprovalRequestErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(Languages.of(context)!.internetErrorText),
                  ),
                );
              }
            },
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              //print('Home page State ${state}');

              if (state is ApprovalRequestInitialState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is ApprovalRequestLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is ApprovalRequestLoadedState) {
                var approvalList = state.approvalRequest.data;

                return approvalList.isNotEmpty
                    ? RefreshIndicator(
                        onRefresh: refresh,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: approvalList.length,
                            itemBuilder: (context, index) {
                              var item = approvalList[index];
                              String formattedStartDate =
                                  DateFormat.yMMMMd('en_US')
                                      .format(DateTime.parse(item.startDate));
                              String formattedEndDate =
                                  DateFormat.yMMMMd('en_US')
                                      .format(DateTime.parse(item.endDate));
                              return Padding(
                                padding: const EdgeInsets.only(
                                  left: 25,
                                  right: 25,
                                  top: 25,
                                ),
                                child: Container(
                                  //elevation: 20,
                                  /* height: 100,
                                  width: 100,*/
                                  decoration: BoxDecoration(
                                    color: ColorResources.WHITE,
                                    border: Border.all(
                                        color: ColorResources.LIST_BORDER_WHITE,
                                        width: 1),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(
                                      10,
                                    )),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16, right: 16, top: 17),
                                    child: Column(
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              '${item.employeeCode} - ${item.employeeName}',
                                              style: Styles
                                                  .approveListHeaderTextStyle,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              '${item.designationName}',
                                              style:
                                                  Styles.approveListTextStyle,
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.date_range,
                                                  size: 18,
                                                  color: ColorResources
                                                      .GREY_DARK_SIXTY,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  '$formattedStartDate to ${formattedEndDate}',
                                                  style: Styles.mediumTextStyle,
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Row(
                                              //alignment: WrapAlignment.spaceEvenly,
                                              children: [
                                                Icon(
                                                  Icons.place,
                                                  size: 18,
                                                  color: ColorResources
                                                      .GREY_DARK_SIXTY,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Expanded(
                                                  child: Text(
                                                    '${item.places}',
                                                    style:
                                                        Styles.mediumTextStyle,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    maxLines: 1,
                                                    softWrap: false,
                                                  ),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height: 40,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Expanded(
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    elevation: 0,
                                                    primary: ColorResources
                                                        .GREY_THIRTY,
                                                    minimumSize:
                                                        const Size.fromHeight(
                                                            50), // NEW
                                                  ),
                                                  onPressed: () {
                                                    var info =
                                                        ApprovalRequestInfo(
                                                            item.applicationID,
                                                            item.employeeCode,
                                                            item.employeeName,
                                                            item.designationName);

                                                    Navigator.pushNamed(
                                                        context,
                                                        ApprovalDetails
                                                            .routeName,
                                                        arguments: info);
                                                  },
                                                  child: Container(
                                                    height: 36,
                                                    child: Center(
                                                      child: Text(
                                                          Languages.of(context)!
                                                              .viewDetails,
                                                          style: Styles
                                                              .editBillButtonTextStyle),
                                                    ),
                                                  ),
                                                ),
                                                flex: 2,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    elevation: 0,
                                                    primary: ColorResources
                                                        .ACCEPT_COLOR_BACKGROUND,
                                                    minimumSize:
                                                        const Size.fromHeight(
                                                            50), // NEW
                                                  ),
                                                  onPressed: () async {
                                                    showLoaderDialog(context);

                                                    try {
                                                      final result =
                                                          await InternetAddress
                                                              .lookup(
                                                                  'google.com');
                                                      if (result.isNotEmpty &&
                                                          result[0]
                                                              .rawAddress
                                                              .isNotEmpty) {
                                                        bloc
                                                            .approvalActionAll(
                                                                item
                                                                    .applicationID,
                                                                constants
                                                                    .KEY_APPROVAL_APPROVE)
                                                            .then((value) => {
                                                                  if (selectedLang
                                                                      .toString()
                                                                      .isEmpty)
                                                                    {
                                                                      Navigator.pop(
                                                                          context),
                                                                      CommonMethods.showMessage(
                                                                          context,
                                                                          value!
                                                                              .messageEn,
                                                                          Colors
                                                                              .green),
                                                                      initState()
                                                                    }
                                                                  else
                                                                    {
                                                                      Navigator.pop(
                                                                          context),
                                                                      CommonMethods.showMessage(
                                                                          context,
                                                                          selectedLang == 'en'
                                                                              ? value!.messageEn
                                                                              : value!.messageBn,
                                                                          Colors.green),
                                                                      initState()
                                                                    }
                                                                });

                                                        //print('connected');
                                                      }
                                                    } on SocketException catch (_) {
                                                      print('not connected');
                                                      Navigator.pop(context);
                                                      CommonMethods.showMessage(
                                                          context,
                                                          Languages.of(context)!
                                                              .internetErrorText,
                                                          Colors.red);
                                                    }

                                                    /*bloc
                                                        .approvalActionAll(
                                                            item.applicationID,
                                                            constants
                                                                .KEY_APPROVAL_APPROVE)
                                                        .then((value) => {
                                                              CommonMethods.showMessage(
                                                                  context,
                                                                  selectedLang ==
                                                                          'en'
                                                                      ? value!
                                                                          .messageEn
                                                                      : value!
                                                                          .messageBn,
                                                                  Colors.green),
                                                              initState()
                                                            });*/
                                                  },
                                                  // width: double.minPositive,
                                                  //color: Colors.red,
                                                  child: Center(
                                                      child: Icon(
                                                    Icons.done,
                                                    size: 25,
                                                    color: ColorResources
                                                        .ACCEPT_ICON_COLOR,
                                                  )),
                                                ),
                                                flex: 1,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Expanded(
                                                child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    elevation: 0,
                                                    primary: ColorResources
                                                        .REJECT_COLOR_BACKGROUND,
                                                    minimumSize:
                                                        const Size.fromHeight(
                                                            50), // NEW
                                                  ),
                                                  onPressed: () async{

                                                    showLoaderDialog(context);

                                                    try {
                                                      final result =
                                                          await InternetAddress
                                                          .lookup(
                                                          'google.com');
                                                      if (result.isNotEmpty &&
                                                          result[0]
                                                              .rawAddress
                                                              .isNotEmpty) {

                                                        bloc.approvalActionAll(
                                                            item.applicationID,
                                                            constants
                                                                .KEY_APPROVAL_REJECT)
                                                            .then((value) => {
                                                              if(selectedLang.toString().isEmpty){
                                                                Navigator.pop(
                                                                    context),
                                                                CommonMethods.showMessage(
                                                                    context,
                                                                     value!.messageEn,
                                                                    Colors.red),
                                                                initState()
                                                              } else {

                                                                Navigator.pop(
                                                                    context),
                                                                CommonMethods.showMessage(
                                                                    context,
                                                                    selectedLang ==
                                                                        'en'
                                                                        ? value!
                                                                        .messageEn
                                                                        : value!
                                                                        .messageBn,
                                                                    Colors.red),
                                                                initState()
                                                              }


                                                        });


                                                        //print('connected');
                                                      }
                                                    } on SocketException catch (_) {
                                                      print('not connected');
                                                      Navigator.pop(context);
                                                      CommonMethods.showMessage(
                                                          context,
                                                          Languages.of(context)!
                                                              .internetErrorText,
                                                          Colors.red);
                                                    }







                                                   /* bloc
                                                        .approvalActionAll(
                                                            item.applicationID,
                                                            constants
                                                                .KEY_APPROVAL_REJECT)
                                                        .then((value) => {
                                                              Navigator.pop(
                                                                  context),
                                                              CommonMethods.showMessage(
                                                                  context,
                                                                  selectedLang ==
                                                                          'en'
                                                                      ? value!
                                                                          .messageEn
                                                                      : value!
                                                                          .messageBn,
                                                                  Colors.red),
                                                              initState()
                                                            });*/
                                                  },
                                                  //width: double.minPositive,
                                                  //color: Colors.red,
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.clear,
                                                      size: 20,
                                                      color: ColorResources
                                                          .CANCEL_BUTTON_TEXT_COLOR,
                                                    ),
                                                  ),
                                                ),
                                                flex: 1,
                                              ),
                                              SizedBox(
                                                width: 16,
                                              )
                                            ],
                                          ),
                                        ),
                                        SizedBox(
                                          height: 16,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                      )
                    : Center(
                        child: Text(Languages.of(context)!.noDataFound),
                      );
              } else {
                // (state is WeatherError)
                return Center(
                  child: Container(
                    child: Text('Network Error'),
                  ),
                );
              }
            },
          )),
    );
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
}
