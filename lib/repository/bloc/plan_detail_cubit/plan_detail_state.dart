part of 'plan_detail_cubit.dart';

abstract class PlanDetailState extends Equatable {
  const PlanDetailState();

  @override
    List<Object> get props => [];
}

class PlanDetailInitialState extends PlanDetailState { }

class PlanDetailLoadingState extends PlanDetailState { }

class PlanDetailLoadedState extends PlanDetailState {
    final PlanDetailModel planDetail;

    PlanDetailLoadedState(this.planDetail);

    @override
    List<Object> get props => [planDetail];
}

class PlanDetailErrorState extends PlanDetailState {
    final error;

    PlanDetailErrorState(this.error);

    @override
    List<Object> get props => [error];
}
