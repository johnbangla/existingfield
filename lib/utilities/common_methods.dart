import 'dart:ui';
import 'package:buro_employee/sessionmanager/session_manager.dart';
import 'package:buro_employee/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'asset_paths.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:google_fonts/google_fonts.dart';

class CommonMethods {
  static void showMessage(BuildContext context, String message, Color color) {

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
      ),
      backgroundColor: color,
    ));
  }

  static Future<String> getSelectedLang() async {
    return await sessionManager.selectedLang;
  }

  static Future<bool> getLoginStatus() async {
    return await sessionManager.isLoggedIn;
  }

  static Widget topBanner(double width) {
    /*return Container(
      //height: 350.0,
      decoration: new BoxDecoration(
        color: ColorResources.APP_THEME_COLOR,
        borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(
              width, )),
      ),
      child: Center(child: SvgPicture.asset(
          assetsPath.BURO_WHITE_ICON


      ),),

    );*/

    return ClipPath(
      clipper: OvalBottomBorderClipper(),
      child: Container(
        height: 350.0,
        color: ColorResources.APP_THEME_COLOR,
        child: Center(
          child: SvgPicture.asset(assetsPath.BURO_WHITE_ICON),
        ),
      ),
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

  static Widget getStatus(String activityName) {
    switch (activityName) {
      case "Pending":
        return Container(
          decoration: BoxDecoration(
            color: ColorResources.PENDING_COLOR,
            borderRadius: BorderRadius.all(Radius.circular(
              6,
            )),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 13, right: 13, top: 5, bottom: 5),
            child: Text('${activityName}',
                style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                    color: ColorResources.BLACK)),
          ),
        );
      case "Approved":
        return Container(
          decoration: BoxDecoration(
            color: ColorResources.APPROVE_COLOR,
            borderRadius: BorderRadius.all(Radius.circular(
              6,
            )),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 13, right: 13, top: 5, bottom: 5),
            child: Text(
              '${activityName}',
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              softWrap: false,
              style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  color: ColorResources.WHITE),
            ),
          ),
        );
      case "Rejected":
        return Container(
          decoration: BoxDecoration(
            color: ColorResources.REJECT_COLOR,
            borderRadius: BorderRadius.all(Radius.circular(
              6,
            )),
          ),
          child: Padding(
            padding:
                const EdgeInsets.only(left: 13, right: 13, top: 5, bottom: 5),
            child: Text(
              '${activityName}',
              style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  color: ColorResources.WHITE),
            ),
          ),
        );

      case "Partially Approved":
        return Container(
          decoration: BoxDecoration(
            color: ColorResources.PARTIALLY_APPROVE_COLOR,
            borderRadius: BorderRadius.all(Radius.circular(
              6,
            )),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 13, right: 13, top: 5, bottom: 5),
            child: Text(
              'Partially...',
              maxLines: 2,
              textAlign: TextAlign.start,
              style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  color: ColorResources.WHITE),
            ),
          ),
        );
      default:
        {
          print("Invalid choice");
        }
        return Container();
        break;
    }
  }
}
