part of 'approval_details_cubit.dart';

abstract class ApprovalDetailsState extends Equatable {
  const ApprovalDetailsState();

  @override
    List<Object> get props => [];
}

class ApprovalDetailsInitialState extends ApprovalDetailsState { }

class ApprovalDetailsLoadingState extends ApprovalDetailsState { }

class ApprovalDetailsLoadedState extends ApprovalDetailsState {
    final ApprovalRequestDetails approvalRequestDetails;

    ApprovalDetailsLoadedState(this.approvalRequestDetails);

    @override
    List<Object> get props => [approvalRequestDetails];
}

class ApprovalDetailsErrorState extends ApprovalDetailsState {
    final error;

    ApprovalDetailsErrorState(this.error);

    @override
    List<Object> get props => [error];
}
