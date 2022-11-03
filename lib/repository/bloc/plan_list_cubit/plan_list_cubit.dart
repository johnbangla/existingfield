import 'package:bloc/bloc.dart';
import 'package:buro_employee/repository/models/my_plan.dart';
import 'package:buro_employee/repository/models/request_cancel.dart';
import 'package:buro_employee/repository/models/request_cancel_all.dart';
import 'package:buro_employee/repository/network/buro_repository.dart';
import 'package:equatable/equatable.dart';

part 'plan_list_state.dart';

class PlanListCubit extends Cubit<PlanListState> {


  BuroRepository repository;

  PlanListCubit(this.repository) : super(PlanListInitialState());
  Future<MyPlan?> getPlanList() async {
    emit(PlanListInitialState());


    try {
      emit(PlanListLoadingState());
      var response = await repository.getMyPlan();
      emit(PlanListLoadedState(response));
      return response;


    } catch (e) {
      emit(PlanListErrorState(e));
    }
  }



  Future<RequestCancel?> cancelPlanRequestAll(int planId) async {
    try {
      //emit(CancelRequestLoadingState());
      var response = await repository.cancelPlanRequestAll(planId);
      //emit(CancelAllLoadedState(response));
      return response;


    } catch (e) {
      //emit(RequestErrorState(e));
    }
  }


}
