part of 'request_cubit.dart';

abstract class RequestState extends Equatable {
  const RequestState();

  @override
    List<Object> get props => [];
}

class RequestInitialState extends RequestState { }

class RequestLoadingState extends RequestState { }
class CancelRequestLoadingState extends RequestState { }
class CancelAllRequestLoadingState extends RequestState { }

class RequestLoadedState extends RequestState {
    final MyRequest requestList;

    RequestLoadedState(this.requestList);

    @override
    List<Object> get props => [requestList];
}

class CancelAllLoadedState extends RequestState {
    final RequestCancelAll requestCancelAll;

    CancelAllLoadedState(this.requestCancelAll);

    @override
    List<Object> get props => [requestCancelAll];
}



class RequestErrorState extends RequestState {
    final error;

    RequestErrorState(this.error);

    @override
    List<Object> get props => [error];
}
