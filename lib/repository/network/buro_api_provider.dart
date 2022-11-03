import 'package:buro_employee/repository/database/database_handler.dart';
import 'package:buro_employee/repository/models/ApprovedPlan.dart';
import 'package:buro_employee/repository/models/apply_submit.dart';
import 'package:buro_employee/repository/models/approval_action.dart';
import 'package:buro_employee/repository/models/approval_request.dart';
import 'package:buro_employee/repository/models/approval_request_details.dart';
import 'package:buro_employee/repository/models/bill_download_info.dart';
import 'package:buro_employee/repository/models/bill_request.dart';
import 'package:buro_employee/repository/models/bill_request_details.dart';
import 'package:buro_employee/repository/models/bill_submit_model.dart';
import 'package:buro_employee/repository/models/branch.dart';
import 'package:buro_employee/repository/models/change_pass_model.dart';
import 'package:buro_employee/repository/models/generate_otp.dart';
import 'package:buro_employee/repository/models/login_user.dart';
import 'package:buro_employee/repository/models/module.dart';
import 'package:buro_employee/repository/models/my_plan.dart';
import 'package:buro_employee/repository/models/my_request.dart';
import 'package:buro_employee/repository/models/my_request_details.dart';
import 'package:buro_employee/repository/models/plan_approval_details_model.dart';
import 'package:buro_employee/repository/models/plan_approval_request.dart';
import 'package:buro_employee/repository/models/plan_detail_model.dart';
import 'package:buro_employee/repository/models/request_cancel.dart';
import 'package:buro_employee/repository/models/request_cancel_all.dart';
import 'package:buro_employee/repository/models/sub_module.dart';
import 'package:buro_employee/repository/models/verify_otp.dart';
import 'package:buro_employee/sessionmanager/session_manager.dart';
import 'package:buro_employee/shared/logic/http/api.dart';
import 'package:buro_employee/utilities/environments.dart';
import 'package:buro_employee/views/field_visit/planApprovalRequst/plan_approval_details.dart';
import 'package:buro_employee/views/field_visit/planApprovalRequst/plan_approval_list.dart';
import 'package:dio/dio.dart';

export 'package:dio/dio.dart';
import 'dart:convert';
import 'package:dio_logging_interceptor/dio_logging_interceptor.dart';

class BuroApiProvider {
  Dio networkConfigWithAuth(String username, String password) {
    var dio = Dio();
    dio.options.contentType = Headers.formUrlEncodedContentType;
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));

    dio.options = BaseOptions(headers: <String, String>{
      'authorization': basicAuth,
      //'Content-Type': 'application/json'
    }, baseUrl: environments.base_url, receiveDataWhenStatusError: true);

    /*dio.interceptors.add(  // For Print API RESPONSE IN LOG
      DioLoggingInterceptor(
        level: Level.body,
        compact: false,
      ),
    );*/
    return dio;
  }

  Dio networkConfigWithHeader(String key, String value) {
    var dio = Dio();

    dio.options = BaseOptions(headers: <String, String>{
      key: value,
    }, baseUrl: environments.base_url, receiveDataWhenStatusError: true);

    /* dio.interceptors.add(
      DioLoggingInterceptor(
        level: Level.body,
        compact: false,
      ),
    );*/
    return dio;
  }

  Dio networkConfigAuthNHeader(
      String headerKey, String headerValue, String username, String password) {
    var dio = Dio();

    dio.options.contentType = Headers.formUrlEncodedContentType;
    String basicAuth =
        'Basic ' + base64Encode(utf8.encode('$username:$password'));
    print("USer NAme $username Password $password");

    dio.options = BaseOptions(headers: <String, String>{
      'authorization': basicAuth,
      headerKey: headerValue,
    }, baseUrl: environments.base_url, receiveDataWhenStatusError: true);

    dio.interceptors.add(
      DioLoggingInterceptor(
        level: Level.body,
        compact: false,
      ),
    );
    return dio;
  }

  Future<LoginUser> authenticate(String username, String password) async {
    final response = await networkConfigWithAuth(username, password).post(
      environments.login_url,
      data: {
        "loginid": username,
        "pwd": password,
      },
    );

    final loginUser = LoginUser.fromJson(response.data);

    return loginUser;
  }

  Future<VerifyOtp> verifyOtp(String mobileOtp, String emailOtp) async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;
    final response = await networkConfigWithAuth(user, password).post(
      environments.verify_otp_url,
      data: {
        "mobileOtp": mobileOtp,
        "emailOtp": emailOtp,
      },
    );

    final verifyOtp = VerifyOtp.fromJson(response.data);

    return verifyOtp;
  }

  Future<Module> getModule() async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;
    var module;
    try {
      final response = await networkConfigWithAuth(user, password).get(
        environments.module_url,
      );

      //print('RESPONSE ${response.data}');

      module = Module.fromJson(response.data);
    } on Exception catch (e) {
      print('Module Error state $e');
    }

    return module;
  }

  Future<SubModule> getSubModule(String moduleId) async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;
    var submodule;
    try {
      final response = await networkConfigWithAuth(user, password).get(
        '${environments.sub_module_url}$moduleId',
      );

      submodule = SubModule.fromJson(response.data);
    } on Exception catch (e) {
      print('Exception $e');
    }

    return submodule;
  }

  Future<MyRequest> getMyRequest() async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;
    var requestList;
    try {
      final response = await networkConfigWithAuth(user, password).get(
        environments.request_url,
      );

      //print('RESPONSE ${response.data}');

      requestList = MyRequest.fromJson(response.data);
    } on Exception catch (e) {
      print('Exception $e');
    }

    return requestList;
  }

  Future<MyRequestDetails> getRequestDetails(int applicationId) async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;

    var requestDetailsList;
    try {
      final response = await networkConfigWithAuth(user, password).post(
        environments.request_details_url,
        data: {"applicationID": applicationId},
        //options: Options(contentType: 'multipart/form-data')
      );

      //print('RESPONSE Request Details ${response.data}');

      requestDetailsList = MyRequestDetails.fromJson(response.data);
    } on Exception catch (e) {
      print('Exception $e');
    }

    return requestDetailsList;
  }

  Future<RequestCancel> requestCancel(
      int appDetailsId, int applicationId) async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;

    var requestCancel;
    try {
      final response = await networkConfigWithAuth(user, password).put(
        environments.request_cancel_single_url,
        data: {
          "appDetailsID": appDetailsId,
          "applicationID": applicationId,
        },
      );

      requestCancel = RequestCancel.fromJson(response.data);
    } on Exception catch (e) {
      print('Exception $e');
    }

    return requestCancel;
  }

  Future<RequestCancelAll> requestCancelAll(int applicationId) async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;

    var requestCancelAll;
    try {
      final response = await networkConfigWithAuth(user, password).put(
        environments.request_cancel_all_url,
        data: {
          "applicationID": applicationId,
        },
      );

      requestCancelAll = RequestCancelAll.fromJson(response.data);
    } on Exception catch (e) {
      print('Exception $e');
    }

    return requestCancelAll;
  }

  Future<ApprovalRequest> getApprovalRequest() async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;
    var requestList;
    try {
      final response = await networkConfigWithAuth(user, password).get(
        environments.approval_request_url,
      );

      //print('RESPONSE ${response.data}');

      requestList = ApprovalRequest.fromJson(response.data);
    } on Exception catch (e) {
      print('Exception $e');
    }

    return requestList;
  }

  Future<ApprovalRequestDetails> getApprovalDetails(int applicationId) async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;
    var requestDetailList;
    try {
      final response = await networkConfigWithAuth(user, password).post(
        environments.approval_detail_url,
        data: {"applicationID": applicationId},
      );

      //print('RESPONSE ${response.data}');

      requestDetailList = ApprovalRequestDetails.fromJson(response.data);
    } on Exception catch (e) {
      print('Exception $e');
    }

    return requestDetailList;
  }

  Future<ApprovalAction> approvalAction(
      int appDetailsId, int applicationId, String actionType) async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;

    var actionResponse;
    try {
      final response = await networkConfigWithAuth(user, password).put(
        environments.approval_action_single_url,
        data: {
          "appDetailsID": appDetailsId,
          "applicationID": applicationId,
          "ApprovalStatus": actionType
        },
      );

      actionResponse = ApprovalAction.fromJson(response.data);
    } on Exception catch (e) {
      print('Exception $e');
    }

    return actionResponse;
  }

  Future<ApprovalAction> approvalActionAll(
      int applicationId, String actionType) async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;

    var approvalActionResponse;
    try {
      final response = await networkConfigWithAuth(user, password).put(
        environments.approval_action_all_url,
        data: {"applicationID": applicationId, "ApprovalStatus": actionType},
      );

      approvalActionResponse = ApprovalAction.fromJson(response.data);
    } on Exception catch (e) {
      print('Exception $e');
    }

    return approvalActionResponse;
  }

  Future<ApplySubmit> submitApplyList(List applyList, int planId) async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;

    var submitResponse;
    try {
      final response = await networkConfigWithAuth(user, password)
          .post('${environments.submit_apply_url}/$planId', data: applyList);

      submitResponse = ApplySubmit.fromJson(response.data);
    } on Exception catch (e) {
      print('Exception $e');
    }

    return submitResponse;
  }

  Future<ChangePasswordModel> changePassword(bool isForgetPass, String oldPass,
      String newPass, String confirmPass) async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;

    var response;
    try {
      final getResponse = await networkConfigWithAuth(user, password).post(
        environments.change_pass_url,
        data: {
          "loginID": user,
          "oldPassword": oldPass,
          "newPassword": newPass,
          "confirmPassword": confirmPass
        },
      );

      response = ChangePasswordModel.fromJson(getResponse.data);
    } on Exception catch (e) {
      print('Exception $e');
    }

    return response;
  }

  Future<Branch> getAllBranch() async {
    var db = DataBaseHandler();
    var user = await sessionManager.userID;
    var password = await sessionManager.password;
    late Branch branchList;
    try {
      final response = await networkConfigWithAuth(user, password).get(
        environments.branch_list_url,
      );

      branchList = Branch.fromJson(response.data);

      var count = 0;
      //print('RESPONSE Branch List Size ${branchList.data!.length}');

      branchList.data!.forEach((element) {
        count++;
        //print('Loaded Branch Item Code ${element.branchCode} Name ${element.branchName}');
        var item = Item(element.branchCode!, element.branchName!);
        addBranchItem(item);
      });

      print('Count $count');
    } on Exception catch (e) {
      print('Exception $e');
    }

    return branchList;
  }

  Future<GenerateOTP> getOtp(String userId) async {
    final response = await networkConfigWithHeader(
            'BUROBD-GP_OTP', 'WgIvOJvZIdiXjiLgQa0wDaLit7WZuif4lksL9y')
        .post(
      environments.otp_url,
      data: {
        "loginid": userId,
      },
    );

    final data = GenerateOTP.fromJson(response.data);

    return data;
  }

  Future<void> addBranchItem(Item item) async {
    var handler = DataBaseHandler();
    var result;
    var count;
    handler.initializeDBBranch().whenComplete(() async => {
          result = await handler.insertBranchItem(item),
          //print('Insert Branch Item result $result')
          /* setState(() {
        print('Result $result');
      }),*/
        });
  }

  Future<VerifyOtp> verifyOtpResetPass(
      String mobileOtp, String emailOtp) async {
    // This method used for submit OTP verify at forgot password

    var user = await sessionManager.userID;
    var otp = mobileOtp.isEmpty ? emailOtp : mobileOtp;

    //print('User $user Otp $otp');

    final response =
        await networkConfigAuthNHeader('isForgotPassword', 'true', user, otp)
            .post(
      environments.verify_otp_url,
      data: {
        'mobileOtp': mobileOtp,
        "emailclsOtp": emailOtp,
      },
    );

    print('Response ${response.data}');
    final verifyOtp = VerifyOtp.fromJson(response.data);

    return verifyOtp;
  }

  Future<BillRequest> getBillRequest() async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;
    var requestList;
    try {
      final response = await networkConfigWithAuth(user, password).get(
        environments.bill_req_list,
      );

      //print('RESPONSE ${response.data}');

      requestList = BillRequest.fromJson(response.data);
    } on Exception catch (e) {
      print('Exception $e');
    }

    return requestList;
  }

  Future<ChangePasswordModel> resetPassword(
      String oldPass, String newPass, String confirmPass) async {
    var user = await sessionManager.userID;

    var response;
    try {
      final getResponse = await networkConfigAuthNHeader(
              'isForgotPassword', 'true', user, oldPass)
          .post(
        environments.change_pass_url,
        data: {
          "oldPassword": oldPass,
          "newPassword": newPass,
          "confirmPassword": confirmPass
        },
      );

      response = ChangePasswordModel.fromJson(getResponse.data);
    } on Exception catch (e) {
      print('Exception $e');
    }

    return response;
  }

  Future<BillRequestDetails> getBillDetails(int applicationId) async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;
    var requestDetails;
    try {
      final response = await networkConfigWithAuth(user, password).post(
        environments.bill_req_details,
        data: {
          "applicationID": applicationId,
        },
      );

      //print('RESPONSE ${response.data}');

      requestDetails = BillRequestDetails.fromJson(response.data);
    } on Exception catch (e) {
      print('Exception $e');
    }

    return requestDetails;
  }

  Future<BillSubmitModel> billSubmit(List list) async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;
    var requestDetails;

    //print('Map list $list ');
    try {
      final response = await networkConfigWithAuth(user, password)
          .post(environments.bill_submit, data: list);

      requestDetails = BillSubmitModel.fromJson(response.data);
    } on Exception catch (e) {
      print('Exception $e');
    }

    return requestDetails;
  }

  Future<BillDownloadInfo> getBillDownloadInfo(int applicationId) async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;
    var billDetails;

    //print('Map list $list ');
    try {
      final response = await networkConfigWithAuth(user, password).post(
        environments.bill_download_info,
        data: {
          "reportType": "pdf/ word/ excel",
          "applicationID": applicationId
        },
      );

      billDetails = BillDownloadInfo.fromJson(response.data);

      //print('Bill Details $billDetails');

    } on Exception catch (e) {
      print('Exception $e');
    }

    return billDetails;
  }

  Future<PlanApprovalRequest> getPlanApproval() async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;
    var planList;
    try {
      final response = await networkConfigWithAuth(user, password).get(
        environments.plan_approval_list,
      );

      //print('RESPONSE ${response.data}');

      planList = PlanApprovalRequest.fromJson(response.data);
    } on Exception catch (e) {
      print('Exception $e');
    }

    return planList;
  }

  Future<PlanDetailModel> getPlanDetail(int planId) async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;
    var planDetail;
    try {
      final response = await networkConfigWithAuth(user, password).get(
        '${environments.plan_detail_url}$planId',
      );

      //print('RESPONSE ${response.data}');

      planDetail = PlanDetailModel.fromJson(response.data);
    } on Exception catch (e) {
      print('Exception $e');
    }

    return planDetail;
  }

  Future<PlanApprovalDetailsModel> getPlanApprovalDetail(int planId) async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;
    var planApprovalDetail;
    try {
      final response = await networkConfigWithAuth(user, password).get(
        '${environments.plan_approval_details}$planId',
      );

      //print('RESPONSE ${response.data}');

      planApprovalDetail = PlanApprovalDetailsModel.fromJson(response.data);
    } on Exception catch (e) {
      print('Exception $e');
    }

    return planApprovalDetail;
  }

  Future<RequestCancel> cancelPlanReqIndividual(int planId) async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;

    var requestCancel;
    try {
      final response = await networkConfigWithAuth(user, password).put(
        '${environments.plan_cancel_individual}$planId',
      );

      requestCancel = RequestCancel.fromJson(response.data);
    } on Exception catch (e) {
      print('Exception $e');
    }

    return requestCancel;
  }

  Future<RequestCancel> cancelPlanRequestAll(int planId) async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;

    var requestCancelAll;
    try {
      final response = await networkConfigWithAuth(user, password).put(
        '${environments.plan_cancel_all}$planId',
      );

      requestCancelAll = RequestCancel.fromJson(response.data);
    } on Exception catch (e) {
      print('Exception $e');
    }

    return requestCancelAll;
  }

  Future<ApprovalAction> planApprovalActionAll(
      // Plan action from list
      int planID,
      String actionType) async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;

    var actionResponse;
    try {
      final response = await networkConfigWithAuth(user, password).put(
          environments.plan_action_all,
          data: {"PlanID": planID, "ActivityName": actionType});

      actionResponse = ApprovalAction.fromJson(response.data);
    } on Exception catch (e) {
      print('Exception $e');
    }

    return actionResponse;
  }

  Future<ApprovalAction> planApprovalActionIndividual(
      // Plan action from details
      int planDetailsID,
      int planID,
      String actionType) async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;

    var approvalActionResponse;
    try {
      final response = await networkConfigWithAuth(user, password).put(
        environments.plan_action_individual,
        data: {
          "PlanDetailsID": planDetailsID,
          "PlanID": planID,
          "ActivityName": actionType
        },
      );

      approvalActionResponse = ApprovalAction.fromJson(response.data);
    } on Exception catch (e) {
      print('Exception $e');
    }

    return approvalActionResponse;
  }

  Future<MyPlan> getMyPlan() async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;
    var planList;
    try {
      final response = await networkConfigWithAuth(user, password).get(
        environments.plan_list_url,
      );

      //print('RESPONSE ${response.data}');

      planList = MyPlan.fromJson(response.data);
    } on Exception catch (e) {
      print('Exception $e');
    }

    return planList;
  }

  Future<ApplySubmit> submitPlan(var data) async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;

    var submitResponse;
    try {
      final response = await networkConfigWithAuth(user, password)
          .post(environments.plan_submit, data: data);

      submitResponse = ApplySubmit.fromJson(response.data);
    } on Exception catch (e) {
      print('Exception $e');
    }

    return submitResponse;
  }

  Future<ApprovedPlan> getApprovedPlan() async {
    var user = await sessionManager.userID;
    var password = await sessionManager.password;
    var planList;
    try {
      final response = await networkConfigWithAuth(user, password).get(
        environments.approved_plan_list,
      );

      //print('RESPONSE ${response.data}');

      planList = ApprovedPlan.fromJson(response.data);
    } on Exception catch (e) {
      print('Exception $e');
    }

    return planList;
  }
}
