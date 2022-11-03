import 'package:bloc/bloc.dart';
import 'package:buro_employee/repository/models/bill_request_details.dart';
import 'package:buro_employee/repository/models/bill_submit_model.dart';
import 'package:buro_employee/repository/network/buro_repository.dart';
import 'package:equatable/equatable.dart';

part 'bill_details_state.dart';

class BillDetailsCubit extends Cubit<BillDetailsState> {

  final BuroRepository repository;
  BillDetailsCubit(this.repository) : super(BillDetailsInitialState());



  Future<BillRequestDetails?> getBillDetails(int applicationId) async {
    emit(BillDetailsInitialState());

    try {
      emit(BillDetailsLoadingState());
      var response = await repository.getBillRequestDetails(applicationId);
      emit(BillDetailsLoadedState(response));
      return response;
    } catch (e) {
      emit(BillDetailsErrorState(e));
    }
  }

  Future<BillSubmitModel?> billSubmit(List submitList) async {
    emit(BillDetailsInitialState());

    try {
      emit(BillDetailsLoadingState());
      var response = await repository.billSubmit(submitList);
      emit(BillSubmitLoadedState(response));
      return response;
    } catch (e) {
      emit(BillDetailsErrorState(e));
    }
  }

  void initState(){
    emit(BillDetailsInitialState());
  }



}
