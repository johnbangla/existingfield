class MyPlan {
  late bool _success;
  late String _messageEn;
  late String _messageBn;
  List<Data> _data  = [];

  MyPlan({required bool success, required String messageEn, required String messageBn, required List<Data> data}) {
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

  MyPlan.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _messageEn = json['messageEn'];
    _messageBn = json['messageBn'];
    if (json['data'] != null) {
      _data =  [];
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
  late int _planID;
  late String _employeeCode;
  late String _employeeName;
  late String _designationName;
  late String _startDate;
  late String _endDate;
  late String _siteName;
  late String _siteCode;
  late String _places;
  late String _reason;
  late bool _ableToCancel;
  late String _requestHolder;
  late String _activityName;
  late int _receiverEmpID;

  Data(
      {required int planID,
        required String employeeCode,
        required String employeeName,
        required String designationName,
        required String startDate,
        required String endDate,
        required String siteName,
        required String siteCode,
        required String places,
        required String reason,
        required bool ableToCancel,
        required String requestHolder,
        required String activityName,
        required int receiverEmpID}) {
    this._planID = planID;
    this._employeeCode = employeeCode;
    this._employeeName = employeeName;
    this._designationName = designationName;
    this._startDate = startDate;
    this._endDate = endDate;
    this._siteName = siteName;
    this._siteCode = siteCode;
    this._places = places;
    this._reason = reason;
    this._ableToCancel = ableToCancel;
    this._requestHolder = requestHolder;
    this._activityName = activityName;
    this._receiverEmpID = receiverEmpID;
  }

  int get planID => _planID;
  set planID(int planID) => _planID = planID;
  String get employeeCode => _employeeCode;
  set employeeCode(String employeeCode) => _employeeCode = employeeCode;
  String get employeeName => _employeeName;
  set employeeName(String employeeName) => _employeeName = employeeName;
  String get designationName => _designationName;
  set designationName(String designationName) =>
      _designationName = designationName;
  String get startDate => _startDate;
  set startDate(String startDate) => _startDate = startDate;
  String get endDate => _endDate;
  set endDate(String endDate) => _endDate = endDate;
  String get siteName => _siteName;
  set siteName(String siteName) => _siteName = siteName;
  String get siteCode => _siteCode;
  set siteCode(String siteCode) => _siteCode = siteCode;
  String get places => _places;
  set places(String places) => _places = places;
  String get reason => _reason;
  set reason(String reason) => _reason = reason;
  bool get ableToCancel => _ableToCancel;
  set ableToCancel(bool ableToCancel) => _ableToCancel = ableToCancel;
  String get requestHolder => _requestHolder;
  set requestHolder(String requestHolder) => _requestHolder = requestHolder;
  String get activityName => _activityName;
  set activityName(String activityName) => _activityName = activityName;
  int get receiverEmpID => _receiverEmpID;
  set receiverEmpID(int receiverEmpID) => _receiverEmpID = receiverEmpID;

  Data.fromJson(Map<String, dynamic> json) {
    _planID = json['planID'];
    _employeeCode = json['employeeCode'];
    _employeeName = json['employeeName'];
    _designationName = json['designationName'];
    _startDate = json['startDate'];
    _endDate = json['endDate'];
    _siteName = json['siteName'];
    _siteCode = json['siteCode'];
    _places = json['places'];
    _reason = json['reason'];
    _ableToCancel = json['ableToCancel'];
    _requestHolder = json['requestHolder'];
    _activityName = json['activityName'];
    _receiverEmpID = json['receiverEmpID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['planID'] = this._planID;
    data['employeeCode'] = this._employeeCode;
    data['employeeName'] = this._employeeName;
    data['designationName'] = this._designationName;
    data['startDate'] = this._startDate;
    data['endDate'] = this._endDate;
    data['siteName'] = this._siteName;
    data['siteCode'] = this._siteCode;
    data['places'] = this._places;
    data['reason'] = this._reason;
    data['ableToCancel'] = this._ableToCancel;
    data['requestHolder'] = this._requestHolder;
    data['activityName'] = this._activityName;
    data['receiverEmpID'] = this._receiverEmpID;
    return data;
  }
}

