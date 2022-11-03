import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:buro_employee/theme/colors.dart';

class Styles{

  static var dateDecoration = InputDecoration(
    filled: true,
    fillColor: Color.fromRGBO(0, 0, 0, 0.1),
    border: OutlineInputBorder(),
    hintText: 'Date',

    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.only(topLeft: Radius.circular(8),bottomLeft: Radius.circular(8)),
    ),
    contentPadding: EdgeInsets.only(top: 15,left: 15,bottom: 15),
    labelStyle: TextStyle(),
    hintStyle: TextStyle(color: Colors.black),
  );

  static var timeDecoration = InputDecoration(
    filled: true,
    fillColor: Color.fromRGBO(0, 0, 0, 0.1),
    border: OutlineInputBorder(),
    hintText: 'Time',
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(25),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.only(topRight: Radius.circular(8),bottomRight: Radius.circular(8)),
    ),
    contentPadding: EdgeInsets.only(top: 15,left: 15,bottom: 15),
    labelStyle: TextStyle(),
    hintStyle: TextStyle(color: Colors.black),
  );
 static var endDateDecoration = InputDecoration(
    filled: true,
    fillColor: Color.fromRGBO(0, 0, 0, 0.1),
    border: OutlineInputBorder(),
    hintText: 'Date',
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.circular(25),
    ),
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.transparent),
      borderRadius: BorderRadius.only(topRight: Radius.circular(8),bottomRight: Radius.circular(8)),
    ),
    contentPadding: EdgeInsets.only(top: 15,left: 15,bottom: 15),
    labelStyle: TextStyle(),
    hintStyle: TextStyle(color: Colors.black),
  );

  static var titleStyle = GoogleFonts.roboto(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      fontStyle: FontStyle.normal);

  static var buttonTextStyle = GoogleFonts.inter(
      fontSize: 16,fontWeight: FontWeight.w500,fontStyle: FontStyle.normal,color: ColorResources.WHITE);

 // static var rejectButtonTextStyle = GoogleFonts.roboto(
  //    fontSize: 14,fontWeight: FontWeight.w600,fontStyle: FontStyle.normal,color: Colors.red);

  static var approveButtonTextStyle = GoogleFonts.roboto(
      fontSize: 14,fontWeight: FontWeight.w600,fontStyle: FontStyle.normal,color: Colors.green);

  static var mediumTextStyle = GoogleFonts.roboto(
      fontSize: 14,fontWeight: FontWeight.w400,fontStyle: FontStyle.normal);

  static var listHeaderTextStyle = GoogleFonts.inter(
      fontSize: 14,fontWeight: FontWeight.w700,fontStyle: FontStyle.normal,color: ColorResources.GREY_NINETY);

  static var drawerItemStyle = GoogleFonts.roboto(fontWeight: FontWeight.w400,
      fontSize: 14,
      color: ColorResources.GREY_DARK);


  static var menuListItemStyle = GoogleFonts.inter(fontWeight: FontWeight.w700,
      fontSize: 14,
      color: ColorResources.GREY_NINETY);

   static var listButtonTextStyle = GoogleFonts.poppins(fontWeight: FontWeight.w600,
      fontSize: 12,
      color: ColorResources.GREY_NINETY);

   static var cancelButtonTextStyle = GoogleFonts.poppins(fontWeight: FontWeight.w600,
      fontSize: 12,
      color: ColorResources.CANCEL_BUTTON_TEXT_COLOR);

   static var listDescTextStyle = GoogleFonts.inter(fontWeight: FontWeight.w400,
      fontSize: 12,
      color: ColorResources.GREY_DARK_SIXTY);

    static var listDescHeadingTextStyle = GoogleFonts.inter(fontWeight: FontWeight.w600,
      fontSize: 12,
      color: ColorResources.GREY_DARK);
    static var listDescWithHeadTextStyle = GoogleFonts.inter(fontWeight: FontWeight.w400,
      fontSize: 12,
      color: ColorResources.GREY_DARK);


    static var editBillButtonTextStyle = GoogleFonts.poppins(fontWeight: FontWeight.w600,
      fontSize: 12,
      color: ColorResources.GREY_NINETY);

    static var downBillButtonTextStyle = GoogleFonts.poppins(fontWeight: FontWeight.w600,
      fontSize: 12,
      color: ColorResources.LIGHT_YELLOW);

    static var nextPrevTextStyle = GoogleFonts.poppins(fontWeight: FontWeight.w600,
      fontSize: 14,
      color: ColorResources.GREY_NINETY);

    static var approveListHeaderTextStyle = GoogleFonts.inter(fontWeight: FontWeight.w700,
      fontSize: 14,
      color: ColorResources.GREY_NINETY);
   static var approveListTextStyle = GoogleFonts.inter(fontWeight: FontWeight.w500,
      fontSize: 12,
      color: ColorResources.GREY_NINETY);


   static var acceptButtonTextStyle = GoogleFonts.poppins(fontWeight: FontWeight.w600,
      fontSize: 12,
      color: ColorResources.ACCEPT_ICON_COLOR);

   static var rejectButtonTextStyle = GoogleFonts.poppins(fontWeight: FontWeight.w600,
      fontSize: 12,
      color: ColorResources.CANCEL_BUTTON_TEXT_COLOR);


  static var appBarTextStyle = GoogleFonts.poppins(
      fontSize: 16,fontWeight: FontWeight.w700,
      fontStyle: FontStyle.normal,
      color: ColorResources.WHITE);

  static var hintTextStyle = GoogleFonts.inter(
      fontSize: 14,fontWeight: FontWeight.w400,fontStyle: FontStyle.normal,color: ColorResources.GREY_SEVENTY);



  static var activeTextColor = GoogleFonts.dmSans(
      fontSize: 13,fontWeight: FontWeight.w700,fontStyle: FontStyle.normal,color: ColorResources.WHITE);
   static var inactiveTextColor = GoogleFonts.dmSans(
      fontSize: 13,fontWeight: FontWeight.w700,fontStyle: FontStyle.normal,color: ColorResources.GREY_EIGHTY);




}