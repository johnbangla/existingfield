import 'package:buro_employee/localization/Language/languages.dart';
import 'package:buro_employee/repository/bloc/bill_req_list_cubit/bill_req_list_cubit.dart';
import 'package:buro_employee/repository/models/bill_download_info.dart';
import 'package:buro_employee/theme/colors.dart';
import 'package:buro_employee/theme/styles.dart';
import 'package:buro_employee/utilities/common_methods.dart';
import 'package:buro_employee/views/field_visit/field_visit_main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:number_to_words/number_to_words.dart';
import 'package:android_path_provider/android_path_provider.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'bill_submit.dart';

class BillReqList extends StatefulWidget {
  static const routeName = '/acceptedRequestList';

  //const BillSubmit({Key? key}) : super(key: key);
  static route() => MaterialPageRoute(builder: (_) => BillReqList());

  @override
  _BillReqListState createState() => _BillReqListState();
}

class _BillReqListState extends State<BillReqList> {
  late BillReqListCubit bloc;
  var selectedLang;
  var source;
  var downloadStatus = false;
  late ByteData imageData;

  @override
  void initState() {
    CommonMethods.getSelectedLang().then(
        (value) => {selectedLang = value, print('Selecetdlang $selectedLang')});

    rootBundle
        .load('assets/buro_louncher_icon.png')
        .then((data) => setState(() => this.imageData = data));
    bloc = context.read<BillReqListCubit>();
    bloc.getBillReqList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: ColorResources.APP_THEME_COLOR,
            title: Center(
                child: Text(
              Languages.of(context)!.acceptedListHeaderText,
              style: Styles.appBarTextStyle,
            )),
          ),
          body: BlocConsumer<BillReqListCubit, BillReqListState>(
            listener: (context, state) {
              if (state is BillReqListErrorState) {
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
              if (state is BillReqListInitialState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is BillReqListLoadingState) {
                return Center(child: CircularProgressIndicator());
              } else if (state is BillReqListLoadedState) {
                var billreqList = state.billRequest.data;
                return billreqList.isNotEmpty
                    ? RefreshIndicator(
                        onRefresh: refresh,
                        child: ListView.builder(
                            shrinkWrap: true,
                            itemCount: billreqList.length,
                            itemBuilder: (context, index) {
                              var item = billreqList[index];
                              String formattedStartDate =
                                  DateFormat.yMMMMd('en_US')
                                      .format(DateTime.parse(item.startDate));
                              String formattedEndDate =
                                  DateFormat.yMMMMd('en_US')
                                      .format(DateTime.parse(item.endDate));
                              return Padding(
                                padding: const EdgeInsets.only(
                                    left: 25, right: 25, top: 20, bottom: 20),
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
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16.0,
                                        right: 16,
                                        top: 14,
                                        bottom: 16),
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
                                                              8.0),
                                                      child: Align(
                                                        alignment: Alignment
                                                            .centerLeft,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Column(
                                                              children: [
                                                                Text(
                                                                  '$formattedStartDate to $formattedEndDate',
                                                                  style: Styles
                                                                      .listHeaderTextStyle,
                                                                )
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                  Icons.place,
                                                                  size: 18,
                                                                  color: ColorResources
                                                                      .GREY_DARK_SIXTY,
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Expanded(
                                                                  child: Text(
                                                                      '${item.places} ',overflow: TextOverflow.ellipsis,
                                                                      maxLines: 1,
                                                                      softWrap: false,),
                                                                ),
                                                              ],
                                                            ),
                                                            SizedBox(
                                                              height: 10,
                                                            ),
                                                            Row(
                                                              children: [
                                                                Icon(
                                                                  Icons
                                                                      .watch_later_outlined,
                                                                  size: 18,
                                                                  color: ColorResources
                                                                      .GREY_DARK_SIXTY,
                                                                ),
                                                                SizedBox(
                                                                  width: 10,
                                                                ),
                                                                Text(
                                                                  'Status : ${item.approvalStatus}',
                                                                  style: Styles
                                                                      .mediumTextStyle,
                                                                )
                                                              ],
                                                            )

                                                            /*    Row(
                                                              mainAxisAlignment:
                                                              MainAxisAlignment.start,
                                                              children: [
                                                                Text(
                                                                    'Status:  ',
                                                                    textAlign: TextAlign.end,
                                                                    style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w400, fontStyle: FontStyle.normal, color: ColorResources.GREY_SIXTY)),
                                                                SizedBox(
                                                                  width:
                                                                  5,
                                                                ),
                                                                CommonMethods.getStatus(
                                                                    item.approvalStatus)
                                                              ],
                                                            ),*/
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
                                        Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10,
                                                            right: 10,
                                                            left: 10),
                                                    child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        elevation: 0,
                                                        primary: ColorResources
                                                            .GREY_THIRTY,
                                                        // minimumSize: const Size.fromHeight(50), // NEW
                                                      ),
                                                      onPressed: () {
                                                        Navigator.pushNamed(
                                                            context,
                                                            BillSubmit
                                                                .routeName,
                                                            arguments: item
                                                                .applicationID);
                                                      },
                                                      child: Container(
                                                        height: 42,
                                                        child: Center(
                                                          child: Text(
                                                            Languages.of(
                                                                    context)!
                                                                .editBillText,
                                                            style: Styles
                                                                .editBillButtonTextStyle,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  flex: 1,
                                                ),
                                                Expanded(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 10, right: 10),
                                                    child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        elevation: 0,
                                                        primary: ColorResources
                                                            .DOWNLOAD_BUTTON_COLOR,
                                                        // minimumSize: const Size.fromHeight(50), // NEW
                                                      ),
                                                      onPressed: () {
                                                        showLoaderDialog(
                                                            context);
                                                        bloc
                                                            .getBillDownloadInfo(
                                                                item
                                                                    .applicationID)
                                                            .then((value) =>
                                                                    generateBill(
                                                                        value!)
                                                                //print(value)

                                                                );
                                                      },
                                                      child: Container(
                                                        height: 42,
                                                        child: Center(
                                                          child: Text(
                                                            Languages.of(
                                                                    context)!
                                                                .downloadBillText,
                                                            style: Styles
                                                                .downBillButtonTextStyle,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  flex: 1,
                                                ),
                                              ],
                                            ),
                                          ],
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

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Downloading...")),
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

  Future<bool> _willPopCallback() async {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => FieldVisitMain()));
    return true;
  }

  Future refresh() {
    return Future.delayed(
      Duration(seconds: 1),
      () {
        bloc = context.read<BillReqListCubit>();
        bloc.getBillReqList();
      },
    );
  }

  Future<void> generateBill(BillDownloadInfo info) async {
    final PdfDocument document = PdfDocument();
    //Set the page size
    document.pageSettings.size = PdfPageSize.a4;
    //Change the page orientation to landscape
    document.pageSettings.orientation = PdfPageOrientation.landscape;

    final PdfBitmap image = PdfBitmap(imageData.buffer.asUint8List());
    final PdfPage page = document.pages.add();
    final Size pageSize = page.getClientSize();


    // Another Footer---------------

    var now = DateTime.now();
    var formatterDate = DateFormat('dd-MM-yy');
    var formatterTime = DateFormat('kk:mm');
    String actualDate = formatterDate.format(now);
    String actualTime = formatterTime.format(now);



    String footerContent2 =
    '''Developed By : BURO Bangladesh ICT-Department ''';
    String footerContent1 =
    '''Print Date : ${actualDate.toString()} ${actualTime.toString()} ''';


    //Create a PDF page template and add footer content.
    final PdfPageTemplateElement footerTemplate =
    PdfPageTemplateElement(const Rect.fromLTWH(0, 0, 515, 50));
    final PdfPageTemplateElement footerTemplate2 =
    PdfPageTemplateElement(const Rect.fromLTWH(0, 0, 515, 50));
//Draw text in the footer.
    footerTemplate.graphics.drawString(
        'Submitted By', PdfStandardFont(PdfFontFamily.helvetica, 7,style: PdfFontStyle.bold),
        bounds: const Rect.fromLTWH(30, 15, 200, 20));
   footerTemplate.graphics.drawString(
        'Supervised By', PdfStandardFont(PdfFontFamily.helvetica, 7,style: PdfFontStyle.bold),
        bounds: const Rect.fromLTWH(160, 15, 200, 20));
   footerTemplate.graphics.drawString(
        'Checked By', PdfStandardFont(PdfFontFamily.helvetica, 7,style: PdfFontStyle.bold),
        bounds: const Rect.fromLTWH(290, 15, 200, 20));
   footerTemplate.graphics.drawString(
        'Approved By', PdfStandardFont(PdfFontFamily.helvetica, 7,style: PdfFontStyle.bold),
        bounds: const Rect.fromLTWH(430, 15, 200, 20));
    footerTemplate.graphics.drawString(
        footerContent1, PdfStandardFont(PdfFontFamily.helvetica, 5),
        bounds: const Rect.fromLTWH(0, 40, 200, 20));

    footerTemplate.graphics.drawString(
        footerContent2, PdfStandardFont(PdfFontFamily.helvetica,5,style: PdfFontStyle.bold ),
        bounds: const Rect.fromLTWH(160, 40, 200, 20));



    //Create the page number field
    PdfPageNumberField pageNumber = PdfPageNumberField(
        font: PdfStandardFont(PdfFontFamily.timesRoman, 19),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)));

//Sets the number style for page number
    pageNumber.numberStyle = PdfNumberStyle.numeric;

//Create the page count field
    PdfPageCountField count = PdfPageCountField(
        font: PdfStandardFont(PdfFontFamily.timesRoman, 19),
        brush: PdfSolidBrush(PdfColor(0, 0, 0)));

//set the number style for page count
   /* count.numberStyle = PdfNumberStyle.numeric;


    //document.pages.count

    for (int i = 0; i < document.pages.count; i++)
    {

      //Draws the page number in the document.
     footerTemplate.graphics.drawString(
    '${i+1} of ${document.pages.count}', PdfStandardFont(PdfFontFamily.helvetica,5,style: PdfFontStyle.bold ),
    bounds: const Rect.fromLTWH(500, 40, 200, 20));

    }*/




    document.template.bottom = footerTemplate;

    page.graphics.drawImage(image, Rect.fromLTWH(0, 0, 70, 70));

    final PdfGrid grid = getGrid(info);
    final PdfLayoutResult result = drawHeader(page, pageSize, grid, info);
    drawGrid(page, grid, result, info);
    //drawFooter(page, pageSize);

    final List<int> bytes = document.save();
    var storage = await AndroidPathProvider.downloadsPath;

    var externalStorageDirPath = await getTemporaryDirectory();
    var path = externalStorageDirPath.path;
    //print('Path $path');
    var bytesNew = Uint8List.fromList(bytes);
    var file = File("$path/Report.pdf");
    //print ('File $file ');
    file.writeAsBytes(bytesNew);
    //file.writeAsBytes(bytes.buffer.asUint8List());
    //print("${output.path}/example.pdf");
    //print("${output.path}/new.xls");
    //await file.open();
    //document.dispose(),
    var message = await OpenFile.open("$path/Report.pdf");
    //OpenFile

    //final message = await OpenFile.open('"$path/reportnew.pdf"');
    //print("${output.path}/example.pdf");
    Navigator.pop(context);
  }

  Future<void> deleteFile(File file) async {
    try {
      if (await file.exists()) {
        print('Yes File Exist ${file.exists()}');

        file.exists().then((value) => {
              print('Is File Exist $value'),
              file.delete().whenComplete(() => {print('File Deleted')}),
            });
      } else {
        print('No File not Exist');
      }
    } catch (e) {
      print('File Error ${e.toString()}');
    }
  }

  PdfLayoutResult drawHeader(
    PdfPage page,
    Size pageSize,
    PdfGrid grid,
    BillDownloadInfo info,
  ) {
    page.graphics.drawString(
        'BURO Bangladesh', PdfStandardFont(PdfFontFamily.helvetica, 10,style: PdfFontStyle.bold),
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(350, -30, pageSize.width - 115, 90),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    page.graphics.drawString(
        'Form No - 45', PdfStandardFont(PdfFontFamily.helvetica, 6,),
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(680, -30, pageSize.width - 115, 90),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));



    page.graphics.drawString('Branch : ${info.data[0].siteCode} - ${info.data[0].siteName}',
        PdfStandardFont(PdfFontFamily.helvetica, 10),
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(330, -10, pageSize.width - 115, 90),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    page.graphics.drawString(
        'Daily Bill Form', PdfStandardFont(PdfFontFamily.helvetica, 8.5,style: PdfFontStyle.bold),
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(360, 10, pageSize.width - 115, 90),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    page.graphics.drawString('Name - ${info.data[0].employeeName}',
        PdfStandardFont(PdfFontFamily.helvetica, 10),
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(5, 90, pageSize.width - 115, 90),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    page.graphics.drawString('Pin : ${info.data[0].employeeCode}',
        PdfStandardFont(PdfFontFamily.helvetica, 10),
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(200, 90, pageSize.width - 115, 90),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    page.graphics.drawString('Designation - ${info.data[0].designationName}',
        PdfStandardFont(PdfFontFamily.helvetica, 10),
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(320, 90, pageSize.width - 115, 90),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));
    page.graphics.drawString(
        'Work Station : ${info.data[0].siteCode} - ${info.data[0].siteName}',
        PdfStandardFont(PdfFontFamily.helvetica, 10),
        brush: PdfBrushes.black,
        bounds: Rect.fromLTWH(500, 90, pageSize.width - 115, 90),
        format: PdfStringFormat(lineAlignment: PdfVerticalAlignment.middle));

    final PdfFont contentFont = PdfStandardFont(PdfFontFamily.helvetica, 5);

    final DateFormat format = DateFormat.yMMMMd('en_US');
    final String invoiceNumber =
        'Invoice Number: 2058557939\r\n\r\nDate: ${format.format(DateTime.now())}';
    final Size contentSize = contentFont.measureString(invoiceNumber);

    return PdfTextElement(font: contentFont).draw(
        page: page,
        bounds: Rect.fromLTWH(30, 120,
            pageSize.width - (contentSize.width + 30), pageSize.height - 120))!;
  }

  void drawGrid(
      PdfPage page, PdfGrid grid, PdfLayoutResult result, BillDownloadInfo) {
    Rect? totalPriceCellBounds;
    Rect? quantityCellBounds;
    //Invoke the beginCellLayout event.
    grid.beginCellLayout = (Object sender, PdfGridBeginCellLayoutArgs args) {
      final PdfGrid grid = sender as PdfGrid;
      if (args.cellIndex == grid.columns.count - 1) {
        totalPriceCellBounds = args.bounds;
      } else if (args.cellIndex == grid.columns.count - 2) {
        quantityCellBounds = args.bounds;
      }
    };

    PdfLayoutFormat format = PdfLayoutFormat(
        breakType: PdfLayoutBreakType.fitColumnsToPage,
        layoutType: PdfLayoutType.paginate);

    result = grid.draw(
        page: page, bounds: Rect.fromLTWH(0, result.bounds.bottom + 40, 0, 0),format: format)!;
  }



  PdfGrid getGrid(BillDownloadInfo info) {
    final PdfGrid grid = PdfGrid();

    grid.style = PdfGridStyle(

        cellPadding: PdfPaddings(left: 0, right: 0, top: 100, bottom: 0),
        cellSpacing:0 ,
        font: PdfStandardFont(PdfFontFamily.timesRoman, 7));//Here is the text Size

    grid.columns.add(count: 15);

    final PdfGridRow headerRow = grid.headers.add(1)[0];
    headerRow.style.textBrush = PdfBrushes.black;
    headerRow.cells[0].value = 'Date';
    headerRow.cells[0].stringFormat.alignment = PdfTextAlignment.center;

   // headerRow.cells[0].style = PdfGridCellStyle(font:  FontStyle.italic);
    headerRow.cells[1].value = 'Visit Start';
    headerRow.cells[3].value = 'Visit End';
    headerRow.cells[5].value = 'Reason';
    headerRow.cells[6].value = 'Transport';
    //headerRow.cells[7].value = 'Transport Fare';
    headerRow.cells[8].value = 'Food & Accommodation';
    headerRow.cells[12].value = 'Daily Allowance';
    headerRow.cells[13].value = 'Special Allowance';
    headerRow.cells[14].value = 'Total';

    var row = grid.rows.add();

    row.cells[1].stringFormat.alignment = PdfTextAlignment.center;
    row.cells[2].stringFormat.alignment = PdfTextAlignment.center;
    row.cells[3].stringFormat.alignment = PdfTextAlignment.center;
    row.cells[4].stringFormat.alignment = PdfTextAlignment.center;
    row.cells[6].stringFormat.alignment = PdfTextAlignment.center;
    row.cells[7].stringFormat.alignment = PdfTextAlignment.center;
    row.cells[8].stringFormat.alignment = PdfTextAlignment.center;
    row.cells[9].stringFormat.alignment = PdfTextAlignment.center;
    row.cells[10].stringFormat.alignment = PdfTextAlignment.center;
    row.cells[11].stringFormat.alignment = PdfTextAlignment.center;
    /*
    row.cells[1].stringFormat.alignment = PdfTextAlignment.center;
  */
    row.cells[1].value = 'Time';
    row.cells[2].value = 'Place';
    row.cells[3].value = 'Time';
    row.cells[4].value = 'Place';
    row.cells[6].value = 'Type';
    row.cells[7].value = 'Fare';
    row.cells[8].value = 'Morning';
    row.cells[9].value = 'Afternoon';
    row.cells[10].value = 'Night';
    row.cells[11].value = 'Hotel';

    var transportTotal = 0;
    var morningTotal = 0;
    var eveiningTotal = 0;
    var nightTital = 0;
    var hotelTotal = 0;
    var dailyTotal = 0;
    var specialTotal = 0;
    var totalTotal = 0;

    info.data.asMap().forEach((key, value) {
      var row = grid.rows.add();

      row.cells[0].stringFormat.alignment = PdfTextAlignment.center;
      row.cells[1].stringFormat.alignment = PdfTextAlignment.center;
      row.cells[2].stringFormat.alignment = PdfTextAlignment.center;
      row.cells[3].stringFormat.alignment = PdfTextAlignment.center;
      row.cells[4].stringFormat.alignment = PdfTextAlignment.center;
      row.cells[5].stringFormat.alignment = PdfTextAlignment.center;
      row.cells[6].stringFormat.alignment = PdfTextAlignment.center;
      row.cells[7].stringFormat.alignment = PdfTextAlignment.center;
      row.cells[8].stringFormat.alignment = PdfTextAlignment.center;
      row.cells[9].stringFormat.alignment = PdfTextAlignment.center;
      row.cells[10].stringFormat.alignment = PdfTextAlignment.center;
      row.cells[11].stringFormat.alignment = PdfTextAlignment.center;
      row.cells[12].stringFormat.alignment = PdfTextAlignment.center;
      row.cells[13].stringFormat.alignment = PdfTextAlignment.center;
      row.cells[14].stringFormat.alignment = PdfTextAlignment.center;

      row.cells[0].value = value.startDate;
      row.cells[1].value = value.startTimePart;
      row.cells[2].value = value.fromplace;
      row.cells[3].value = value.endTimePart;
      row.cells[4].value = value.toplace;
      row.cells[5].value = value.reason;
      row.cells[6].value = value.transportby == null ? '' : value.transportby;
      row.cells[7].value =
          value.transport > 0 ? value.transport.toString() : '';
      row.cells[8].value = value.morning > 0 ? value.morning.toString() : '';
      row.cells[9].value = value.evening > 0 ? value.evening.toString() : '';
      row.cells[10].value = value.night > 0 ? value.night.toString() : '';
      row.cells[11].value = value.hotel > 0 ? value.hotel.toString() : '';
      row.cells[12].value =
          value.dailyBill > 0 ? value.dailyBill.toString() : '';
      row.cells[13].value =
          value.specialBill > 0 ? value.specialBill.toString() : '';
      row.cells[14].value = value.total > 0 ? value.total.toString() : '';

      transportTotal += value.transport;
      morningTotal += value.morning;
      eveiningTotal += value.evening;
      nightTital += value.night;
      hotelTotal += value.hotel;
      dailyTotal += value.dailyBill;
      specialTotal += value.specialBill;
      totalTotal += value.total;
    });

    final PdfGridRow row4 = grid.rows.add();

    row4.cells[0].value = 'Total';
    row4.cells[1].value = '';
    row4.cells[2].value = '';
    row4.cells[3].value = '';
    row4.cells[4].value = '';
    row4.cells[5].value = '';
    row4.cells[6].value = '';
    row4.cells[7].value =
        transportTotal > 0 ? transportTotal.toString() : ''; // Transport Total
    row4.cells[8].value =
        morningTotal > 0 ? morningTotal.toString() : ''; //morning total
    row4.cells[9].value =
        eveiningTotal > 0 ? eveiningTotal.toString() : ''; //evening total
    row4.cells[10].value =
        nightTital > 0 ? nightTital.toString() : ''; //Night total
    row4.cells[11].value =
        hotelTotal > 0 ? hotelTotal.toString() : ''; //Hotel Total
    row4.cells[12].value =
        dailyTotal > 0 ? dailyTotal.toString() : ''; // daily Total
    row4.cells[13].value =
        specialTotal > 0 ? specialTotal.toString() : ''; //special Total
    row4.cells[14].value =
        totalTotal > 0 ? totalTotal.toString() : ''; // total total
    row4.cells[0].columnSpan = 7;


    row4.cells[1].stringFormat.alignment = PdfTextAlignment.center;
    row4.cells[2].stringFormat.alignment = PdfTextAlignment.center;
    row4.cells[3].stringFormat.alignment = PdfTextAlignment.center;
    row4.cells[4].stringFormat.alignment = PdfTextAlignment.center;
    row4.cells[5].stringFormat.alignment = PdfTextAlignment.center;
    row4.cells[6].stringFormat.alignment = PdfTextAlignment.center;
    row4.cells[7].stringFormat.alignment = PdfTextAlignment.center;
    row4.cells[8].stringFormat.alignment = PdfTextAlignment.center;
    row4.cells[9].stringFormat.alignment = PdfTextAlignment.center;
    row4.cells[10].stringFormat.alignment = PdfTextAlignment.center;
    row4.cells[11].stringFormat.alignment = PdfTextAlignment.center;
    row4.cells[12].stringFormat.alignment = PdfTextAlignment.center;
    row4.cells[13].stringFormat.alignment = PdfTextAlignment.center;
    row4.cells[14].stringFormat.alignment = PdfTextAlignment.center;

    final PdfGridRow row5 = grid.rows.add();

    var totalInwords = NumberToWord().convert('en-in', totalTotal);

    row5.cells[0].columnSpan = 15;
    row5.cells[0].stringFormat.alignment = PdfTextAlignment.left;
    row5.cells[0].value = 'In Word : $totalInwords taka only';
    headerRow.cells[1].columnSpan = 2;
    headerRow.cells[3].columnSpan = 2;
    headerRow.cells[8].columnSpan = 4;
    headerRow.cells[6].columnSpan = 2;

    grid.columns[0].width = 37;//Date
    grid.columns[1].width = 45;//Start Time
    grid.columns[3].width = 45;//End Time
    grid.columns[7].width = 35;//Transport Fare
    grid.columns[8].width = 35; //Morning
    grid.columns[9].width = 35; //Evening

    grid.columns[10].width = 25; //Night
    grid.columns[11].width = 25; //Hotel

    grid.columns[12].width = 35; // Daily Allowance
    grid.columns[13].width = 35; // Special Allowance
    grid.columns[14].width = 30; //Total

    //grid.columns[5].width = 80;
    for (int i = 0; i < headerRow.cells.count; i++) {
      headerRow.cells[i].style.cellPadding =
          PdfPaddings(bottom: 1, left: 1, right: 1, top: 1);
      headerRow.cells[i].stringFormat.alignment = PdfTextAlignment.center;
    }
    for (int i = 0; i < grid.rows.count; i++) {
      final PdfGridRow row = grid.rows[i];
      for (int j = 0; j < row.cells.count; j++) {
        final PdfGridCell cell = row.cells[j];
        if (j == 0) {
          //cell.stringFormat.alignment = PdfTextAlignment.center;
        }
        cell.style.cellPadding =
            PdfPaddings(bottom: 1, left: 1, right: 1, top: 1);
      }
    }
    return grid;
  }
}
