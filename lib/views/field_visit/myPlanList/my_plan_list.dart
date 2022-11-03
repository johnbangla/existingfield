import 'dart:io';

import 'package:buro_employee/localization/Language/languages.dart';
import 'package:buro_employee/repository/bloc/plan_list_cubit/plan_list_cubit.dart';
import 'package:buro_employee/repository/network/buro_repository.dart';
import 'package:buro_employee/sessionmanager/session_manager.dart';
import 'package:buro_employee/theme/colors.dart';
import 'package:buro_employee/theme/styles.dart';
import 'package:buro_employee/utilities/common_methods.dart';
import 'package:buro_employee/views/field_visit/field_visit_main.dart';
import 'package:buro_employee/views/field_visit/myPlanList/my_plan_detail.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class MyPlanList extends StatefulWidget {
  static const routeName = '/myPlanList';

  //const BillSubmit({Key? key}) : super(key: key);
  static route() => MaterialPageRoute(builder: (_) => MyPlanList());

  const MyPlanList({Key? key}) : super(key: key);

  @override
  _MyPlanListState createState() => _MyPlanListState();
}

class _MyPlanListState extends State<MyPlanList> {
  var selectedLang;
  late PlanListCubit bloc;

  @override
  void initState() {
    getSelectedLang().then((value) => {
          selectedLang = value,
          print('Selected Lang in plan list ${value.toString()}')
        });
    bloc = context.read<PlanListCubit>();
    bloc.getPlanList();
    //super.initState();
  }

  Future<String> getSelectedLang() async {
    return await sessionManager.selectedLang;
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PlanListCubit>();
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: ColorResources.APP_THEME_COLOR,
            title: Center(
              child: Text(
                Languages.of(context)!.myPlan,
                style: Styles.appBarTextStyle,
              ),
            ),
          ),
          body: BlocConsumer<PlanListCubit, PlanListState>(
            listener: (context, state) {
              if (state is PlanListErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(Languages.of(context)!.internetErrorText),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              //print('Home page State ${state}');
              if (state is PlanListInitialState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is PlanListLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is PlanListLoadedState) {
                var requestList = state.planList.data;
                return requestList.isNotEmpty
                    ? RefreshIndicator(
                        onRefresh: refresh,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: requestList.length,
                            itemBuilder: (context, index) {
                              var item = requestList[index];
                              String formattedStartDate =
                                  DateFormat.yMMMMd('en_US')
                                      .format(DateTime.parse(item.startDate));
                              String formattedEndDate =
                                  DateFormat.yMMMMd('en_US')
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
                                                      const EdgeInsets.only(
                                                          left: 16,
                                                          right: 16,
                                                          bottom: 16,
                                                          top: 16),
                                                  child: Align(
                                                    alignment: Alignment
                                                        .centerLeft,
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          height: 10,
                                                        ),
                                                        Column(
                                                          children: [
                                                            Row(
                                                              children: [
                                                                Flexible(
                                                                  child:
                                                                      Text(
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
                                                        getRequestHolder(item
                                                            .requestHolder),
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
                                                                '${item.places}',
                                                                style: Styles
                                                                    .listDescTextStyle,
                                                                maxLines: 1,
                                                                softWrap:
                                                                    false,
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
                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            SizedBox(
                                                              width: 5,
                                                            ),
                                                            Text(
                                                              'Status : ',
                                                              style: GoogleFonts.inter(
                                                                  fontSize:
                                                                      12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w400,
                                                                  fontStyle:
                                                                      FontStyle
                                                                          .normal,
                                                                  color: ColorResources
                                                                      .GREY_SIXTY),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                            ),
                                                            Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: ColorResources
                                                                    .PENDING_COLOR,
                                                                borderRadius:
                                                                    BorderRadius.all(
                                                                        Radius.circular(
                                                                  6,
                                                                )),
                                                              ),
                                                              child:
                                                                  Padding(
                                                                padding:
                                                                    const EdgeInsets.all(
                                                                        5.0),
                                                                child: Text(
                                                                  '${requestList[index].activityName}',
                                                                  style: Styles
                                                                      .mediumTextStyle,
                                                                ),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height: 12,
                                                        ),
                                                        Divider(
                                                          height: 1,
                                                          thickness: 1,
                                                          color: ColorResources
                                                              .GREY_THIRTY,
                                                        ),
                                                        item.ableToCancel
                                                            ? SizedBox()
                                                            : Container(
                                                                width: double
                                                                    .infinity,
                                                                child:
                                                                    Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      top:
                                                                          16),
                                                                  child:
                                                                      Container(
                                                                    height:
                                                                        40,
                                                                    child: ElevatedButton(
                                                                        style: ElevatedButton.styleFrom(primary: ColorResources.LIST_BORDER_WHITE, elevation: 0
                                                                            // minimumSize: const Size.fromHeight(50), // NEW
                                                                            ),
                                                                        onPressed: () {
                                                                          Navigator.pushNamed(context, MyPlanDetail.routeName, arguments: item.planID);
                                                                        },
                                                                        child: Text(
                                                                          'View Details',
                                                                          style: Styles.listButtonTextStyle,
                                                                        )),
                                                                  ),
                                                                ),
                                                              )
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
                                      item.ableToCancel
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 16),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Expanded(
                                                    flex: 1,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20,
                                                              right: 20),
                                                      child: Container(
                                                        height: 40,
                                                        child: ElevatedButton(
                                                            style: ElevatedButton.styleFrom(
                                                                primary:
                                                                    ColorResources
                                                                        .LIST_BORDER_WHITE,
                                                                elevation: 0
                                                                // minimumSize: const Size.fromHeight(50), // NEW
                                                                ),
                                                            onPressed: () {
                                                              Navigator.pushNamed(
                                                                  context,
                                                                  MyPlanDetail
                                                                      .routeName,
                                                                  arguments: item
                                                                      .planID);
                                                            },
                                                            child: Text(
                                                              'View Details',
                                                              style: Styles
                                                                  .listButtonTextStyle,
                                                            )),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 20,
                                                  ),
                                                  Expanded(
                                                    flex: 1,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 20,
                                                              right: 20),
                                                      child: Container(
                                                        height: 40,
                                                        child: ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              elevation: 0,
                                                              primary:
                                                                  ColorResources
                                                                      .CANCEL_BUTTON_COLOR,

                                                            ),
                                                            onPressed: () async {
                                                              showLoaderDialog(
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
                                                                  bloc
                                                                      .cancelPlanRequestAll(item
                                                                          .planID)
                                                                      .then(
                                                                          (value) =>
                                                                              {
                                                                                Navigator.pop(context),
                                                                                if (selectedLang.toString().isEmpty)
                                                                                  {
                                                                                    CommonMethods.showMessage(context, value!.messageEn, Colors.green),
                                                                                    initState()
                                                                                  }
                                                                                else
                                                                                  {
                                                                                    CommonMethods.showMessage(context, selectedLang == 'en' ? value!.messageEn : value!.messageBn, Colors.green),
                                                                                    initState()
                                                                                  }
                                                                              });

                                                                  //print('connected');
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
                                                            },
                                                            child: Text(
                                                              Languages.of(
                                                                      context)!
                                                                  .cancel,
                                                              style: Styles
                                                                  .cancelButtonTextStyle,
                                                            )),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          : SizedBox(
                                              height: 10,
                                            ),
                                    ],
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

  Future<bool> _willPopCallback() async {
    Navigator.pushNamed(context, FieldVisitMain.routeName);
    return true;
  }

  void showMessage(BuildContext context, String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
      ),
      backgroundColor: color,
    ));
  }

  Future refresh() {
    return Future.delayed(
      Duration(seconds: 1),
      () {
        bloc = context.read<PlanListCubit>();
        bloc.getPlanList();
      },
    );
  }

  /* Widget getRequestHolder(String? holderName) {
    if (holderName != null)
      return Column(
        children: [
          Text(holderName = 'Holder : ${holderName}'),
          SizedBox(
            height: 10,
          ),
        ],
      );
    else
      return SizedBox();
  }*/

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

  Widget getRequestHolder(String? holderName) {
    if (holderName != null)
      return Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.person,
                size: 18,
                color: ColorResources.GREY_DARK_SIXTY,
              ),
              Text(
                holderName = '${holderName}',
                style: Styles.listDescTextStyle,
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
        ],
      );
    else
      return SizedBox();
  }
}
