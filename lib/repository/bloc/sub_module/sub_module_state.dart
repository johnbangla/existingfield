part of 'sub_module_cubit.dart';

abstract class SubModuleState extends Equatable {
  const SubModuleState();

  @override
    List<Object> get props => [];
}

class SubModuleInitialState extends SubModuleState { }

class SubModuleLoadingState extends SubModuleState { }

class SubModuleLoadedState extends SubModuleState {
    final SubModule subModule;

    SubModuleLoadedState(this.subModule);

    @override
    List<Object> get props => [subModule];
}

class SubModuleErrorState extends SubModuleState {
    final error;

    SubModuleErrorState(this.error);

    @override
    List<Object> get props => [error];
}
