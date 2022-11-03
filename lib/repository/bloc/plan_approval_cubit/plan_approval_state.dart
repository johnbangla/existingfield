part of 'plan_approval_cubit.dart';

abstract class PlanApprovalState extends Equatable {
  const PlanApprovalState();

  @override
    List<Object> get props => [];
}

class PlanApprovalInitialState extends PlanApprovalState { }

class PlanApprovalLoadingState extends PlanApprovalState { }

class PlanApprovalLoadedState extends PlanApprovalState {
    final PlanApprovalRequest planApprovalRequest;

    PlanApprovalLoadedState(this.planApprovalRequest);

    @override
    List<Object> get props => [planApprovalRequest];
}

class PlanApprovalErrorState extends PlanApprovalState {
    final error;

    PlanApprovalErrorState(this.error);

    @override
    List<Object> get props => [error];
}



