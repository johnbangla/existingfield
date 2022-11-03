part of 'apply_cubit.dart';

abstract class ApplyState extends Equatable {
  const ApplyState();

  @override
    List<Object> get props => [];
}

abstract class DropdownState extends Equatable {
  const DropdownState();

  @override
  NameIDModel? get ghhgh => null;
}



class ApplyInitialState extends ApplyState { }

class ApplyLoadingState extends ApplyState { }

class ApplyLoadedState extends ApplyState {
    final ApprovedPlan approvedPlan;

    ApplyLoadedState(this.approvedPlan);

    @override
    List<Object> get props => [approvedPlan];
}



class ApplyErrorState extends ApplyState {
    final error;

    ApplyErrorState(this.error);

    @override
    List<Object> get props => [error];
}



class DropDownBlocState  {
  final String dropdownValue;

  const DropDownBlocState({
    required this.dropdownValue, required String counterValue,
  });
//const BillBlocState();


}
