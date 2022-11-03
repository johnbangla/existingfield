import 'package:bloc/bloc.dart';
import 'package:buro_employee/repository/models/module.dart';
import 'package:buro_employee/repository/network/buro_repository.dart';
import 'package:equatable/equatable.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {

  final BuroRepository repository;

  HomeCubit(this.repository) : super(HomeInitialState());



  Future<Module?> getHomeData() async {
    emit(HomeInitialState());
    try {
      emit(HomeLoadingState());
      var response = await repository.getModule();
      emit(HomeLoadedState(response!));
      return response;


    } catch (e) {
      print('Home ModuleErrorState ${e.toString()}');
      emit(HomeErrorState(e));
    }
  }


}
