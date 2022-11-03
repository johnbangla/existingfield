part of 'module_cubit.dart';

abstract class ModuleState extends Equatable {
  const ModuleState();

  @override
    List<Object> get props => [];
}

class ModuleInitial extends ModuleState { }

class ModuleLoading extends ModuleState { }

class ModuleLoaded extends ModuleState {
    final Module module;

    ModuleLoaded(this.module);

    @override
    List<Object> get props => [module];
}

class ModuleErrorState extends ModuleState {
    final error;

    ModuleErrorState(this.error);

    @override
    List<Object> get props => [error];
}


