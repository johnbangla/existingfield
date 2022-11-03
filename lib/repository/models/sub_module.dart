class SubModule {
  late bool _success;
  late String _messageEn;
  late String _messageBn;
  late List<SubModuleData> _data;

  SubModule(
      {required bool success, required String messageEn, required String messageBn, required List<SubModuleData> data}) {
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
  List<SubModuleData> get data => _data;
  set data(List<SubModuleData> data) => _data = data;

  SubModule.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _messageEn = json['messageEn'];
    _messageBn = json['messageBn'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data.add(new SubModuleData.fromJson(v));
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

class SubModuleData {
  late int _moduleId;
  late int _subModuleId;
  late String _subModuleName;
  late String _uiVisibleNameEn;
  late String _uiVisibleNameBn;

  Data(
      {required int moduleId,
        required int subModuleId,
        required String subModuleName,
        required String uiVisibleNameEn,
        required String uiVisibleNameBn}) {
    this._moduleId = moduleId;
    this._subModuleId = subModuleId;
    this._subModuleName = subModuleName;
    this._uiVisibleNameEn = uiVisibleNameEn;
    this._uiVisibleNameBn = uiVisibleNameBn;
  }

  int get moduleId => _moduleId;
  set moduleId(int moduleId) => _moduleId = moduleId;
  int get subModuleId => _subModuleId;
  set subModuleId(int subModuleId) => _subModuleId = subModuleId;
  String get subModuleName => _subModuleName;
  set subModuleName(String subModuleName) => _subModuleName = subModuleName;
  String get uiVisibleNameEn => _uiVisibleNameEn;
  set uiVisibleNameEn(String uiVisibleNameEn) =>
      _uiVisibleNameEn = uiVisibleNameEn;
  String get uiVisibleNameBn => _uiVisibleNameBn;
  set uiVisibleNameBn(String uiVisibleNameBn) =>
      _uiVisibleNameBn = uiVisibleNameBn;

  SubModuleData.fromJson(Map<String, dynamic> json) {
    _moduleId = json['moduleId'];
    _subModuleId = json['subModuleId'];
    _subModuleName = json['subModuleName'];
    _uiVisibleNameEn = json['uiVisibleNameEn'];
    _uiVisibleNameBn = json['uiVisibleNameBn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['moduleId'] = this._moduleId;
    data['subModuleId'] = this._subModuleId;
    data['subModuleName'] = this._subModuleName;
    data['uiVisibleNameEn'] = this._uiVisibleNameEn;
    data['uiVisibleNameBn'] = this._uiVisibleNameBn;
    return data;
  }
}



