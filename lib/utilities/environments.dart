class _Environments {

  //final base_url = 'http://192.168.1.14'; //for BURO H/O network

  final base_url = 'http://123.200.2.189'; // when doing work at home , out of BURO network like mobile data, home wifi
  //http://192.168.1.14/burobd
  //final base_url_new = '';

  final login_url = '/burobd/api/User/LoginUser';
  final verify_otp_url = '/burobd/api/User/OTPSubmit';
  final module_url = '/burobd/api/Home/GetModulePermission';
  final sub_module_url = '/burobd/api/Home/GetModuleUIPermission/';
  final request_url = '/burobd/api/FieldVisit/MyRequestList';
  final request_details_url = '/burobd/api/FieldVisit/MyRequestDetails';
  final request_cancel_single_url = '/burobd/api/FieldVisit/MyRequestCancel';
  final request_cancel_all_url = '/burobd/api/FieldVisit/MyRequestCancelAll';
  final approval_request_url = '/burobd/api/FieldVisit/ApprovalRequestList';
  final approval_detail_url = '/burobd/api/FieldVisit/ApprovalRequestLDetails';
  final approval_action_single_url =
      '/burobd/api/FieldVisit/ApprovalListDetailsAction';
  final approval_action_all_url = '/burobd/api/FieldVisit/ApprovalListAction';
  final submit_apply_url = '/burobd/api/FieldVisit/ApplicationSubmit/';
  final change_pass_url = '/burobd/api/User/ChangePassword';
  final branch_list_url = '/burobd/api/BasicData/BranchList';

  final otp_url =
      '/burobd_Gen/api/User/OTP_Generate'; //'/burobd_Gen/api/User/OTP_Generate'
  final submit_otp_url =
      '/burobd/api/User/OTPSubmit'; // this url is used for submit otp at forgot password

  //bill and Report
  final bill_req_list = '/burobd/api/FieldVisitBill/MyRequestList';
  final bill_req_details = '/burobd/api/FieldVisitBill/MyRequestDetails';
  final bill_submit = '/burobd/api/FieldVisitBill/ApplicationSubmit';
  final bill_download_info =
      '/burobd/api/Report_FieldVisit/BillDownload'; // this Url is Used for download bill Info

  //plan
  final plan_list_url = '/burobd/api/FieldVisit/MyPlanList';
  final plan_approval_list = '/burobd/api/FieldVisit/ApprovalPlanList';
  final plan_detail_url = '/burobd/api/FieldVisit/MyPlanDetails/';
  final plan_approval_details = '/burobd/api/FieldVisit/ApprovalPlanDetails/';
  final plan_cancel_all = '/burobd/api/FieldVisit/PlanCancelAll/';
  final plan_cancel_individual = '/burobd/api/FieldVisit/PlanDetailsCancel/';
  final plan_action_all = '/burobd/api/FieldVisit/ApprovalPlanAction';
  final plan_action_individual =
      '/burobd/api/FieldVisit/ApprovalPlanDetailsAction';
  final plan_submit = '/burobd/api/FieldVisit/PlanSubmit';
  final approved_plan_list = '/burobd/api/FieldVisit/ApprovedPlanList';
}

_Environments environments = _Environments();
