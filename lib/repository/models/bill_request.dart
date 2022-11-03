class BillRequest {
 late bool _success;
 late String _messageEn;
 late String _messageBn;
late  List<Data> _data = [];

  BillRequest(
      {required bool success, required String messageEn, required String messageBn, required List<Data> data}) {
    this._success = success;
    this._messageEn = messageEn;
    this._messageBn = messageBn;
    this._data = data;
  }

  bool get success => _success;
  set success(bool success) => _success = success;
  String get messageEn => _messageEn;
  set messageEn(String messageEn) => _messageEn = messageEn;
  String get messageBn => _messageBn;
  set messageBn(String messageBn) => _messageBn = messageBn;
  List<Data> get data => _data;
  set data(List<Data> data) => _data = data;

  BillRequest.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _messageEn = json['messageEn'];
    _messageBn = json['messageBn'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this._success;
    data['messageEn'] = this._messageEn;
    data['messageBn'] = this._messageBn;
    if (this._data != null) {
      data['data'] = this._data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
 late int _applicationID;
 late String _startDate;
  late String _endDate;
 late String _places;
 late String _requestHolder;
 late String _approvalStatus;
  late bool _ableToCancel;
  late String _billSubmitStatus;

  Data(
      {required int applicationID,
        required String startDate,
        required String endDate,
        required String places,
        required String requestHolder,
        required String approvalStatus,
        required bool ableToCancel,required String billSubmitStatus}) {
    this._applicationID = applicationID;
    this._startDate = startDate;
    this._endDate = endDate;
    this._places = places;
    this._requestHolder = requestHolder;
    this._approvalStatus = approvalStatus;
    this._billSubmitStatus = billSubmitStatus;
  }

  int get applicationID => _applicationID;
  set applicationID(int applicationID) => _applicationID = applicationID;
  String get startDate => _startDate;
  set startDate(String startDate) => _startDate = startDate;
  String get endDate => _endDate;
  set endDate(String endDate) => _endDate = endDate;
  String get places => _places;
  set places(String places) => _places = places;
  String get requestHolder => _requestHolder;
  set requestHolder(String requestHolder) => _requestHolder = requestHolder;
  String get approvalStatus => _approvalStatus;
  set approvalStatus(String approvalStatus) => _approvalStatus = approvalStatus;
  bool get ableToCancel => _ableToCancel;
  set ableToCancel(bool ableToCancel) => _ableToCancel = ableToCancel;

 String get billSubmitStatus => _billSubmitStatus;
 set billSubmitStatus(String requestHolder) => _billSubmitStatus = requestHolder;


 Data.fromJson(Map<String, dynamic> json) {
    _applicationID = json['applicationID'];
    _startDate = json['startDate'];
    _endDate = json['endDate'];
    _places = json['places'];
    _requestHolder = json['requestHolder'];
    _approvalStatus = json['approvalStatus'];
    _ableToCancel = json['ableToCancel'];
    _billSubmitStatus = json['billSubmitStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['applicationID'] = this._applicationID;
    data['startDate'] = this._startDate;
    data['endDate'] = this._endDate;
    data['places'] = this._places;
    data['requestHolder'] = this._requestHolder;
    data['approvalStatus'] = this._approvalStatus;
    data['ableToCancel'] = this._ableToCancel;
    data['billSubmitStatus'] = this._billSubmitStatus;
    return data;
  }
}

