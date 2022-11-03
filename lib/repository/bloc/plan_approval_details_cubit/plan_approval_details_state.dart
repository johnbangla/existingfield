part of 'plan_approval_details_cubit.dart';

abstract class PlanApprovalDetailsState extends Equatable {
  const PlanApprovalDetailsState();

  @override
    List<Object> get props => [];
}

class PlanApprovalDetailsInitialState extends PlanApprovalDetailsState { }

class PlanApprovalDetailsLoadingState extends PlanApprovalDetailsState { }

class PlanApprovalDetailsLoadedState extends PlanApprovalDetailsState {
    final PlanApprovalDetailsModel planApprovalDetailsModel;

    PlanApprovalDetailsLoadedState(this.planApprovalDetailsModel);

    @override
    List<Object> get props => [planApprovalDetailsModel];
}

class PlanApprovalDetailsErrorState extends PlanApprovalDetailsState {
    final error;

    PlanApprovalDetailsErrorState(this.error);

    @override
    List<Object> get props => [error];
}



class PlanApprovalActionInitialState extends PlanApprovalDetailsState { }

class PlanApprovalActionLoadingState extends PlanApprovalDetailsState { }

class PlanApprovalActionLoadedState extends PlanApprovalDetailsState {

  final ApprovalAction approvalAction;

  PlanApprovalActionLoadedState(this.approvalAction);

  @override
  List<Object> get props => [approvalAction];


}

class PlanApprovalActionErrorState extends PlanApprovalDetailsState {
  /*final error;

  PlanApprovalErrorState(this.error);

  @override
  List<Object> get props => [error];*/
}
