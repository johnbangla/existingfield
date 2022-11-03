class ApprovalRequest {
  late bool _success;
  late String _messageEn;
  late String _messageBn;
   List<Data> _data  = [];

  ApprovalRequest(
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

  ApprovalRequest.fromJson(Map<String, dynamic> json) {
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
  late String _employeeCode;
  late String _employeeName;
  late String _designationName;
  late String _startDate;
  late String _endDate;
  late String _places;

  Data(
      {required int applicationID,
        required String employeeCode,
        required String employeeName,
        required String designationName,
        required String startDate,
        required String endDate,
        required String places}) {
    this._applicationID = applicationID;
    this._employeeCode = employeeCode;
    this._employeeName = employeeName;
    this._designationName = designationName;
    this._startDate = startDate;
    this._endDate = endDate;
    this._places = places;
  }

  int get applicationID => _applicationID;
  set applicationID(int applicationID) => _applicationID = applicationID;
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
  String get places => _places;
  set places(String places) => _places = places;

  Data.fromJson(Map<String, dynamic> json) {
    _applicationID = json['applicationID'];
    _employeeCode = json['employeeCode'];
    _employeeName = json['employeeName'];
    _designationName = json['designationName'];
    _startDate = json['startDate'];
    _endDate = json['endDate'];
    _places = json['places'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['applicationID'] = this._applicationID;
    data['employeeCode'] = this._employeeCode;
    data['employeeName'] = this._employeeName;
    data['designationName'] = this._designationName;
    data['startDate'] = this._startDate;
    data['endDate'] = this._endDate;
    data['places'] = this._places;
    return data;
  }
}

