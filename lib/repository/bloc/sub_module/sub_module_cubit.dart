import 'package:bloc/bloc.dart';
import 'package:buro_employee/repository/models/sub_module.dart';
import 'package:equatable/equatable.dart';

import '../../network/buro_repository.dart';

part 'sub_module_state.dart';

class SubModuleCubit extends Cubit<SubModuleState> {
  final BuroRepository repository;
  SubModuleCubit(this.repository) : super(SubModuleInitialState());

  Future<SubModule?> getSubModule(String moduleId) async {
    emit(SubModuleInitialState());
    try {
      emit(SubModuleLoadingState());
      var response = await repository.getSubModule(moduleId);
      emit(SubModuleLoadedState(response));
      return response;


    } catch (e) {

      emit(SubModuleErrorState(e));
    }
  }

}
