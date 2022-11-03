import 'dart:io';

import 'package:buro_employee/localization/Language/languages.dart';
import 'package:buro_employee/repository/bloc/request_details/request_details_cubit.dart';
import 'package:buro_employee/theme/colors.dart';
import 'package:buro_employee/theme/styles.dart';
import 'package:buro_employee/utilities/analytics.dart';
import 'package:buro_employee/utilities/common_methods.dart';
import 'package:buro_employee/views/field_visit/myrequest/request_list.dart';
import 'package:flutter/material.dart';
import '../../../app.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:date_time_format/date_time_format.dart';
import 'package:google_fonts/google_fonts.dart';

class RequestDetails extends StatefulWidget {
  static const routeName = '/requestDetails';
  late final int arguments;

  RequestDetails(this.arguments, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RequestDetailsState();
}

class _RequestDetailsState extends State<RequestDetails> {
  var selectedLang;
  var bloc;

  @override
  void initState() {
    CommonMethods.getSelectedLang().then((value) => {
          selectedLang = value /*, print('Selecetdlang $selectedLang')*/
        });

    bloc = context.read<RequestDetailsCubit>();
    bloc.getRequestDetails(widget.arguments);
   // super.initState();
  }

  Future refresh() {
    return Future.delayed(
      Duration(seconds: 1),
      () {
        bloc = context.read<RequestDetailsCubit>();
        bloc.getRequestDetails(widget.arguments);
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    analytics.setCurrentScreen('Request Details', 'Stateful widget');
  }

  @override
  Widget build(BuildContext context) {
    bloc = context.read<RequestDetailsCubit>();
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: ColorResources.APP_THEME_COLOR,
            title: Center(
              child: Text(
                '${Languages.of(context)!.myRequestDetailsTitle}',
                style: Styles.appBarTextStyle,
              ),
            ),

          ),
          body: BlocConsumer<RequestDetailsCubit, RequestDetailsState>(
            listener: (context, state) {
              if (state is RequestDetailsErrorState) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Network Error"),
                  ),
                );
              }
            },
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              if (state is RequestDetailsInitialState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is RequestDetailsLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is RequestDetailsLoadedState) {
                var list = state.requestDetails.data;
                return list.isNotEmpty
                    ? Column(
                        children: [
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

                                      String startTime =
                                          item.startDate.substring(11, 19);

                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          left: 25,
                                          right: 25,
                                          top: 25,
                                        ),
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
                                                      left: 20, right: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Text(
                                                        '$formattedStartDate  to $formattedEndDate',
                                                        style: Styles
                                                            .listHeaderTextStyle,
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      RichText(
                                                        text: TextSpan(
                                                          style:
                                                              DefaultTextStyle.of(
                                                                      context)
                                                                  .style,
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                                text: 'From: ',
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
                                                          style:
                                                              DefaultTextStyle.of(
                                                                      context)
                                                                  .style,
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                                text: 'To: ',
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
                                                          style:
                                                              DefaultTextStyle.of(
                                                                      context)
                                                                  .style,
                                                          children: <TextSpan>[
                                                            TextSpan(
                                                              text: 'Reason: ',
                                                              style: Styles
                                                                  .listDescHeadingTextStyle,
                                                            ),
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
                                                                    style: DefaultTextStyle.of(
                                                                            context)
                                                                        .style,
                                                                    children: <
                                                                        TextSpan>[
                                                                      TextSpan(
                                                                          text:
                                                                              'Transport By: ',
                                                                          style: Styles
                                                                              .listDescHeadingTextStyle),
                                                                      TextSpan(
                                                                          text:
                                                                              '${item.transportBy}',
                                                                          style: Styles
                                                                              .listDescWithHeadTextStyle),
                                                                    ],
                                                                  ),
                                                                ),
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
                                                                  FontWeight
                                                                      .w400,
                                                                  fontStyle:
                                                                  FontStyle
                                                                      .normal,
                                                                  color: ColorResources
                                                                      .GREY_SIXTY)),
                                                          CommonMethods.getStatus(item.approvalStatus),
                                                        ],),

                                                      SizedBox(
                                                        height: 15,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                              item.ableToCancel
                                                  ? Column(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left: 16,
                                                                  right: 16),
                                                          child: Divider(
                                                            height: 1,
                                                            thickness: 1,
                                                            color: ColorResources
                                                                .GREY_THIRTY,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(18.0),
                                                          child: Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  ColorResources
                                                                      .WHITE,
                                                              border: Border.all(
                                                                  color: ColorResources
                                                                      .LIST_BORDER_WHITE,
                                                                  width: 1),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .all(Radius
                                                                          .circular(
                                                                10,
                                                              )),
                                                            ),
                                                            width:
                                                                double.infinity,
                                                            height: 40,
                                                            child: ElevatedButton(
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                elevation: 0,
                                                                primary:
                                                                    ColorResources
                                                                        .CANCEL_BUTTON_COLOR,
                                                                // minimumSize: const Size.fromHeight(50), // NEW
                                                              ),
                                                              onPressed: () async{
                                                                showLoaderDialog(context);

                                                                try {
                                                                  final result = await InternetAddress.lookup(
                                                                      'google.com');
                                                                  if (result.isNotEmpty &&
                                                                      result[0].rawAddress.isNotEmpty) {

                                                                    bloc.requestCancel(
                                                                        item.appDetailsID,
                                                                        item.applicationID)
                                                                        .then((value) =>
                                                                       {
                                                                         if(selectedLang.toString().isEmpty){
                                                                           Navigator.pop(context),
                                                                            CommonMethods.showMessage(
                                                                                context,
                                                                                 value!.messageEn ,
                                                                                Colors.green),
                                                                            initState()

                                                                          }else {

                                                                            Navigator.pop(context),
                                                                            CommonMethods.showMessage(
                                                                                context,
                                                                                selectedLang == 'en' ? value!.messageEn : value!.messageBn,
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
                                                                      Languages.of(context)!.internetErrorText,
                                                                      Colors.red);
                                                                }

                                                                /* bloc
                                                                    .requestCancel(
                                                                        item
                                                                            .appDetailsID,
                                                                        item
                                                                            .applicationID)
                                                                    .then(
                                                                        (value) =>
                                                                            {
                                                                              Navigator.pop(context),
                                                                              CommonMethods.showMessage(
                                                                                  context,
                                                                                  selectedLang == 'en' ? value!.messageEn : value!.messageBn,
                                                                                  Colors.green),
                                                                              initState()
                                                                            });*/
                                                              },
                                                              child: Text(
                                                                '${Languages.of(context)!.cancel}',
                                                                style: Styles
                                                                    .cancelButtonTextStyle,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  : SizedBox()
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ),
                          ),
                        ],
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


  static showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(

      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text("Connecting..." )),
        ],),
    );

    showDialog(barrierDismissible: true,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }


  Future<bool> _willPopCallback() async {
    Navigator.pushNamed(context, RequestList.routeName);
    return true;
  }



}
