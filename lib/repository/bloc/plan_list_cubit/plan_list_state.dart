part of 'plan_list_cubit.dart';

abstract class PlanListState extends Equatable {
  const PlanListState();

  @override
    List<Object> get props => [];
}

class PlanListInitialState extends PlanListState { }

class PlanListLoadingState extends PlanListState { }

class PlanListLoadedState extends PlanListState {
    final MyPlan planList;

    PlanListLoadedState(this.planList);

    @override
    List<Object> get props => [planList];
}

class PlanListErrorState extends PlanListState {
    final error;

    PlanListErrorState(this.error);

    @override
    List<Object> get props => [error];
}
