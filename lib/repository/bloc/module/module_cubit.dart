import 'package:bloc/bloc.dart';
import 'package:buro_employee/repository/models/module.dart';
import 'package:buro_employee/sessionmanager/session_manager.dart';
import 'package:equatable/equatable.dart';

import '../../network/buro_repository.dart';

part 'module_state.dart';

class ModuleCubit extends Cubit<ModuleState> {

  final BuroRepository repository;
  ModuleCubit(this.repository) : super(ModuleInitial());
  Future<Module?> getModule() async {
    emit(ModuleInitial());
    try {
      emit(ModuleLoading());
      var response = await repository.getModule();
      emit(ModuleLoaded(response!));
      return response;


    } catch (e) {
      print('11111111 ModuleErrorState ${e.toString()}');
      emit(ModuleErrorState(e));
    }
  }

  void getLanguage() async{

  }




}
