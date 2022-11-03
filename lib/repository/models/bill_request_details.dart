class BillRequestDetails {
  late bool _success;
  late String _messageEn;
  late String _messageBn;
  late List<Data> _data;

  BillRequestDetails(
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

  BillRequestDetails.fromJson(Map<String, dynamic> json) {
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
  late int _appDetailsID;
  late int _applicationID;
  late String _startDate;
  late String _endDate;
  late String _fromPlace;
  late String _toPlace;
  late String _reason;
  late String? _transportBy;
  late String _approvalStatus;
  late bool _ableToCancel;
  late int _transport;
  late int _morning;
  late int _evening;
  late int _night;
  late int _hotel;
  late int _dailyBill;
  late int _specialBill;
  late int _othersBill;
  late String _titleInfo;

  Data(
      {required int appDetailsID,
        required int applicationID,
        required String startDate,
        required String endDate,
        required String fromPlace,
        required String toPlace,
        required String reason,
        required String transportBy,
        required String approvalStatus,
        required bool ableToCancel,
        required int transport,
        required int morning,
        required int evening,
        required int night,
        required int hotel,
        required int dailyBill,
        required int specialBill,
        required int othersBill,
        required String titleInfo}) {
    this._appDetailsID = appDetailsID;
    this._applicationID = applicationID;
    this._startDate = startDate;
    this._endDate = endDate;
    this._fromPlace = fromPlace;
    this._toPlace = toPlace;
    this._reason = reason;
    this._transportBy = transportBy;
    this._approvalStatus = approvalStatus;
    this._ableToCancel = ableToCancel;
    this._transport = transport;
    this._morning = morning;
    this._evening = evening;
    this._night = night;
    this._hotel = hotel;
    this._dailyBill = dailyBill;
    this._specialBill = specialBill;
    this._othersBill = othersBill;
    this._titleInfo = titleInfo;
  }

  int get appDetailsID => _appDetailsID;
  set appDetailsID(int appDetailsID) => _appDetailsID = appDetailsID;
  int get applicationID => _applicationID;
  set applicationID(int applicationID) => _applicationID = applicationID;
  String get startDate => _startDate;
  set startDate(String startDate) => _startDate = startDate;
  String get endDate => _endDate;
  set endDate(String endDate) => _endDate = endDate;
  String get fromPlace => _fromPlace;
  set fromPlace(String fromPlace) => _fromPlace = fromPlace;
  String get toPlace => _toPlace;
  set toPlace(String toPlace) => _toPlace = toPlace;
  String get reason => _reason;
  set reason(String reason) => _reason = reason;
  String? get transportBy => _transportBy;
  set transportBy(String? transportBy) => _transportBy = transportBy;
  String get approvalStatus => _approvalStatus;
  set approvalStatus(String approvalStatus) => _approvalStatus = approvalStatus;
  bool get ableToCancel => _ableToCancel;
  set ableToCancel(bool ableToCancel) => _ableToCancel = ableToCancel;
  int get transport => _transport;
  set transport(int transport) => _transport = transport;
  int get morning => _morning;
  set morning(int morning) => _morning = morning;
  int get evening => _evening;
  set evening(int evening) => _evening = evening;
  int get night => _night;
  set night(int night) => _night = night;
  int get hotel => _hotel;
  set hotel(int hotel) => _hotel = hotel;
  int get dailyBill => _dailyBill;
  set dailyBill(int dailyBill) => _dailyBill = dailyBill;
  int get specialBill => _specialBill;
  set specialBill(int specialBill) => _specialBill = specialBill;
  int get othersBill => _othersBill;
  set othersBill(int othersBill) => _othersBill = othersBill;
  String get titleInfo => _titleInfo;
  set titleInfo(String titleInfo) => _titleInfo = titleInfo;

  Data.fromJson(Map<String, dynamic> json) {
    _appDetailsID = json['appDetailsID'];
    _applicationID = json['applicationID'];
    _startDate = json['startDate'];
    _endDate = json['endDate'];
    _fromPlace = json['fromPlace'];
    _toPlace = json['toPlace'];
    _reason = json['reason'];
    _transportBy = json['transportBy'];
    _approvalStatus = json['approvalStatus'];
    _ableToCancel = json['ableToCancel'];
    _transport = json['transport'];
    _morning = json['morning'];
    _evening = json['evening'];
    _night = json['night'];
    _hotel = json['hotel'];
    _dailyBill = json['dailyBill'];
    _specialBill = json['specialBill'];
    _othersBill = json['othersBill'];
    _titleInfo = json['titleInfo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appDetailsID'] = this._appDetailsID;
    data['applicationID'] = this._applicationID;
    data['startDate'] = this._startDate;
    data['endDate'] = this._endDate;
    data['fromPlace'] = this._fromPlace;
    data['toPlace'] = this._toPlace;
    data['reason'] = this._reason;
    data['transportBy'] = this._transportBy;
    data['approvalStatus'] = this._approvalStatus;
    data['ableToCancel'] = this._ableToCancel;
    data['transport'] = this._transport;
    data['morning'] = this._morning;
    data['evening'] = this._evening;
    data['night'] = this._night;
    data['hotel'] = this._hotel;
    data['dailyBill'] = this._dailyBill;
    data['specialBill'] = this._specialBill;
    data['othersBill'] = this._othersBill;
    data['titleInfo'] = this._titleInfo;
    return data;
  }
}

