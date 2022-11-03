part of 'change_pass_cubit.dart';

abstract class ChangePasswordState extends Equatable {
  const ChangePasswordState();

  @override
    List<Object> get props => [];
}

class ChangePasswordInitialState extends ChangePasswordState { }

class ChangePasswordLoadingState extends ChangePasswordState { }

class ChangePasswordLoadedState extends ChangePasswordState {
    final ChangePasswordModel data;

    ChangePasswordLoadedState(this.data);


   /* final Module module;

    HomeLoadedState(this.module);*/

    @override
    List<Object> get props => [data];
}

class ChangePasswordErrorState extends ChangePasswordState {
    final error;

    ChangePasswordErrorState(this.error);

    @override
    List<Object> get props => [error];
}
