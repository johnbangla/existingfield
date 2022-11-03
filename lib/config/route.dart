import 'package:buro_employee/app.dart';
import 'package:buro_employee/repository/models/ApprovalRequestInfo.dart';
import 'package:buro_employee/repository/models/apply_request.dart';
import 'package:buro_employee/repository/models/generate_otp.dart';
import 'package:buro_employee/repository/models/login_user.dart';
import 'package:buro_employee/views/admin_panel/create_role.dart';
import 'package:buro_employee/views/admin_panel/create_user.dart';
import 'package:buro_employee/views/field_visit/add_bill/bill_req_list.dart';
import 'package:buro_employee/views/field_visit/add_bill/bill_submit.dart';
import 'package:buro_employee/views/field_visit/apply/apply_list.dart';
import 'package:buro_employee/views/field_visit/apply/apply_page.dart';
import 'package:buro_employee/views/field_visit/approvalrequest/approval_details.dart';
import 'package:buro_employee/views/field_visit/approvalrequest/approval_list.dart';
import 'package:buro_employee/views/field_visit/field_visit_main.dart';
import 'package:buro_employee/views/field_visit/myPlanList/my_plan_detail.dart';
import 'package:buro_employee/views/field_visit/myPlanList/my_plan_list.dart';
import 'package:buro_employee/views/field_visit/myrequest/request_details.dart';
import 'package:buro_employee/views/field_visit/myrequest/request_list.dart';
import 'package:buro_employee/views/field_visit/plan/plan_submit.dart';
import 'package:buro_employee/views/field_visit/planApprovalRequst/plan_approval_details.dart';
import 'package:buro_employee/views/field_visit/planApprovalRequst/plan_approval_list.dart';
import 'package:buro_employee/views/home/home_page.dart';
import 'package:buro_employee/views/login/forget_password.dart';
import 'package:buro_employee/views/login/login_screen.dart';
import 'package:buro_employee/views/login/forgotpass_verification.dart';
import 'package:buro_employee/views/login/login_verification.dart';
import 'package:buro_employee/views/login/reset_password.dart';
import 'package:buro_employee/views/login/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppRouter {
  Route? onGenerateRoute(RouteSettings routeSettings) {
    print("routeSettings ${routeSettings.name} ${routeSettings.arguments}");

    switch (routeSettings.name) {
      case HomeScreen.routeName:
        return HomeScreen.route();
      case LoginScreen.routeName:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case SplashScreen.routeName:
        return SplashScreen.route();
      case LoginVerification.routeName:
        {
          if (routeSettings.arguments != null)
            return MaterialPageRoute(
                builder: (_) =>
                    LoginVerification(routeSettings.arguments as LoginUser));
          else
            break;
        }

      case LandingScreen.routeName:
        {
          return MaterialPageRoute(
              builder: (_) => LandingScreen(
                    title: '',
                  ));
        }

      case FieldVisitMain.routeName:
        {
          return MaterialPageRoute(builder: (_) => FieldVisitMain());
        }

      case Apply.routeName:
        {
          if (routeSettings.arguments != null)
            return MaterialPageRoute(
                builder: (_) => Apply(routeSettings.arguments as ApplyRequest));
          else
            return MaterialPageRoute(builder: (_) => Apply());
        }

      case ApplyList.routeName:
        return ApplyList.route();

      case ApprovalList.routeName:
        return ApprovalList.route();

      case ApprovalDetails.routeName:
        {
          if (routeSettings.arguments != null)
            return MaterialPageRoute(
                builder: (_) => ApprovalDetails(
                    routeSettings.arguments as ApprovalRequestInfo));
          else
            break;
        }

      case RequestList.routeName:
        return RequestList.route();

      case RequestDetails.routeName:
        {
          if (routeSettings.arguments != null)
            return MaterialPageRoute(
                builder: (_) => RequestDetails(routeSettings.arguments as int));
          else
            break;
        }
      case BillSubmit.routeName:
        {
          {
            if (routeSettings.arguments != null)
              return MaterialPageRoute(
                  builder: (_) => BillSubmit(routeSettings.arguments as int));
            else
              break;
          }
        }

      case CreateRole.routeName:
        return CreateRole.route();

      case CreateUser.routeName:
        return CreateUser.route();

      case BillReqList.routeName:
        return BillReqList.route();

      case ForgotPassVerification.routeName:
        {
          if (routeSettings.arguments != null)
            return MaterialPageRoute(
                builder: (_) => ForgotPassVerification(
                    routeSettings.arguments as GenerateOTP));
          else
            break;
        }

      case ResetPassword.routeName:
        {
          if (routeSettings.arguments != null)
            return MaterialPageRoute(
                builder: (_) =>
                    ResetPassword(routeSettings.arguments as String));
          else
            //return ResetPassword.route();
            break;
        }

      case PlanSubmit.routeName:
        return PlanSubmit.route();

      case PlanApprovalList.routeName:
        return PlanApprovalList.route();

      case MyPlanList.routeName:
        return MyPlanList.route();

      case MyPlanDetail.routeName:
        {
          if (routeSettings.arguments != null)
            return MaterialPageRoute(
                builder: (_) => MyPlanDetail(routeSettings.arguments as int));
          else
            break;
        }

        case PlanApprovalDetails.routeName:
        {
          if (routeSettings.arguments != null)
            return MaterialPageRoute(
                builder: (_) => PlanApprovalDetails(routeSettings.arguments as ApprovalRequestInfo));
          else
            break;
        }

      case '/forgetPasswordNew':{

        print('In Switch case');
        return ForgetPassword.routensj();

       // return MaterialPageRoute(builder: (_)=> ForgetPassword());
        break;
      }



      default:
        return SplashScreen.route();
    }
  }
}
