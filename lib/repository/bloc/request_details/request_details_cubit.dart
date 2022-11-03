import 'package:bloc/bloc.dart';
import 'package:buro_employee/repository/models/my_request_details.dart';
import 'package:buro_employee/repository/models/request_cancel.dart';
import 'package:equatable/equatable.dart';

import '../../network/buro_repository.dart';

part 'request_details_state.dart';

class RequestDetailsCubit extends Cubit<RequestDetailsState> {
  BuroRepository repository;

  RequestDetailsCubit(this.repository) : super(RequestDetailsInitialState());

  Future<MyRequestDetails?> getRequestDetails(int requestId) async {
    emit(RequestDetailsInitialState());

    try {
      emit(RequestDetailsInitialState());
      var response = await repository.getRequestDetail(requestId);
      emit(RequestDetailsLoadedState(response));
      return response;
    } catch (e) {
      emit(RequestDetailsErrorState(e));
    }
  }

  Future<RequestCancel?> requestCancel(int appDetailsId,int applicationId) async {
    try {
      //emit(CancelRequestLoadingState());
      var response = await repository.cancelRequest(appDetailsId,applicationId);
      //emit(RequestCancelLoadedState(response));
      return response;


    } catch (e) {
      //emit(RequestDetailsErrorState(e));
    }
  }
}
