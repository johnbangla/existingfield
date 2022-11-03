part of 'bill_details_cubit.dart';

abstract class BillDetailsState extends Equatable {
  const BillDetailsState();

  @override
    List<Object> get props => [];
}

class BillDetailsInitialState extends BillDetailsState { }

class BillDetailsLoadingState extends BillDetailsState { }

class BillDetailsLoadedState extends BillDetailsState {
    final BillRequestDetails billRequestDetails;

    BillDetailsLoadedState(this.billRequestDetails);

    @override
    List<Object> get props => [billRequestDetails];
}

class BillSubmitLoadedState extends BillDetailsState {
    final BillSubmitModel billSubmitResponse;

    BillSubmitLoadedState(this.billSubmitResponse);

    @override
    List<Object> get props => [billSubmitResponse];
}

class BillDetailsErrorState extends BillDetailsState {
    final error;

    BillDetailsErrorState(this.error);

    @override
    List<Object> get props => [error];
}
