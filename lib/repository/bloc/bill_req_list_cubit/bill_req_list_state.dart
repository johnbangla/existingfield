part of 'bill_req_list_cubit.dart';

abstract class BillReqListState extends Equatable {
  const BillReqListState();

  @override
    List<Object> get props => [];
}

class BillReqListInitialState extends BillReqListState { }

class BillReqListLoadingState extends BillReqListState { }

class BillReqListLoadedState extends BillReqListState {
    final BillRequest billRequest;

    BillReqListLoadedState(this.billRequest);

    @override
    List<Object> get props => [billRequest];
}

class BillDownloadLoadedState extends BillReqListState {
    final BillDownloadInfo billDownloadInfo;

    BillDownloadLoadedState(this.billDownloadInfo);

    @override
    List<Object> get props => [billDownloadInfo];
}

class BillReqListErrorState extends BillReqListState {
    final error;

    BillReqListErrorState(this.error);

    @override
    List<Object> get props => [error];
}
