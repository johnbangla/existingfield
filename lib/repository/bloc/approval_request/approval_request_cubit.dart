import 'package:bloc/bloc.dart';
import 'package:buro_employee/repository/models/approval_action.dart';
import 'package:buro_employee/repository/models/approval_request.dart';
import 'package:equatable/equatable.dart';

import '../../network/buro_repository.dart';

part 'approval_request_state.dart';

class ApprovalRequestCubit extends Cubit<ApprovalRequestState> {

  BuroRepository repository;

  //RequestCubit(this.repository) : super(RequestInitialState());

  ApprovalRequestCubit(this.repository) : super(ApprovalRequestInitialState());

  Future<ApprovalRequest?> getApprovalList() async {
    emit(ApprovalRequestInitialState());


    try {
      emit(ApprovalRequestLoadingState());
      var response = await repository.getApprovalRequest();
      emit(ApprovalRequestLoadedState(response));
      return response;


    } catch (e) {
      emit(ApprovalRequestErrorState(e));
    }
  }


  Future<ApprovalRequest?> cancelApproval() async {
    emit(ApprovalRequestInitialState());


    try {
      emit(ApprovalRequestLoadingState());
      var response = await repository.getApprovalRequest();
      emit(ApprovalRequestLoadedState(response));
      return response;


    } catch (e) {
      emit(ApprovalRequestErrorState(e));
    }
  }

  Future<ApprovalAction?> approvalActionAll(int applicationId,String actionType) async {
    try {
      //emit(CancelRequestLoadingState());
      var response = await repository.approvalActionAll(applicationId,actionType);
      //emit(CancelAllLoadedState(response));
      return response;


    } catch (e) {
      //emit(RequestErrorState(e));
    }
  }


}
