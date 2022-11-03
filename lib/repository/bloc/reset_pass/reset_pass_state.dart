part of 'reset_pass_cubit.dart';

abstract class ResetPassState extends Equatable {
  const ResetPassState();

  @override
    List<Object> get props => [];
}

class ResetPassInitialState extends ResetPassState { }

class ResetPassLoadingState extends ResetPassState { }

class ResetPassLoadedState extends ResetPassState {
    final data;

    ResetPassLoadedState(this.data);

    @override
    List<Object> get props => [data];
}

class ResetPassErrorState extends ResetPassState {
    final error;

    ResetPassErrorState(this.error);

    @override
    List<Object> get props => [error];
}
