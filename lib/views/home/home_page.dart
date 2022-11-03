import 'package:buro_employee/repository/bloc/home_cubit/home_cubit.dart';
import 'package:buro_employee/repository/bloc/module/module_cubit.dart';
import 'package:buro_employee/sessionmanager/session_manager.dart';
import 'package:buro_employee/theme/colors.dart';
import 'package:buro_employee/theme/styles.dart';
import 'package:buro_employee/utilities/analytics.dart';
import 'package:buro_employee/utilities/asset_paths.dart';
import 'package:buro_employee/utilities/common_methods.dart';
import 'package:flutter/material.dart';
import '../field_visit/field_visit_main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  static route() => MaterialPageRoute(builder: (_) => HomeScreen());

  @override
  State<StatefulWidget> createState() => _HomePageSate();
}

class _HomePageSate extends State<HomeScreen> {
  var selectedLang;
  var imageList = [
    assetsPath.FIELD_VISIT_MODULE_ICON,
    assetsPath.APPLY_LEAVE_ICON,
    assetsPath.CALENDER_ICON,
    assetsPath.COLLECTION_SUMMERY_ICON
  ];

  @override
  void initState() {
    CommonMethods.getSelectedLang().then((value) => {
          selectedLang = value, /*print('selected Lang Home $selectedLang')*/
        });

    final bloc = context.read<HomeCubit>();
    bloc.getHomeData();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    analytics.setCurrentScreen('Home Page', 'StatefulWidget');

    super.didChangeDependencies();
  }

  Future<String> getSelectedLang() async {
    return await sessionManager.selectedLang;
  }

  @override
  Widget build(BuildContext context) {
    //print(object);

    return Builder(
      builder: (context) {
        return BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {},
          buildWhen: (previous, current) => previous != current,
          builder: (context, state) {
            if (state is HomeInitialState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is HomeLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is HomeLoadedState) {
              var moduleList = state.module.data.moduleAccess;
              return moduleList.isNotEmpty
                  ? Container(
                      child: RefreshIndicator(
                      onRefresh: refresh,
                      child: GridView.count(
                        crossAxisSpacing: 00,
                        mainAxisSpacing: 00,
                        crossAxisCount: 2,
                        shrinkWrap: true,

                        children: List.generate(moduleList.length, (index) {
                          return Center(
                            child: Container(
                              /*shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),

                              ),*/
                              // elevation: 15,
                              decoration: BoxDecoration(
                                color: ColorResources.WHITE,
                                border: Border.all(
                                    color: ColorResources.LIST_BORDER_WHITE,
                                    width: 1),
                                borderRadius: BorderRadius.all(Radius.circular(
                                  10,
                                )),
                              ),
                              margin: const EdgeInsets.all(0),

                              child: InkWell(
                                  splashColor: Colors.blue.withAlpha(20),
                                  onTap: () {
                                    var currentModuleId = state.module.data
                                        .moduleAccess[index].moduleId;
                                    if (currentModuleId == 1) {
                                      sessionManager
                                          .setSubmoduleId(currentModuleId);
                                      Navigator.pushNamed(
                                          context, FieldVisitMain.routeName);
                                    } else if (currentModuleId == 2) {
                                      CommonMethods.showMessage(context,
                                          'Under Development', Colors.red);
                                      /* Navigator.pushNamed(
                                          context, BillSubmit.routeName); */

                                    } else if (currentModuleId == 3) {
                                      /* Navigator.pushNamed(
                                          context, CreateRole.routeName);*/

                                      CommonMethods.showMessage(context,
                                          'Under Development', Colors.red);
                                    }
                                  },
                                  child: Container(
                                      height: 129,
                                      width: 155,
                                      child: Column(
                                        children: [
                                          Flexible(
                                            flex: 6,
                                            child: Container(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SvgPicture.asset(
                                                    imageList[index],
                                                    height: 50,
                                                    width: 50,
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      selectedLang == 'bn'
                                                          ? '${moduleList[index].moduleNameBn}'
                                                          : '${moduleList[index].moduleNameEn}',
                                                      style: Styles
                                                          .mediumTextStyle,
                                                      textAlign:
                                                          TextAlign.center,
                                                      softWrap: true,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                              flex: 1,
                                              child: /*Divider(
                                                height: 1,
                                                thickness: 1,
                                                color: ColorResources
                                                    .APP_THEME_COLOR,
                                              )*/

                                            Padding(
                                              padding: const EdgeInsets.only(left: 10,right: 10),
                                              child: Container(
                                                height: 4,
                                                decoration: BoxDecoration(
                                                  color: getColor(index),
                                                  borderRadius: BorderRadius.all(Radius.circular(
                                                    10,
                                                  )),
                                                ),

                                              ),
                                            )
                                          )
                                        ],
                                      ))),
                            ),
                          );
                        }),
                        physics: const AlwaysScrollableScrollPhysics(),
                      ),
                    ))
                  : Center(
                      child: Text('You Have no Module to access!'),
                    );
            } else if (state is ModuleErrorState) {
              return RefreshIndicator(
                onRefresh: refresh,
                child: Center(
                  child: Container(
                    child: Text('Network Error hhbn'),
                  ),
                ),
              );
            } else {
              return RefreshIndicator(
                onRefresh: refresh,
                child: Center(
                  child: Container(
                    child: Text(' Error'),
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }

   Color getColor(int index){


    switch(index){
      case 0:
       return ColorResources.APP_THEME_COLOR;
        break;
      case 1:
        return ColorResources.LIGHT_YELLOW;
        break;
      case 2:
        return ColorResources.APP_THEME_COLOR;
        break;
      case 3:
        return ColorResources.LIGHT_YELLOW;
        break;

      default:{
        return ColorResources.APP_THEME_COLOR;
      }

    }


  }

  Future refresh() {
    return Future.delayed(
      Duration(seconds: 1),
      () {
        final bloc = context.read<ModuleCubit>();
        bloc.getModule();
        //initState();
        /// adding elements in list after [1 seconds] delay
        /// to mimic network call
        ///
        /// Remember: [setState] is necessary so that
        /// build method will run again otherwise
        /// list will not show all elements

        // showing snackbar
        // CommonMethods.showMessage(context, "Refreshed", Colors.green);
      },
    );
  }
}
