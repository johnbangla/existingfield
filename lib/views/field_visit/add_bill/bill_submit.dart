import 'package:buro_employee/localization/Language/languages.dart';
import 'package:buro_employee/repository/bloc/bill_details/bill_details_cubit.dart';
import 'package:buro_employee/repository/models/bill_request_details.dart';
import 'package:buro_employee/sessionmanager/session_manager.dart';
import 'package:buro_employee/theme/colors.dart';
import 'package:buro_employee/theme/styles.dart';
import 'package:buro_employee/utilities/common_methods.dart';
import 'package:buro_employee/widgets/white_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'bill_req_list.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';

class BillSubmit extends StatefulWidget {
  static const routeName = '/billSubmit';

  late final int arguments;

  BillSubmit(this.arguments, {Key? key}) : super(key: key);

  @override
  _BillSubmitState createState() => _BillSubmitState();
}

class _BillSubmitState extends State<BillSubmit> {
  late BillDetailsCubit bloc;
  var selectedLang;
  var indexItem = 0;
  var isLast = false;
  int count = 0;

  var billSubmitList = [];

  PageController controller = PageController();
  List<Widget> _widgetList = <Widget>[];
  List<TextEditingController> _controllerTransportBy = [];
  List<TextEditingController> _controllerTransport = [];
  List<TextEditingController> _controllerMorning = [];
  List<TextEditingController> _controllerEvening = [];
  List<TextEditingController> _controllerNight = [];
  List<TextEditingController> _controllerHotel = [];
  List<TextEditingController> _controllerDailyBill = [];
  List<TextEditingController> _controllerSpecialBill = [];
  var _curr = 0;

  List<List<TextEditingController>> controllerList =
      []; // This controllerList need for view data
  List<String> transportByViewList = [];
  List<String> transportViewList = [];
  List<String> morningViewList = [];
  List<String> eveningViewList = [];
  List<String> nightViewList = [];
  List<String> hotelViewList = [];
  List<String> dailyBillViewList = [];
  List<String> specialBillViewList = [];
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late SessionManager sessionManager;

  @override
  void initState() {
    sessionManager = SessionManager();
    CommonMethods.getSelectedLang().then((value) => {
          selectedLang = value,
          print('Selecetdlang Bill Submit  $selectedLang')
        });

    bloc = context.read<BillDetailsCubit>();

    bloc
        .getBillDetails(widget.arguments)
        .then((value) => {initUI(value!.data)});

    super.initState();
  }

  @override
  void dispose() {
    _controllerTransport.clear();
    print('Dispose called');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('Widget Build called');
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: ColorResources.APP_THEME_COLOR,
          title: Center(
              child: Text(
            Languages.of(context)!.billText,
            style: Styles.appBarTextStyle,
          )),
        ),
        body: BlocConsumer<BillDetailsCubit, BillDetailsState>(
          listener: (context, state) {
            if (state is BillDetailsErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Network Error"),
                ),
              );
            }
          },
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            // print('Bill Request Page State ${state}');

            if (state is BillDetailsInitialState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is BillDetailsLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is BillDetailsLoadedState) {
              var billDetailsList = state.billRequestDetails.data;
              return billDetailsList.isNotEmpty
                  ? bodyElements(state.billRequestDetails)
                  : Center(
                      child: Text(Languages.of(context)!.noDataFound),
                    );
            } else if (state is BillSubmitLoadedState) {
              if (state.billSubmitResponse.success) {
                Fluttertoast.showToast(
                    msg: selectedLang == 'bn'
                        ? '${state.billSubmitResponse.messageBn}'
                        : '${state.billSubmitResponse.messageEn}',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);

                WidgetsBinding.instance!.addPostFrameCallback((_) {
                  Navigator.pushNamed(context, BillReqList.routeName);
                });
              } else {
                Fluttertoast.showToast(
                    msg: selectedLang == 'bn'
                        ? '${state.billSubmitResponse.messageBn}'
                        : '${state.billSubmitResponse.messageEn}',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.red,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }

              return Container();
            } else {
              // (state is WeatherError)
              return Container(
                child: Text('Error'),
              );
            }
          },
        ));
  }

  void initUI(List<Data> billDetailsList) {
    var itemCount = billDetailsList.length;
    var list = billDetailsList;

    list.forEach((element) {
      transportByViewList.add(
          element.transportBy != null ? element.transportBy.toString() : '');
      transportViewList
          .add(element.transport > 0 ? element.transport.toString() : '');
      morningViewList
          .add(element.morning > 0 ? element.morning.toString() : '');
      eveningViewList
          .add(element.evening > 0 ? element.evening.toString() : '');
      nightViewList.add(element.night > 0 ? element.night.toString() : '');
      hotelViewList.add(element.hotel > 0 ? element.hotel.toString() : '');
      dailyBillViewList
          .add(element.dailyBill > 0 ? element.dailyBill.toString() : '');
      specialBillViewList
          .add(element.specialBill > 0 ? element.specialBill.toString() : '');
    });

    list.asMap().forEach((key, value) {
      _controllerTransportBy.add(TextEditingController());
      _controllerTransport.add(TextEditingController());
      _controllerMorning.add(TextEditingController());
      _controllerEvening.add(TextEditingController());
      _controllerNight.add(TextEditingController());
      _controllerHotel.add(TextEditingController());
      _controllerDailyBill.add(TextEditingController());
      _controllerSpecialBill.add(TextEditingController());

      _widgetList.add(childWidget(key, value));
    });

    controllerList.add(_controllerTransportBy);
    controllerList.add(_controllerTransport);
    controllerList.add(_controllerMorning);
    controllerList.add(_controllerEvening);
    controllerList.add(_controllerNight);
    controllerList.add(_controllerHotel);
    controllerList.add(_controllerDailyBill);
    controllerList.add(_controllerSpecialBill);

    controllerList.asMap().forEach((listIndex, listItem) {
      if (listIndex == 0) {
        // transport by
        listItem.asMap().forEach((controllerListIndex, controllerListItem) {
          if (controllerListIndex < itemCount) {
            controllerListItem.text = transportByViewList[controllerListIndex];
          }
        });
      }

      if (listIndex == 1) {
        // transport
        listItem.asMap().forEach((controllerListIndex, controllerListItem) {
          if (controllerListIndex < itemCount) {
            controllerListItem.text = transportViewList[controllerListIndex];
          }
        });
      }

      if (listIndex == 2) {
        // morning

        listItem.asMap().forEach((controllerListIndex, controllerListItem) {
          if (controllerListIndex < itemCount) {
            controllerListItem.text = morningViewList[controllerListIndex];
          }
        });
      }

      if (listIndex == 3) {
        // evening

        listItem.asMap().forEach((controllerListIndex, controllerListItem) {
          if (controllerListIndex < itemCount) {
            controllerListItem.text = eveningViewList[controllerListIndex];
          }
        });
      }

      if (listIndex == 4) {
        // night

        listItem.asMap().forEach((controllerListIndex, controllerListItem) {
          if (controllerListIndex < itemCount) {
            controllerListItem.text = nightViewList[controllerListIndex];
          }
        });
      }

      if (listIndex == 5) {
        //  hotel

        listItem.asMap().forEach((controllerListIndex, controllerListItem) {
          if (controllerListIndex < itemCount) {
            controllerListItem.text = hotelViewList[controllerListIndex];
          }
        });
      }

      if (listIndex == 6) {
        // daily bill

        listItem.asMap().forEach((controllerListIndex, controllerListItem) {
          if (controllerListIndex < itemCount) {
            controllerListItem.text = dailyBillViewList[controllerListIndex];
          }
        });
      }

      if (listIndex == 7) {
        // special bill

        listItem.asMap().forEach((controllerListIndex, controllerListItem) {
          if (controllerListIndex < itemCount) {
            controllerListItem.text = specialBillViewList[controllerListIndex];
          }
        });
      }
    });
  }

  Widget bodyElements(BillRequestDetails billDetailsInfo) {
    var list = billDetailsInfo.data;
    var itemCount = billDetailsInfo.data.length;
    return ListView(
      children: [
        Container(
          height: 550,
          child: PageView(
            children: _widgetList,
            controller: controller,
            onPageChanged: (num) {
              print('Num $num');
              setState(() {
                _curr = num;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 20,
            left: 15,
            right: 15,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                  flex: 1,
                  child: InkWell(
                    onTap: () {
                      if (count != 0) {
                        controller.animateToPage(
                          count - 1,
                          duration: Duration(milliseconds: 200),
                          curve: Curves.easeOut,
                        );
                        count--;
                      } else if (count == 0) {
                        print('This is the first page');
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Container(
                        child: Row(
                          children: <Widget>[
                            Icon(Icons.arrow_back_ios,
                                size: 10, color: ColorResources.BLACK),
                            SizedBox(
                              width: 7,
                            ),
                            Expanded(
                                child: Text(
                              Languages.of(context)!.previousText,
                              style: Styles.nextPrevTextStyle,
                            )),
                          ],
                        ),
                      ),
                    ),
                  )),
              SizedBox(
                width: 20,
              ),
              Expanded(
                flex: 1,
                child: InkWell(
                  onTap: () {
                    if (count != list.length - 1) {
                      controller.animateToPage(
                        count + 1,
                        duration: Duration(milliseconds: 200),
                        curve: Curves.easeOut,
                      );
                      count++;
                    } else if (count == list.length - 1) {
                      print('This is the last');
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Container(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Align(
                            child: Text(
                              Languages.of(context)!.nextText,
                              style: Styles.nextPrevTextStyle,
                            ),
                            alignment: Alignment.centerRight,
                          )),
                          SizedBox(
                            width: 7,
                          ),
                          Icon(Icons.arrow_forward_ios_outlined,
                              size: 10, color: ColorResources.BLACK),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 30),
            child: SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () async {
                  late Map<String, dynamic> billMap;
                  if (billSubmitList.length < itemCount) {
                    // This Loop is need for handle
                    // the submit List length
                    list.asMap().forEach((key, value) {
                      billMap = {
                        "appDetailsID": value.appDetailsID,
                        "applicationID": value.applicationID,
                        "transportBy": '',
                        "transport": 0,
                        "morning": 0,
                        "evening": 0,
                        "night": 0,
                        "hotel": 0,
                        "dailyBill": 0,
                        "specialBill": 0,
                        "othersBill": 0
                      };

                      billSubmitList.add(billMap);
                    });
                  }

                  var emptyTransport = false;
                  List<bool> isEmptyTrueList = [];
                  List<bool> isEmptyFalseList = [];

                  _controllerTransportBy.asMap().forEach((key, value) {
                    if (key < itemCount) {
                      if (value.text.isEmpty) {
                        isEmptyTrueList.add(true);
                      }
                      if (value.text.isNotEmpty) {
                        isEmptyFalseList.add(false);
                      }
                    }
                  });

                  if (isEmptyFalseList.length == itemCount) {
                    emptyTransport = false;
                  } else {
                    emptyTransport = true;
                  }

                  if (emptyTransport) {
                    final snackBar = SnackBar(
                      content: Text(
                          Languages.of(context)!.transportTypeValidationText),
                      backgroundColor: Colors.red,
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    // _scaffoldKey.currentState!.showSnackBar(snackBar);

                  } else {
                    list.asMap().forEach((key, value) {
                      // Need TO add list

                      billMap = {
                        "appDetailsID": list[key].appDetailsID,
                        "applicationID": list[key].applicationID,
                        "transportBy": _controllerTransportBy[key].text.isEmpty
                            ? ''
                            : _controllerTransportBy[key].text,
                        "transport": _controllerTransport[key].text.isEmpty
                            ? 0
                            : int.parse(_controllerTransport[key].text),
                        "morning": _controllerMorning[key].text.isEmpty
                            ? 0
                            : int.parse(_controllerMorning[key].text),
                        "evening": _controllerEvening[key].text.isEmpty
                            ? 0
                            : int.parse(_controllerEvening[key].text),
                        "night": _controllerNight[key].text.isEmpty
                            ? 0
                            : int.parse(_controllerNight[key].text),
                        "hotel": _controllerHotel[key].text.isEmpty
                            ? 0
                            : int.parse(_controllerHotel[key].text),
                        "dailyBill": _controllerDailyBill[key].text.isEmpty
                            ? 0
                            : int.parse(_controllerDailyBill[key].text),
                        "specialBill": _controllerSpecialBill[key].text.isEmpty
                            ? 0
                            : int.parse(_controllerSpecialBill[key].text),
                        "othersBill": 0
                      };

                      billSubmitList[key] = billMap;
                    });

                    // print(billSubmitList);
                    bloc.billSubmit(billSubmitList);
                  }
                },
                child: Text('${Languages.of(context)!.submitButton}'),
                style: ElevatedButton.styleFrom(
                  elevation: 0,
                  primary: ColorResources.APP_THEME_COLOR,
                  minimumSize: const Size.fromHeight(50), // NEW
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget childWidget(int index, Data info) {
    //print('Index $index');

    print('Child Widget Called');

    String formattedStartDate =
        DateFormat.yMMMMd('en_US').format(DateTime.parse(info.startDate));
    String formattedEndDate =
        DateFormat.yMMMMd('en_US').format(DateTime.parse(info.endDate));

    return Container(
      child: ListView(
        children: [
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 12),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: 5, left: 16, top: 16, right: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                '$formattedStartDate to $formattedEndDate',
                                textAlign: TextAlign.start,
                                style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w700,
                                    fontStyle: FontStyle.normal,
                                    color: ColorResources.GREY_NINETY),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5, bottom: 5, left: 16),
                          child: Row(
                            children: [
                              Icon(
                                Icons.place,
                                size: 15,
                                color: ColorResources.GREY_DARK_SIXTY,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Text(
                                  '${info.fromPlace} to ${info.toPlace}',
                                  style: GoogleFonts.inter(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12,
                                      color: ColorResources.GREY_DARK_SIXTY),
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  softWrap: true,
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 5, bottom: 16, left: 16, right: 16),
                          child: Row(
                            children: [
                              Icon(
                                Icons.batch_prediction_rounded,
                                size: 15,
                                color: ColorResources.GREY_DARK_SIXTY,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Expanded(
                                child: Text('${info.reason}',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    softWrap: true,
                                    style: GoogleFonts.inter(
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12,
                                        color: ColorResources.GREY_DARK_SIXTY),
                                    textAlign: TextAlign.start),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                /* Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 8, top: 20, bottom: 20),
                  child: Text(
                    Languages.of(context)!.billDetailsText,
                    style: Styles.listHeaderTextStyle,
                  ),
                ),
              ),*/
                Container(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 25, bottom: 5),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            Languages.of(context)!.transportByText,
                            style: GoogleFonts.inter(
                                fontWeight: FontWeight.w600,
                                fontSize: 14,
                                color: ColorResources.GREY_NINETY),
                          ),
                        ),
                      ),

                      /*Padding(
                      padding: const EdgeInsets.only(
                          right: 30, top: 5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: MainTextField(
                          controller:
                          _controllerTransportBy[
                          index],
                          label: '',
                          maxLines: 1,
                        ),
                      ),
                    )*/

                      Padding(
                        padding: const EdgeInsets.only(
                          left: 25,
                          right: 25,
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: WhiteTextField(
                            isNumeric: false,
                            controller: _controllerTransportBy[index],
                            //label: '',
                            maxLines: 1, hint: '',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 25,
                          top: 15,
                        ),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(Languages.of(context)!.transportText,
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: ColorResources.GREY_NINETY))),
                      ),
                      /* Padding(
                      padding: const EdgeInsets.only(
                          right: 30, top: 5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: NumericTextField(
                          controller:
                          _controllerTransport[index],
                          label: '',
                          maxLines: 1,
                          isNumeric: true,
                        ),
                      ),
                    )*/

                      Padding(
                        padding:
                            const EdgeInsets.only(left: 25, right: 25, top: 5),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: WhiteTextField(
                            controller: _controllerTransport[index],
                            hint: '',
                            maxLines: 1,
                            isNumeric: true,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25, top: 15),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(Languages.of(context)!.breakfastText,
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: ColorResources.GREY_NINETY))),
                      ),

                      /*Padding(
                      padding: const EdgeInsets.only(
                          right: 30, top: 5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: NumericTextField(
                          controller:
                          _controllerMorning[index],
                          label: '',
                          maxLines: 1,
                          isNumeric: true,
                        ),
                      ),
                    ),
                    */
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 25, right: 25, top: 5),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: WhiteTextField(
                            controller: _controllerMorning[index],
                            //label: '',
                            maxLines: 1,
                            isNumeric: true, hint: '',
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25, top: 15),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(Languages.of(context)!.lunchText,
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: ColorResources.GREY_NINETY))),
                      ),

                      /*Padding(
                      padding: const EdgeInsets.only(
                          right: 30, top: 5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: NumericTextField(
                          controller:
                          _controllerEvening[index],
                          label: '',
                          maxLines: 1,
                          isNumeric: true,
                          onChanged: (value) {
                            //reason = value;
                          },
                        ),
                      ),
                    ),*/

                      Padding(
                        padding:
                            const EdgeInsets.only(left: 25, right: 25, top: 5),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: WhiteTextField(
                            controller: _controllerEvening[index],
                            hint: '',
                            maxLines: 1,
                            isNumeric: true,
                            onChanged: (value) {
                              //reason = value;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25, top: 15),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(Languages.of(context)!.dinnerText,
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: ColorResources.GREY_NINETY))),
                      ),

                      /* Padding(
                      padding: const EdgeInsets.only(
                          right: 30, top: 5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: NumericTextField(
                          controller:
                          _controllerNight[index],
                          label: '',
                          maxLines: 1,
                          isNumeric: true,
                          onChanged: (value) {
                            //reason = value;
                          },
                        ),
                      ),
                    ),
                    */
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 25, right: 25, top: 5),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: WhiteTextField(
                            controller: _controllerNight[index],
                            hint: '',
                            maxLines: 1,
                            isNumeric: true,
                            onChanged: (value) {
                              //reason = value;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25, top: 15),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(Languages.of(context)!.hotelText,
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: ColorResources.GREY_NINETY))),
                      ),

                      /* Padding(
                      padding: const EdgeInsets.only(
                          right: 30, top: 5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: NumericTextField(
                          controller:
                          _controllerHotel[index],
                          label: '',
                          maxLines: 1,
                          isNumeric: true,
                          onChanged: (value) {
                            //reason = value;
                          },
                        ),
                      ),
                    ), */

                      Padding(
                        padding:
                            const EdgeInsets.only(left: 25, right: 25, top: 5),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: WhiteTextField(
                            controller: _controllerHotel[index],
                            hint: '',
                            maxLines: 1,
                            isNumeric: true,
                            onChanged: (value) {
                              //reason = value;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25, top: 15),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(Languages.of(context)!.dailyAlncText,
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: ColorResources.GREY_NINETY))),
                      ),

                      /* Padding(
                      padding: const EdgeInsets.only(
                          right: 30, top: 5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: NumericTextField(
                          controller:
                          _controllerDailyBill[index],
                          label: '',
                          maxLines: 1,
                          isNumeric: true,
                          onChanged: (value) {
                            //reason = value;
                          },
                        ),
                      ),
                    ),*/
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 25, right: 25, top: 5),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: WhiteTextField(
                            controller: _controllerDailyBill[index],
                            hint: '',
                            maxLines: 1,
                            isNumeric: true,
                            onChanged: (value) {
                              //reason = value;
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 25, top: 15),
                        child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(Languages.of(context)!.specialAlncText,
                                style: GoogleFonts.inter(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: ColorResources.GREY_NINETY))),
                      ),

                      /* Padding(
                      padding: const EdgeInsets.only(
                          right: 30, top: 5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: NumericTextField(
                          controller:
                          _controllerSpecialBill[index],
                          label: '',
                          isNumeric: true,
                          maxLines: 1,
                          onChanged: (value) {
                            //reason = value;
                          },
                        ),
                      ),
                    ),*/

                      Padding(
                        padding: const EdgeInsets.only(
                            left: 25, right: 25, top: 5, bottom: 10),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: WhiteTextField(
                            controller: _controllerSpecialBill[index],
                            hint: '',
                            isNumeric: true,
                            maxLines: 1,
                            onChanged: (value) {
                              //reason = value;
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

/*First we find if the text overflows maxLine = 5. Only when it does
  * the show more button is visible*/

}
