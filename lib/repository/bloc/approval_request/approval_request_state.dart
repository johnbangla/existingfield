part of 'approval_request_cubit.dart';

abstract class ApprovalRequestState extends Equatable {
  const ApprovalRequestState();

  @override
    List<Object> get props => [];
}

class ApprovalRequestInitialState extends ApprovalRequestState { }

class ApprovalRequestLoadingState extends ApprovalRequestState { }

class ApprovalRequestLoadedState extends ApprovalRequestState {
    final ApprovalRequest approvalRequest;

    ApprovalRequestLoadedState(this.approvalRequest);

    @override
    List<Object> get props => [approvalRequest];
}

class ApprovalRequestErrorState extends ApprovalRequestState {
    final error;

    ApprovalRequestErrorState(this.error);

    @override
    List<Object> get props => [error];
}
