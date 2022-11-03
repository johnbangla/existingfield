class Module {
 late bool _success;
  late String _messageEn;
  late String _messageBn;
  late Data _data;

  Module({required bool success, required String messageEn, required String messageBn, required Data data}) {
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
  Data get data => _data;
  set data(Data data) => _data = data;

  Module.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _messageEn = json['messageEn'];
    _messageBn = json['messageBn'];
    _data = (json['data'] != null ? new Data.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this._success;
    data['messageEn'] = this._messageEn;
    data['messageBn'] = this._messageBn;
    if (this._data != null) {
      data['data'] = this._data.toJson();
    }
    return data;
  }
}

class Data {
  late String _employeeCode;
  late String _employeeName;
  late String _designationName;
  late String _supervisor;
  late List<ModuleAccess> _moduleAccess;
  late String _broadcastMsgEn;
  late String _broadcastMsgBn;
  late String _imgEmp;
  late String _imgCompLogo;

  Data(
      { required employeeCode,
        required String employeeName,
        required String designationName,
        required String supervisor,
        required   List<ModuleAccess> moduleAccess,
        required String broadcastMsgEn,
        required String broadcastMsgBn,
        required String imgEmp,
        required String imgCompLogo}) {
    this._employeeCode = employeeCode;
    this._employeeName = employeeName;
    this._designationName = designationName;
    this._supervisor = supervisor;
    this._moduleAccess = moduleAccess;
    this._broadcastMsgEn = broadcastMsgEn;
    this._broadcastMsgBn = broadcastMsgBn;
    this._imgEmp = imgEmp;
    this._imgCompLogo = imgCompLogo;
  }

  String get employeeCode => _employeeCode;
  set employeeCode(String employeeCode) => _employeeCode = employeeCode;
  String get employeeName => _employeeName;
  set employeeName(String employeeName) => _employeeName = employeeName;
  String get designationName => _designationName;
  set designationName(String designationName) =>
      _designationName = designationName;
  String get supervisor => _supervisor;
  set supervisor(String supervisor) => _supervisor = supervisor;
  List<ModuleAccess> get moduleAccess => _moduleAccess;
  set moduleAccess(List<ModuleAccess> moduleAccess) =>
      _moduleAccess = moduleAccess;
  String get broadcastMsgEn => _broadcastMsgEn;
  set broadcastMsgEn(String broadcastMsgEn) => _broadcastMsgEn = broadcastMsgEn;
  String get broadcastMsgBn => _broadcastMsgBn;
  set broadcastMsgBn(String broadcastMsgBn) => _broadcastMsgBn = broadcastMsgBn;
  String get imgEmp => _imgEmp;
  set imgEmp(String imgEmp) => _imgEmp = imgEmp;
  String get imgCompLogo => _imgCompLogo;
  set imgCompLogo(String imgCompLogo) => _imgCompLogo = imgCompLogo;

  Data.fromJson(Map<String, dynamic> json) {
    _employeeCode = json['employeeCode'];
    _employeeName = json['employeeName'];
    _designationName = json['designationName'];
    _supervisor = json['supervisor'];
    if (json['moduleAccess'] != null) {
      _moduleAccess =  [];
      json['moduleAccess'].forEach((v) {
        _moduleAccess.add( ModuleAccess.fromJson(v));
      });
    }
    _broadcastMsgEn = json['broadcastMsgEn'];
    _broadcastMsgBn = json['broadcastMsgBn'];
    _imgEmp = json['imgEmp'];
    _imgCompLogo = json['imgCompLogo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['employeeCode'] = this._employeeCode;
    data['employeeName'] = this._employeeName;
    data['designationName'] = this._designationName;
    data['supervisor'] = this._supervisor;
    if (this._moduleAccess != null) {
      data['moduleAccess'] = this._moduleAccess.map((v) => v.toJson()).toList();
    }
    data['broadcastMsgEn'] = this._broadcastMsgEn;
    data['broadcastMsgBn'] = this._broadcastMsgBn;
    data['imgEmp'] = this._imgEmp;
    data['imgCompLogo'] = this._imgCompLogo;
    return data;
  }
}

class ModuleAccess {
  late int _moduleId;
  late String _moduleNameEn;
  late String _moduleNameBn;

  ModuleAccess({required int moduleId, required String moduleNameEn, required String moduleNameBn}) {
    this._moduleId = moduleId;
    this._moduleNameEn = moduleNameEn;
    this._moduleNameBn = moduleNameBn;
  }

  int get moduleId => _moduleId;
  set moduleId(int moduleId) => _moduleId = moduleId;
  String get moduleNameEn => _moduleNameEn;
  set moduleNameEn(String moduleNameEn) => _moduleNameEn = moduleNameEn;
  String get moduleNameBn => _moduleNameBn;
  set moduleNameBn(String moduleNameBn) => _moduleNameBn = moduleNameBn;

  ModuleAccess.fromJson(Map<String, dynamic> json) {
    _moduleId = json['moduleId'];
    _moduleNameEn = json['moduleNameEn'];
    _moduleNameBn = json['moduleNameBn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['moduleId'] = this._moduleId;
    data['moduleNameEn'] = this._moduleNameEn;
    data['moduleNameBn'] = this._moduleNameBn;
    return data;
  }
}