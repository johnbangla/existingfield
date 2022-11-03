import 'dart:io';

import 'package:buro_employee/localization/Language/languages.dart';
import 'package:buro_employee/repository/database/database_handler.dart';
import 'package:buro_employee/repository/models/apply_request.dart';
import 'package:buro_employee/repository/network/buro_repository.dart';
import 'package:buro_employee/sessionmanager/session_manager.dart';
import 'package:buro_employee/theme/colors.dart';
import 'package:buro_employee/theme/styles.dart';
import 'package:buro_employee/utilities/analytics.dart';
import 'package:buro_employee/utilities/common_methods.dart';
import 'package:buro_employee/views/field_visit/field_visit_main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'apply_page.dart';
import 'package:google_fonts/google_fonts.dart';

class ApplyList extends StatefulWidget {
  static const routeName = '/applyList';

  static route() => MaterialPageRoute(builder: (_) => ApplyList());

  @override
  State<StatefulWidget> createState() => _ApplyListState();
}

class _ApplyListState extends State<ApplyList> {
  late DataBaseHandler handler;
  var repository = BuroRepository();
  var selectPlanId;
  int _currentIndex = 0;
  var selectedLang;

  @override
  void initState() {
    super.initState();

    CommonMethods.getSelectedLang().then((value) => {
          selectedLang = value,
          print('Selected Lang in plan submit $selectedLang')
        });

    this.handler = DataBaseHandler();
    this.handler.applyList();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    analytics.setCurrentScreen('Apply List', 'Stateful widget');
  }

  Future<bool> _willPopCallback() async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => FieldVisitMain()));

    return true; // return true if the route to be popped
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
              '${Languages.of(context)!.applyList}',
              style: Styles.appBarTextStyle,
            ),
          ),
        ),
        body: FutureBuilder(
          future: this.handler.applyList(),
          builder: (BuildContext context,
              AsyncSnapshot<List<ApplyRequest>> snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return Column(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            var item = snapshot.data![index];
                            //print('Plan ID at Apply List ${item.planId}');
                            sessionManager.setPlanId(item.planId);
                            selectPlanId = item;
                            var toPlace;
                            if (item.toBranch.isEmpty) {
                              toPlace = item.toOther;
                            } else if (item.toOther.isEmpty) {
                              toPlace = item.toBranch;
                            } else {
                              toPlace = '${item.toBranch}, ${item.toOther}';
                            }

                            String formattedStartDate =
                                DateFormat.yMMMMd('en_US')
                                    .format(DateTime.parse(item.startDate));
                            String formattedEndDate = DateFormat.yMMMMd('en_US')
                                .format(DateTime.parse(item.endDate));

                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: 24, right: 24, top: 16, bottom: 16),
                              child: Container(
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
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Wrap(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(16.0),
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Column(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Flexible(
                                                                child: Text(
                                                                  '${formattedStartDate} to ${formattedEndDate}',
                                                                  style: Styles
                                                                      .listHeaderTextStyle,
                                                                ),
                                                                flex: 1,
                                                              ),
                                                            ],
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                          )
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .place_outlined,
                                                            size: 18,
                                                            color: ColorResources
                                                                .GREY_DARK_SIXTY,
                                                          ),
                                                          Expanded(
                                                            child: Text(
                                                              '${toPlace}',
                                                              style: Styles
                                                                  .listDescTextStyle,
                                                              softWrap: false,
                                                              maxLines: 1,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          flex: 7,
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 16, left: 16, right: 16),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                            height: 40,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    primary: ColorResources
                                                        .LIST_BORDER_WHITE,
                                                    elevation: 0
                                                    // minimumSize: const Size.fromHeight(50), // NEW
                                                    ),
                                                onPressed: () {
                                                  var item =
                                                      snapshot.data![index];
                                                  /* print(
                                                        'Click Item data${item.id}\n'
                                                        'startDate ${item.startDate}'
                                                        'endDate ${item.endDate}'
                                                        'startTime ${item.startTime}'
                                                        'endTime ${item.endTime}'
                                                        'startForm ${item.startForm}'
                                                        'endForm ${item.endForm}'
                                                        'reason ${item.reason}'
                                                        'transport ${item.transport}');*/

                                                  Navigator.pushNamed(
                                                      context, Apply.routeName,
                                                      arguments: item);
                                                },
                                                child: Text(
                                                  'Edit',
                                                  style: Styles
                                                      .listButtonTextStyle,
                                                )),
                                            width: 70,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Container(
                                            height: 40,
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  elevation: 0,
                                                  primary: ColorResources
                                                      .CANCEL_BUTTON_COLOR,
                                                ),
                                                onPressed: () async {
                                                  deletePopup(snapshot, index);
                                                },
                                                child: Text(
                                                  'Delete',
                                                  style: Styles
                                                      .cancelButtonTextStyle,
                                                )),
                                            width: 90,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                  Row(
                    children: [
                      Flexible(
                          flex: 3,
                          child: SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 25, right: 10, bottom: 10),
                              child: ElevatedButton(
                                onPressed: ()  async{
                                  var applyList = [];
                                  var map;
                                  var planId;
                                  snapshot.data!.asMap().forEach((key, value) {
                                    DateTime startTime =
                                        DateFormat.jm().parse(value.startTime);
                                    var startTimeApiFormat =
                                        DateFormat("HH:mm").format(startTime);
                                    var endTimeApiFormat;
                                    if (value.endTime.isNotEmpty) {
                                      DateTime endTime =
                                          DateFormat.jm().parse(value.endTime);
                                      var endTimeFormat =
                                          DateFormat("HH:mm").format(endTime);

                                      endTimeApiFormat = 'T$endTimeFormat';
                                    } else
                                      endTimeApiFormat = '';

                                    var fromPlace;
                                    var toPlace;

                                    if (value.fromBranch.isEmpty) {
                                      fromPlace = value.fromOther;
                                    } else if (value.fromOther.isEmpty) {
                                      fromPlace = value.fromBranch;
                                    } else {
                                      fromPlace =
                                          '${value.fromBranch}, ${value.fromOther}';
                                    }

                                    if (value.toBranch.isEmpty) {
                                      toPlace = value.toOther;
                                    } else if (value.toOther.isEmpty) {
                                      toPlace = value.toBranch;
                                    } else {
                                      toPlace =
                                          '${value.toBranch}, ${value.toOther}';
                                    }

                                    map = {
                                      "StartDate":
                                          "${value.startDate}T${startTimeApiFormat}",
                                      "EndDate":
                                          "${value.endDate}${endTimeApiFormat}",
                                      "FromPlace": fromPlace,
                                      "ToPlace": toPlace,
                                      "Reason": "${value.reason}",
                                      "TransportBy": "${value.transport}",
                                      "transport": value
                                              .transportFare.isNotEmpty
                                          ? int.parse(value.transportFare) > 0
                                              ? int.parse(value.transportFare)
                                              : 0
                                          : 0,
                                      "morning": value.morning.isNotEmpty
                                          ? int.parse(value.morning) > 0
                                              ? int.parse(value.morning)
                                              : 0
                                          : 0,
                                      "evening": value.afternoon.isNotEmpty
                                          ? int.parse(value.afternoon) > 0
                                              ? int.parse(value.afternoon)
                                              : 0
                                          : 0,
                                      "night": value.night.isNotEmpty
                                          ? int.parse(value.night) > 0
                                              ? int.parse(value.night)
                                              : 0
                                          : 0,
                                      "hotel": value.hotel.isNotEmpty
                                          ? int.parse(value.hotel) > 0
                                              ? int.parse(value.hotel)
                                              : 0
                                          : 0,
                                      "dailyBill": value
                                              .dailyAllowance.isNotEmpty
                                          ? int.parse(value.dailyAllowance) > 0
                                              ? int.parse(value.dailyAllowance)
                                              : 0
                                          : 0,
                                      "specialBill": value
                                              .specialAllowance.isNotEmpty
                                          ? int.parse(value.specialAllowance) >
                                                  0
                                              ? int.parse(
                                                  value.specialAllowance)
                                              : 0
                                          : 0,
                                      "othersBill": 0
                                    };

                                    planId = value.planId;
                                    applyList.add(map);
                                  });


                                  CommonMethods.showLoaderDialog(context);

                                  try {
                                    final result = await InternetAddress.lookup(
                                        'google.com');
                                    if (result.isNotEmpty &&
                                        result[0].rawAddress.isNotEmpty) {

                                      repository
                                          .submitApplyList(applyList, planId)
                                          .then((value) => {
                                        if (value.success)
                                          {
                                            sessionManager.clearPlanId(),
                                            if(selectedLang.toString().isEmpty){
                                             Navigator.pop(context),
                                              CommonMethods.showMessage(
                                                  context, value.messageEn,
                                                  Colors.green),
                                              this.handler.deleteAllItem(),
                                              setState(() {}),
                                              Navigator.pushNamed(context,
                                                  FieldVisitMain.routeName)
                                            } else
                                              {
                                              Navigator.pop(context),
                                                CommonMethods.showMessage(
                                                    context,
                                                    selectedLang == 'en'
                                                        ? value.messageEn
                                                        : value.messageBn,
                                                    Colors.green),
                                                this.handler
                                                    .deleteAllItem(),
                                                setState(() {}),
                                                Navigator.pushNamed(context,
                                                    FieldVisitMain
                                                        .routeName)
                                              }
                                          }
                                        else {
                                          Navigator.pop(context),
                                          CommonMethods.showMessage(context,
                                              Languages.of(context)!.networkError, Colors.red)

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


                                  /* repository
                                      .submitApplyList(applyList, planId)
                                      .then((value) => {
                                            if (value.success)
                                              {
                                                sessionManager.clearPlanId(),
                                                if(selectedLang.toString().isEmpty){

                                                  CommonMethods.showMessage(
                                                      context, value.messageEn,
                                                      Colors.green),
                                                  this.handler.deleteAllItem(),
                                                  setState(() {}),
                                                  Navigator.pushNamed(context,
                                                      FieldVisitMain.routeName)
                                                } else
                                                  {
                                                    CommonMethods.showMessage(
                                                        context,
                                                        selectedLang == 'en'
                                                            ? value.messageEn
                                                            : value.messageBn,
                                                        Colors.green),
                                                    this.handler
                                                        .deleteAllItem(),
                                                    setState(() {}),
                                                    Navigator.pushNamed(context,
                                                        FieldVisitMain
                                                            .routeName)
                                                  }
                                              }
                                            else
                                              CommonMethods.showMessage(context,
                                                  Languages.of(context)!.networkError, Colors.red)
                                          });*/
                                  //print(list);
                                },
                                child: Text(
                                  '${Languages.of(context)!.submitButton}',
                                  style: Styles.buttonTextStyle,
                                ),
                                style: ElevatedButton.styleFrom(
                                  primary: ColorResources.APP_THEME_COLOR,
                                  minimumSize: const Size.fromHeight(50), // NEW
                                ),
                              ),
                            ),
                          )),
                      Flexible(
                          flex: 4,
                          child: SizedBox(
                            width: double.infinity,
                            height: 56,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 25, bottom: 10),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, Apply.routeName);
                                  //print(list);
                                },
                                child: Text(
                                  Languages.of(context)!.addFieldVisit,
                                  style: GoogleFonts.inter(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      fontStyle: FontStyle.normal,
                                      color: ColorResources.ACCEPT_ICON_COLOR),
                                ),
                                style: ElevatedButton.styleFrom(
                                  elevation: 0,
                                  primary:
                                      ColorResources.ACCEPT_COLOR_BACKGROUND,
                                  minimumSize: const Size.fromHeight(50), // NEW
                                ),
                              ),
                            ),
                          ))
                    ],
                  )
                ],
              );
            } else if (snapshot.data!.isEmpty) {
              sessionManager.clearPlanId();
              return Center(
                child: Text(Languages.of(context)!.noFieldVisitText),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Future<void> deletePopup(
      AsyncSnapshot<List<ApplyRequest>> snapshot, int index) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Languages.of(context)!.dialogHeader),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(Languages.of(context)!.deleteText),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              child: Text(Languages.of(context)!.no),
              onPressed: () {
                Navigator.of(context).pop(); // Dismiss the Dialog
              },
            ),
            ElevatedButton(
              child: Text(Languages.of(context)!.yes),
              onPressed: () async {
                print("ID ${snapshot.data![index].id}");
                await this.handler.deleteApplyItem(snapshot.data![index].id);

                setState(() {
                  snapshot.data!.remove(snapshot.data![index]);
                });

                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }
}
