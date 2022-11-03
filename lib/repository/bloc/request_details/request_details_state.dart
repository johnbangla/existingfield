part of 'request_details_cubit.dart';

abstract class RequestDetailsState extends Equatable {
  const RequestDetailsState();

  @override
    List<Object> get props => [];
}

class RequestDetailsInitialState extends RequestDetailsState { }

class RequestDetailsLoadingState extends RequestDetailsState { }

class CancelRequestLoadingState extends RequestDetailsState { }
class RequestDetailsLoadedState extends RequestDetailsState {
    final MyRequestDetails requestDetails;

    RequestDetailsLoadedState(this.requestDetails);

    @override
    List<Object> get props => [requestDetails];
}

class RequestDetailsErrorState extends RequestDetailsState {
    final error;

    RequestDetailsErrorState(this.error);

    @override
    List<Object> get props => [error];
}

class RequestCancelLoadedState extends RequestDetailsState {
  final RequestCancel requestCancel;

  RequestCancelLoadedState(this.requestCancel);

  @override
  List<Object> get props => [requestCancel];
}
