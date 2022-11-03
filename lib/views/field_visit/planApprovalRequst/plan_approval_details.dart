import 'dart:io';

import 'package:buro_employee/localization/Language/languages.dart';
import 'package:buro_employee/repository/bloc/plan_approval_details_cubit/plan_approval_details_cubit.dart';
import 'package:buro_employee/repository/models/ApprovalRequestInfo.dart';
import 'package:buro_employee/theme/colors.dart';
import 'package:buro_employee/theme/styles.dart';
import 'package:buro_employee/utilities/common_methods.dart';
import 'package:buro_employee/utilities/constants.dart';
import 'package:buro_employee/views/field_visit/planApprovalRequst/plan_approval_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../app.dart';

class PlanApprovalDetails extends StatefulWidget {
  late final ApprovalRequestInfo arguments;
  static const routeName = '/planApprovalDetail';

  PlanApprovalDetails(this.arguments, {Key? key}) : super(key: key);

  @override
  _PlanApprovalDetailsState createState() => _PlanApprovalDetailsState();
}

class _PlanApprovalDetailsState extends State<PlanApprovalDetails> {
  var selectedLang;
  var item;
  late PlanApprovalDetailsCubit bloc;

  @override
  void dispose() {

    super.dispose();
  }

  @override
  void initState() {
    // super.initState();
    CommonMethods.getSelectedLang().then((value) => {
          selectedLang = value,
        });

    bloc = context.read<PlanApprovalDetailsCubit>();
    item = widget.arguments;
    bloc.getPlanApprovalDetails(item.applicationId);
  }

  @override
  void didChangeDependencies() {
    //dependOnInheritedWidgetOfExactType()
    super.didChangeDependencies();
    //analytics.setCurrentScreen('Approval Details', 'Stateful widget');
  }

  Future<bool> _willPopCallback() async {
    Navigator.pushNamed(context, PlanApprovalList.routeName);
    return true;
  }



  Future refresh() {
    return Future.delayed(
      Duration(seconds: 1),
      () {
        bloc.getPlanApprovalDetails(item.applicationId);
      },
    );
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
                Languages.of(context)!.planDetails,
                style: Styles.appBarTextStyle,
              ),
            ),
          ),
          body: BlocConsumer<PlanApprovalDetailsCubit,
                  PlanApprovalDetailsState>(
              listener: (context, state) {
                if (state is PlanApprovalDetailsErrorState) {
                  CommonMethods.showMessage(
                      context, 'Network Error', Colors.red);
                }
              },
              buildWhen: (previous, current) => previous != current,
              builder: (context, state) {
                print('Plan Approval state ${state}');

                if (state is PlanApprovalDetailsInitialState) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is PlanApprovalDetailsLoadingState) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is PlanApprovalDetailsLoadedState) {
                  var list = state.planApprovalDetailsModel.data;

                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: ColorResources.RECEIPIENT_BACKGROUD,
                            border: Border.all(
                                color: ColorResources.APP_THEME_COLOR,
                                width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(
                              10,
                            )),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 16, right: 16, top: 16),
                                child: Text(
                                  '${widget.arguments.pin}: ${widget.arguments.name}',
                                  style: Styles.listHeaderTextStyle,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 16, bottom: 16),
                                child: Text(
                                  '${widget.arguments.designation}',
                                  style: Styles.listHeaderTextStyle,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: RefreshIndicator(
                          onRefresh: refresh,
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: list.length,
                                itemBuilder: (context, index) {
                                  var item = list[index];
                                  String formattedStartDate =
                                      DateTime.parse(item.tourDate)
                                          .format(DateTimeFormats.american);

                                  return Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25, right: 25, bottom: 16),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: ColorResources.WHITE,
                                        border: Border.all(
                                            color: ColorResources
                                                .LIST_BORDER_WHITE,
                                            width: 1),
                                        borderRadius:
                                            BorderRadius.all(Radius.circular(
                                          10,
                                        )),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 16, right: 16, top: 16),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text('${formattedStartDate}',
                                                      style: Styles
                                                          .listHeaderTextStyle),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text('Status: ',
                                                          style: GoogleFonts.inter(
                                                              fontSize: 12,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                              color: ColorResources
                                                                  .GREY_SIXTY)),
                                                      CommonMethods.getStatus(
                                                          item.activityName),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: 20,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 16,
                                                right: 16,
                                                bottom: 16),
                                            child: Divider(
                                              height: 1,
                                              thickness: 1,
                                              color: ColorResources.GREY_THIRTY,
                                            ),
                                          ),
                                          Align(
                                              alignment:
                                                  FractionalOffset.bottomCenter,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 16,
                                                              right: 10,
                                                              bottom: 17),
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                                primary:
                                                                    ColorResources
                                                                        .ACCEPT_COLOR_BACKGROUND,
                                                                elevation: 0),
                                                        child: Container(
                                                          child: Center(
                                                            child: Text(
                                                              '${Languages.of(context)!.approve}',
                                                              style: Styles
                                                                  .acceptButtonTextStyle,
                                                            ),
                                                          ),
                                                          height: 40,
                                                        ),
                                                        onPressed: () async{
                                                          CommonMethods
                                                              .showLoaderDialog(
                                                                  context);
                                                          try {
                                                            final result = await InternetAddress.lookup(
                                                                'google.com');
                                                            if (result.isNotEmpty &&
                                                                result[0].rawAddress.isNotEmpty) {
                                                              bloc.planApproveAction(
                                                                  item
                                                                      .planDetailsID,
                                                                  item.planID,
                                                                  constants
                                                                      .KEY_APPROVAL_APPROVE)
                                                                  .then((value) => {
                                                                Navigator.pop(
                                                                    context),


                                                                if(selectedLang.toString().isEmpty){
                                                                  CommonMethods.showMessage(
                                                                      Scaffold.of(context)
                                                                          .context,
                                                                      value!
                                                                          .messageEn,
                                                                      Colors
                                                                          .green),
                                                                  initState()

                                                                } else {

                                                                  CommonMethods.showMessage(
                                                                      Scaffold.of(context)
                                                                          .context,
                                                                      selectedLang ==
                                                                          'en'
                                                                          ? value!
                                                                          .messageEn
                                                                          : value!
                                                                          .messageBn,
                                                                      Colors
                                                                          .green),
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
                                                                Languages.of(context)!.internetErrorText,
                                                                Colors.red);
                                                          }


                                                          /*bloc.planApproveAction(
                                                                  item
                                                                      .planDetailsID,
                                                                  item.planID,
                                                                  constants
                                                                      .KEY_APPROVAL_APPROVE)
                                                              .then((value) => {
                                                                    Navigator.pop(
                                                                        context),
                                                                    CommonMethods.showMessage(
                                                                        Scaffold.of(context)
                                                                            .context,
                                                                        selectedLang ==
                                                                                'en'
                                                                            ? value!
                                                                                .messageEn
                                                                            : value!
                                                                                .messageBn,
                                                                        Colors
                                                                            .green),
                                                                    initState()
                                                                  });*/
                                                        },
                                                      ),
                                                    ),
                                                    flex: 1,
                                                  ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 16,
                                                              bottom: 17),
                                                      child: ElevatedButton(
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          primary: ColorResources
                                                              .REJECT_COLOR_BACKGROUND,
                                                          elevation: 0,
                                                        ),
                                                        child: Container(
                                                          child: Center(
                                                            child: Text(
                                                              '${Languages.of(context)!.reject}',
                                                              style: Styles
                                                                  .rejectButtonTextStyle,
                                                            ),
                                                          ),
                                                          height: 40,
                                                        ),
                                                        onPressed: () async {
                                                          CommonMethods
                                                              .showLoaderDialog(
                                                                  context);

                                                          try {
                                                            final result = await InternetAddress.lookup(
                                                                'google.com');
                                                            if (result.isNotEmpty &&
                                                                result[0].rawAddress.isNotEmpty) {

                                                              bloc
                                                                  .planApproveAction(
                                                                  item
                                                                      .planDetailsID,
                                                                  item.planID,
                                                                  constants
                                                                      .KEY_APPROVAL_REJECT)
                                                                  .then((value) => {
                                                                Navigator.pop(
                                                                    context),

                                                                if(selectedLang.toString().isEmpty){
                                                                  CommonMethods.showMessage(
                                                                      context,
                                                                      selectedLang ==
                                                                          'en'
                                                                          ? value!
                                                                          .messageEn
                                                                          : value!
                                                                          .messageBn,
                                                                      Colors
                                                                          .red),
                                                                  initState()
                                                                } else {

                                                                CommonMethods.showMessage(
                                                                    context,
                                                                    selectedLang ==
                                                                        'en'
                                                                        ? value!
                                                                        .messageEn
                                                                        : value!
                                                                        .messageBn,
                                                                    Colors
                                                                        .red),
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
                                                                Languages.of(context)!.internetErrorText,
                                                                Colors.red);
                                                          }



                                                          /*bloc
                                                              .planApproveAction(
                                                                  item
                                                                      .planDetailsID,
                                                                  item.planID,
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
                                                                        Colors
                                                                            .red),
                                                                    initState()
                                                                  });*/
                                                        },
                                                      ),
                                                    ),
                                                    flex: 1,
                                                  ),
                                                ],
                                              ))
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (state is PlanApprovalDetailsErrorState) {
                  // (state is WeatherError)
                  return Container(
                    child: Text('In Error State'),
                  );
                } else {
                  return Container(
                    child: Text('Common Error State'),
                  );
                }
              }),
        ));
  }
}

MyGlobals myGlobals = MyGlobals();

class MyGlobals {
  late GlobalKey _scaffoldKey;

  MyGlobals() {
    _scaffoldKey = GlobalKey();
  }

  GlobalKey get scaffoldKey => _scaffoldKey;
}
