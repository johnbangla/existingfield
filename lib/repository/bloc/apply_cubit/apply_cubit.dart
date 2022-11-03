import 'package:bloc/bloc.dart';
import 'package:buro_employee/repository/models/ApprovedPlan.dart';
import 'package:buro_employee/repository/network/buro_repository.dart';
import 'package:buro_employee/views/field_visit/apply/apply_page.dart';
import 'package:equatable/equatable.dart';

part 'apply_state.dart';

class DropDownCubit extends Cubit<NameIDModel?>{
  DropDownCubit(NameIDModel? initialState) : super(initialState);

 // DropDownCubit() : super();


  void setDropdownValue(NameIDModel nameIDModel){


    emit(nameIDModel);

  }




}

class ApplyCubit extends Cubit<ApplyState> {
  //ApplyCubit() : super(ApplyInitialState());

  BuroRepository repository;

  //RequestCubit(this.repository) : super(RequestInitialState());

  ApplyCubit(this.repository) : super(ApplyInitialState());

  Future<ApprovedPlan?> getApprovedList() async {
    emit(ApplyInitialState());

    try {
      emit(ApplyLoadingState());
      var response = await repository.getApprovedPlanList();
      emit(ApplyLoadedState(response));
      return response;
    } catch (e) {
      emit(ApplyErrorState(e));
    }
  }






}


enum DropDownEvent { increment, decrement }

/*
class DropDownCubit extends Bloc<DropDownEvent,DropDownBlocState> {



 // DropDownCubit() : super(DropDownBlocState(dropdownValue: ''));


  //BillBlocCubit() : super(BillBlocInitialState());


 */
/* @override
  Stream<DropDownBlocState> mapEventToState() async* {

        yield DropDownBlocState(counterValue: dropd);


  }*//*

}

*/

