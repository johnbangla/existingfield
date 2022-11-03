import 'dart:io';

import 'package:buro_employee/localization/Language/languages.dart';
import 'package:buro_employee/repository/bloc/my_request/request_cubit.dart';
import 'package:buro_employee/sessionmanager/session_manager.dart';
import 'package:buro_employee/theme/colors.dart';
import 'package:buro_employee/theme/styles.dart';
import 'package:buro_employee/utilities/analytics.dart';
import 'package:buro_employee/utilities/common_methods.dart';
import 'package:buro_employee/views/field_visit/myrequest/request_details.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

import '../field_visit_main.dart';

class RequestList extends StatefulWidget {
  static const routeName = '/requestList';

  static route() => MaterialPageRoute(builder: (_) => RequestList());

  @override
  State<StatefulWidget> createState() => _RequestListState();
}

class _RequestListState extends State<RequestList> {
  var selectedLang;
  var bloc;

  @override
  void initState() {
    getSelectedLang().then((value) => {
          selectedLang = value,
        });

    bloc = context.read<RequestCubit>();
    bloc.getRequestList();
    //super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    analytics.setCurrentScreen('Request List', 'StatefulWidget');
  }

  Widget getRequestHolder(String? holderName) {
    if (holderName != null)
      return Column(
        children: [
          Row(children: [
            Icon(Icons.person,size: 18,color: ColorResources.GREY_DARK_SIXTY,),
            Text(holderName = '${holderName}',style: Styles.listDescTextStyle,),
          ],),
          SizedBox(
            height: 10,
          ),
        ],
      );
    else
      return SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RequestCubit>();
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: ColorResources.APP_THEME_COLOR,
            title: Center(
              child: Text(
                '${Languages.of(context)!.myRequestListTitle}',
                style: Styles.appBarTextStyle,
              ),
            ),

          ),
          body: BlocConsumer<RequestCubit, RequestState>(
            listener: (context, state) {
              if (state is RequestErrorState) {
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
              if (state is RequestInitialState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is RequestLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is RequestLoadedState) {
                var requestList = state.requestList.data;
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
                              String formattedEndDate = DateFormat.yMMMMd('en_US')
                                  .format(DateTime.parse(item.endDate));

                              return Padding(
                                padding: const EdgeInsets.only(
                                  left: 24,
                                  right: 24,
                                  top: 16,
                                  bottom: 16
                                ),
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
                                      Container(
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: Wrap(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16.0),
                                                    child: Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
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
                                                              Flexible(
                                                                child: Container(
                                                                  child: Align(
                                                                    alignment: Alignment.center,
                                                                    child: Row(
                                                                      mainAxisAlignment: MainAxisAlignment.end,
                                                                      children: [
                                                                        Text(
                                                                            'Status:  ',textAlign: TextAlign.end,

                                                                            style: GoogleFonts.inter(
                                                                                fontSize: 12,
                                                                                fontWeight:
                                                                                FontWeight
                                                                                    .w400,
                                                                                fontStyle:
                                                                                FontStyle
                                                                                    .normal,
                                                                                color: ColorResources
                                                                                    .GREY_SIXTY)
                                                                        ),
                                                                      SizedBox(width: 5,),
                                                                        CommonMethods.getStatus(item.approvalStatus)
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                flex: 1,
                                                              )
                                                            ],
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .spaceBetween,
                                                          ),
                                                          SizedBox(
                                                            height: 10,
                                                          ),

                                                          getRequestHolder(item
                                                              .requestHolder),
                                                         Row(children: [
                                                           Icon(Icons.place_outlined,size: 18,color: ColorResources.GREY_DARK_SIXTY,),
                                                           Expanded(
                                                             child: Text(
                                                               '${item.places}',overflow: TextOverflow.ellipsis,
                                                               softWrap: false,
                                                               maxLines: 1,
                                                               style: Styles
                                                                   .listDescTextStyle,
                                                             ),
                                                           ),
                                                         ],) ,
                                                          SizedBox(
                                                            height: 10,
                                                          ),

                                                          item.ableToCancel ? SizedBox(height: 0,):Padding(
                                                            padding: const EdgeInsets.only(top: 10),
                                                            child: Container(
                                                              width: double.infinity,
                                                              height: 40,
                                                              child: ElevatedButton(
                                                                  style: ElevatedButton.styleFrom(
                                                                      primary: ColorResources
                                                                          .LIST_BORDER_WHITE,
                                                                      elevation: 0
                                                                    // minimumSize: const Size.fromHeight(50), // NEW
                                                                  ),
                                                                  onPressed: () {

                                                                    Navigator.pushNamed(
                                                                        context, RequestDetails.routeName,
                                                                        arguments: item.applicationID);


                                                                  },
                                                                  child: Text(
                                                                    Languages.of(context)!.viewDetails,
                                                                    style: Styles
                                                                        .listButtonTextStyle,
                                                                  )),
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
                                      ),
                                      item.ableToCancel
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 16),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceEvenly,
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
                                                                primary: ColorResources
                                                                    .LIST_BORDER_WHITE,
                                                                elevation: 0
                                                                // minimumSize: const Size.fromHeight(50), // NEW
                                                                ),
                                                            onPressed: () {

                                                              Navigator.pushNamed(
                                                                  context, RequestDetails.routeName,
                                                                  arguments: item.applicationID);

                                                            },
                                                            child: Text(
                                                              Languages.of(context)!.viewDetails,
                                                              style: Styles
                                                                  .listButtonTextStyle,
                                                            )),
                                                      ),
                                                    ),
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
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                              elevation: 0,
                                                              primary: ColorResources
                                                                  .CANCEL_BUTTON_COLOR,
                                                              // minimumSize: const Size.fromHeight(50), // NEW
                                                            ),
                                                            onPressed: () async{

                                                              CommonMethods.showLoaderDialog(context);

                                                              try {
                                                                final result = await InternetAddress.lookup(
                                                                    'google.com');
                                                                if (result.isNotEmpty &&
                                                                    result[0].rawAddress.isNotEmpty) {

                                                                  bloc.requestCancelAll(
                                                                      item.applicationID)
                                                                      .then((value) => {

                                                                        if(value!.success){
                                                                          if(selectedLang.toString().isEmpty){
                                                                            Navigator.pop(context),
                                                                            CommonMethods.showMessage(
                                                                                context,
                                                                                value
                                                                                    .messageEn,
                                                                                Colors.green),
                                                                            initState()
                                                                          } else {
                                                                              Navigator.pop(context),
                                                                              CommonMethods
                                                                                  .showMessage(
                                                                                  context,
                                                                                  selectedLang ==
                                                                                      'en'
                                                                                      ? value
                                                                                      .messageEn
                                                                                      : value
                                                                                      .messageBn,
                                                                                  Colors
                                                                                      .green),
                                                                              initState()
                                                                            }

                                                                        } else {
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


                                                              /*bloc
                                                                  .requestCancelAll(
                                                                  item.applicationID)
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
                                                            child: Text(
                                                              Languages.of(context)!.cancel,
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

  Future<String> getSelectedLang() async {
    return await sessionManager.selectedLang;
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
        bloc = context.read<RequestCubit>();
        bloc.getRequestList();
      },
    );
  }
}
