import 'package:flutter/material.dart';

abstract class Languages {
  static Languages? of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  String get appName;

  String get labelWelcome;

  String get labelInfo;

  String get labelChangeLanguage;

  String get labelSelectLanguage;

  String get login;

  String get home;

  String get profile;

  String get changePassword;

  String get logout;

  String get userHint;

  String get password;

  String get forgotPassword;

  String get buttonNext;

  String get otpTextMobile;

  String get otpTextEmail;

  String get digitInfo;

  String get submitButton;

  String get fieldVisit;

  String get apply;

  String get myRequest;

  String get approvalRequest;

  String get applyList;

  String get saveButton;

  String get visitStart;

  String get visitEnd;

  String get time;

  String get date;

  String get fromPlace;

  String get toPlace;

  String get visitReason;

  String get transportType;

  String get myRequestListTitle;

  String get myRequestDetailsTitle;

  String get approvalListTitle;

  String get approvalListDetail;

  String get approve;

  String get reject;

  String get cancel;

  String get userIdEmptyValidation;

  String get passwordValidation;

  String get otpValidation;

  String get startEndDateValidationText;

  String get startEndTimeValidationText;

  String get fromPlaceToPlaceValidationText;

  String get reasonValidationText;

  String get transportValidationText;

  String get dateRangeValidationText;

  String get update;

  String get dialogHeader;

  String get logOutText;

  String get deleteText;

  String get yes;

  String get no;

  String get noDataFound;

  String get noFieldVisitText;

  String get loadingText;

  String get loginValidationText;

  String get internetErrorText;

  String get somethingWrongText;

  String get sameTimeValidation;

  String get oldPassText;

  String get newPassText;

  String get confirmPassText;

  String get oldPassEmptyValidation;

  String get newPassEmptyValidation;

  String get confirmPassEmptyValidation;

  String get fiveDigitValidation;

  String get passwordMatchValidation;

  String get acceptedListHeaderText;

  String get submitBillText;

  String get editBillText;

  String get downloadBillText;

  String get billText;

  String get billDetailsText;

  String get transportByText;

  String get transportText;

  String get breakfastText;

  String get lunchText;

  String get dinnerText;

  String get hotelText;

  String get dailyAlncText;

  String get specialAlncText;

  String get previousText;

  String get nextText;

  String get transportTypeValidationText;

  String get buttonLogin;

  String get loginIntroText;

  String get verificationCode;

  String get recoverCodeMessage;

  String get tryDifferentMobileNumber;

  String get forgotPassHeading;

  String get wrongOtpValidationText;

  String get resetPassword;

  String get resetPasswordInstructionText;

  String get planSubmit;

  String get fromBranch;

  String get toBranch;

  String get fromOther;

  String get toOther;

  String get plan;

  String get applyInfo;

  String get billInfo;

  String get transportFare;

  String get morning;

  String get afternoon;

  String get night;

  String get hotel;

  String get dailyAllowance;

  String get specialAllowance;

  String get myPlan;

  String get networkError;

  String get planDetails;

  String get addFieldVisit;

  String get planApprovalList;

  String get viewDetails;

  String get language;

  String get myHome;

  String get myProfile;


}
