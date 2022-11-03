import 'dart:io';

import 'package:buro_employee/localization/Language/languages.dart';
import 'package:buro_employee/repository/bloc/approval_details/approval_details_cubit.dart';
import 'package:buro_employee/repository/models/ApprovalRequestInfo.dart';
import 'package:buro_employee/theme/colors.dart';
import 'package:buro_employee/theme/styles.dart';
import 'package:buro_employee/utilities/analytics.dart';
import 'package:buro_employee/utilities/common_methods.dart';
import 'package:buro_employee/utilities/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:date_time_format/date_time_format.dart';
import 'approval_list.dart';

class ApprovalDetails extends StatefulWidget {
  late final ApprovalRequestInfo arguments;
  static const routeName = '/approvalDetail';

  ApprovalDetails(this.arguments, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ApprovalDetailsState();
}

class _ApprovalDetailsState extends State<ApprovalDetails> {
  var selectedLang;
  var item;
  late ApprovalDetailsCubit bloc;

  @override
  void initState() {
    CommonMethods.getSelectedLang().then((value) => {
          selectedLang = value,
        });

    bloc = context.read<ApprovalDetailsCubit>();
    item = widget.arguments;
    bloc.getApprovalDetails(item.applicationId);
    //super.initState();
  }

  Future<bool> _willPopCallback() async {
    Navigator.pushNamed(context, ApprovalList.routeName);
    return true;
  }

  Future refresh() {
    return Future.delayed(
      Duration(seconds: 1),
      () {
        bloc.getApprovalDetails(item.applicationId);
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    analytics.setCurrentScreen('Approval Details', 'Stateful widget');
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
                '${Languages.of(context)!.approvalListDetail}',
                style: Styles.appBarTextStyle,
              ),
            ),
          ),
          body: BlocConsumer<ApprovalDetailsCubit, ApprovalDetailsState>(
            listener: (context, state) {
              if (state is ApprovalDetailsErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Network Error"),
                  ),
                );
              }
            },
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              if (state is ApprovalDetailsInitialState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is ApprovalDetailsLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is ApprovalDetailsLoadedState) {
                var list = state.approvalRequestDetails.data;
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: ColorResources.RECEIPIENT_BACKGROUD,
                          border: Border.all(
                              color: ColorResources.APP_THEME_COLOR, width: 1),
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
                                var transportBy = '';
                                if (item.transportBy != null) {
                                  transportBy = item.transportBy!;
                                }
                                String formattedStartDate =
                                    DateTime.parse(item.startDate)
                                        .format(DateTimeFormats.american);

                                String formattedEndDate =
                                    DateTime.parse(item.endDate)
                                        .format(DateTimeFormats.american);

                                return Padding(
                                  padding: const EdgeInsets.only(
                                    left: 25,
                                    right: 25,
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: ColorResources.WHITE,
                                      border: Border.all(
                                          color:
                                              ColorResources.LIST_BORDER_WHITE,
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
                                                Text(
                                                    '${formattedStartDate} to ${formattedEndDate}',
                                                    style: Styles
                                                        .listHeaderTextStyle),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                    style: DefaultTextStyle.of(
                                                            context)
                                                        .style,
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: 'From : ',
                                                          style: Styles
                                                              .listDescHeadingTextStyle),
                                                      TextSpan(
                                                          text:
                                                              '${item.fromPlace}',
                                                          style: Styles
                                                              .listDescWithHeadTextStyle),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                    style: DefaultTextStyle.of(
                                                            context)
                                                        .style,
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: 'To :  ',
                                                          style: Styles
                                                              .listDescHeadingTextStyle),
                                                      TextSpan(
                                                          text:
                                                              '${item.toPlace}',
                                                          style: Styles
                                                              .listDescWithHeadTextStyle),
                                                    ],
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                RichText(
                                                  text: TextSpan(
                                                    style: DefaultTextStyle.of(
                                                            context)
                                                        .style,
                                                    children: <TextSpan>[
                                                      TextSpan(
                                                          text: 'Reason: ',
                                                          style: Styles
                                                              .listDescHeadingTextStyle),
                                                      TextSpan(
                                                          text:
                                                              '${item.reason}',
                                                          style: Styles
                                                              .listDescWithHeadTextStyle),
                                                    ],
                                                  ),
                                                ),
                                                transportBy.isNotEmpty
                                                    ? Column(
                                                        children: [
                                                          SizedBox(
                                                            height: 10,
                                                          ),
                                                          RichText(
                                                            text: TextSpan(
                                                              style: DefaultTextStyle
                                                                      .of(context)
                                                                  .style,
                                                              children: <
                                                                  TextSpan>[
                                                                TextSpan(
                                                                    text:
                                                                        'Transport : ',
                                                                    style: Styles
                                                                        .listDescHeadingTextStyle),
                                                                TextSpan(
                                                                    text:
                                                                        transportBy,
                                                                    style: Styles
                                                                        .listDescWithHeadTextStyle),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      )
                                                    : SizedBox(),
                                                SizedBox(
                                                  height: 10,
                                                ),
                                                Row(
                                                  children: [
                                                    Text('Status: ',
                                                        style: GoogleFonts.inter(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            fontStyle: FontStyle
                                                                .normal,
                                                            color: ColorResources
                                                                .GREY_SIXTY)),
                                                    CommonMethods.getStatus(
                                                        item.approvalStatus),
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
                                              left: 16, right: 16, bottom: 16),
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
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 16,
                                                            right: 10,
                                                            bottom: 17),
                                                    child: ElevatedButton(
                                                      style: ElevatedButton.styleFrom(
                                                          primary: ColorResources
                                                              .ACCEPT_COLOR_BACKGROUND,
                                                          elevation: 0
                                                          // minimumSize: const Size.fromHeight(50), // NEW
                                                          ),
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
                                                      onPressed: () async {
                                                        CommonMethods
                                                            .showLoaderDialog(
                                                                context);

                                                        try {
                                                          final result =
                                                              await InternetAddress
                                                                  .lookup(
                                                                      'google.com');
                                                          if (result
                                                                  .isNotEmpty &&
                                                              result[0]
                                                                  .rawAddress
                                                                  .isNotEmpty) {



                                                             bloc.approvalAction(item.appDetailsID,
                                                                item.applicationID,
                                                                constants.KEY_APPROVAL_APPROVE)
                                                            .then((value) => {

                                                              if(selectedLang.toString().isEmpty){

                                                                Navigator.pop(
                                                                    context),
                                                                CommonMethods
                                                                    .showMessage(
                                                                    context,
                                                                     value!
                                                                        .messageEn
                                                                        ,
                                                                    Colors
                                                                        .green),
                                                                refresh()


                                                              } else
                                                                {

                                                                  Navigator.pop(
                                                                      context),
                                                                  CommonMethods
                                                                      .showMessage(
                                                                      context,
                                                                      selectedLang ==
                                                                          'en'
                                                                          ? value!
                                                                          .messageEn
                                                                          : value!
                                                                          .messageBn,
                                                                      Colors
                                                                          .green),
                                                                 refresh()
                                                                }
                                                                });



                                                            //print('connected')
                                                          }
                                                        } on SocketException catch (_) {
                                                          print(
                                                              'not connected');
                                                          Navigator.pop(
                                                              context);
                                                          CommonMethods.showMessage(
                                                              context,
                                                              Languages.of(
                                                                      context)!
                                                                  .internetErrorText,
                                                              Colors.red);
                                                        }

                                                        /* bloc.approvalAction(item.appDetailsID,
                                                                item.applicationID,
                                                                constants.KEY_APPROVAL_APPROVE)
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
                                                                      Colors.green),
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
                                                      onPressed: ()  async{
                                                        CommonMethods
                                                            .showLoaderDialog(
                                                                context);

                                                        try {
                                                          final result = await InternetAddress.lookup(
                                                              'google.com');
                                                          if (result.isNotEmpty &&
                                                              result[0].rawAddress.isNotEmpty) {
                                                            bloc
                                                                .approvalAction(
                                                                item.appDetailsID,
                                                                item.applicationID,
                                                                constants.KEY_APPROVAL_REJECT)
                                                                .then((value) => {
                                                                  if(selectedLang.toString().isEmpty){
                                                                    Navigator.pop(
                                                                        context),
                                                                    CommonMethods.showMessage(
                                                                        context, value!.messageEn, Colors.red),
                                                                   // initState()
                                                                    refresh()

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
                                                                        Colors
                                                                            .red),
                                                                    //initState()
                                                                    refresh()
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
                                                            .approvalAction(
                                                                item
                                                                    .appDetailsID,
                                                                item
                                                                    .applicationID,
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
