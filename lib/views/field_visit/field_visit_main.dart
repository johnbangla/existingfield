import 'package:buro_employee/localization/Language/languages.dart';
import 'package:buro_employee/repository/bloc/sub_module/sub_module_cubit.dart';
import 'package:buro_employee/repository/database/database_handler.dart';
import 'package:buro_employee/repository/models/apply_request.dart';
import 'package:buro_employee/sessionmanager/session_manager.dart';
import 'package:buro_employee/theme/colors.dart';
import 'package:buro_employee/theme/styles.dart';
import 'package:buro_employee/utilities/analytics.dart';
import 'package:buro_employee/utilities/asset_paths.dart';
import 'package:buro_employee/utilities/common_methods.dart';
import 'package:buro_employee/views/field_visit/myPlanList/my_plan_list.dart';
import 'package:buro_employee/views/field_visit/plan/plan_submit.dart';
import 'package:buro_employee/views/field_visit/planApprovalRequst/plan_approval_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'add_bill/bill_req_list.dart';
import 'apply/apply_list.dart';
import 'apply/apply_page.dart';
import 'approvalrequest/approval_list.dart';
import 'myrequest/request_list.dart';
import '../../app.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FieldVisitMain extends StatefulWidget {
  static const routeName = '/fieldVisitMain';

  FieldVisitMain({Key? key}) : super(key: key);

  @override
  _FieldVisitMainState createState() => _FieldVisitMainState();
}

class _FieldVisitMainState extends State<FieldVisitMain> {
  var selectedLang;
  var bloc;
  var moduleId;
  late DataBaseHandler handler;
  List<ApplyRequest> list = [];
  late SessionManager sessionManager;
  var imageList = [
    assetsPath.FIELD_VISIT_ICON,
    assetsPath.MY_REQUEST_ICON,
    assetsPath.FIELD_VISIT_ICON,
    assetsPath.APPROVAL_REQUEST_ICON,
    assetsPath.MY_REQUEST_ICON,
    assetsPath.APPROVAL_REQUEST_ICON,
    assetsPath.BILL_SUBMIT_ICON
  ];

  @override
  void initState() {
    sessionManager = SessionManager();
    this.handler = DataBaseHandler();
    this.handler.applyList().then((value) => list = value);

    CommonMethods.getSelectedLang().then((value) => {
          selectedLang = value,
          print('Selecetdlang field Visit Main $selectedLang value $value')
        });

    bloc = context.read<SubModuleCubit>();
    getSelectedModuleId().then((value) =>
        {bloc.getSubModule(value.toString()), moduleId = value.toString()});

    super.initState();
  }

  @override
  void didChangeDependencies() {
    getSelectedLang().then((value) => {
          selectedLang = value /*, print('Selecetdlang $selectedLang')*/
        });

    super.didChangeDependencies();
    analytics.setCurrentScreen('Field Visit ', 'StatefulWidget');
  }

  Future<bool> _willPopCallback() async {
    await sessionManager.clearSubmoduleId();
    Navigator.pushNamedAndRemoveUntil(
        context, LandingScreen.routeName, (r) => false);

    return true;
  }

  Future refresh() {
    return Future.delayed(
      Duration(seconds: 1),
      () {
        bloc = context.read<SubModuleCubit>();
        bloc.getSubModule(moduleId);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var selectedItem;
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorResources.APP_THEME_COLOR,
          title: Center(
            child: Text(
              '${Languages.of(context)!.fieldVisit}',
              style: Styles.appBarTextStyle,
            ),
          ),
        ),
        body: BlocConsumer<SubModuleCubit, SubModuleState>(
          listener: (context, state) {
            if (state is SubModuleErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Network Error"),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            // print('Home page State ${state}');

            if (state is SubModuleInitialState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is SubModuleLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is SubModuleLoadedState) {
              var subModuleList = state.subModule.data;

              return Padding(
                padding: const EdgeInsets.only(top: 24, left: 12, right: 12),
                child: Container(
                  color: ColorResources.PAGE_BACKGROUND,
                  child: RefreshIndicator(
                    onRefresh: refresh,
                    child: ListView.builder(
                      itemCount: subModuleList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: ListTile(
                            title: Container(
                              height: 80,
                              decoration: BoxDecoration(
                                color: ColorResources.WHITE,
                                border: Border.all(
                                    color: ColorResources.LIST_BORDER_WHITE,
                                    width: 1),
                                borderRadius: BorderRadius.all(Radius.circular(
                                  10,
                                )),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    child: SvgPicture.asset(imageList[index]),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    selectedLang == 'bn'
                                        ? '${subModuleList[index].uiVisibleNameBn}'
                                        : '${subModuleList[index].uiVisibleNameEn}',
                                    style: Styles.menuListItemStyle,
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              selectedItem = subModuleList[index].subModuleId;

                              // print('Selected ITEm $selectedItem');
                              switch (selectedItem) {
                                case 1:
                                  {
                                    if (list.length != 0) {
                                      sessionManager.clearPlanId();
                                      Navigator.pushNamed(
                                          context, ApplyList.routeName);
                                    } else
                                      Navigator.pushNamed(
                                          context, Apply.routeName);
                                  }
                                  break;

                                case 2:
                                  {
                                    Navigator.pushNamed(
                                        context, RequestList.routeName);
                                  }
                                  break;
                                case 3:
                                  {
                                    Navigator.pushNamed(
                                        context, ApprovalList.routeName);
                                  }
                                  break;
                                case 6:
                                  {
                                    Navigator.pushNamed(
                                        context, BillReqList.routeName);
                                  }
                                  break;
                                case 7:
                                  {
                                    Navigator.pushNamed(
                                        context, PlanSubmit.routeName);
                                  }
                                  break;

                                case 8:
                                  {
                                    Navigator.pushNamed(
                                        context, PlanApprovalList.routeName);
                                  }
                                  break;
                                case 9:
                                  {
                                    Navigator.pushNamed(
                                        context, MyPlanList.routeName);
                                  }
                                  break;

                                default:
                                  {
                                    //statements;
                                  }
                                  break;
                              }
                            },
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            } else {
              return Center(
                child: Container(
                  child: Text('Network Error'),
                ),
              );
            }
          },
        ),
      ),
    );
  }

  Future<String> getSelectedLang() async {
    return await sessionManager.selectedLang;
  }

  Future<int> getSelectedModuleId() async {
    return await sessionManager.subModuleId;
  }
}
