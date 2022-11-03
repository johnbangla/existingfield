class PlanDetailModel {
  late bool _success;
  late String _messageEn;
  late String _messageBn;
  late List<Data> _data;

  PlanDetailModel(
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

  PlanDetailModel.fromJson(Map<String, dynamic> json) {
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
  late int _planDetailsID;
  late int _planID;
  late String _tourDate;
  late int _canceledByUser;
  late String _activityName;

  Data(
      {required int planDetailsID,
        required int planID,
        required String tourDate,
        required int canceledByUser,
        required String activityName}) {
    this._planDetailsID = planDetailsID;
    this._planID = planID;
    this._tourDate = tourDate;
    this._canceledByUser = canceledByUser;
    this._activityName = activityName;
  }

  int get planDetailsID => _planDetailsID;
  set planDetailsID(int planDetailsID) => _planDetailsID = planDetailsID;
  int get planID => _planID;
  set planID(int planID) => _planID = planID;
  String get tourDate => _tourDate;
  set tourDate(String tourDate) => _tourDate = tourDate;
  int get canceledByUser => _canceledByUser;
  set canceledByUser(int canceledByUser) => _canceledByUser = canceledByUser;
  String get activityName => _activityName;
  set activityName(String activityName) => _activityName = activityName;

  Data.fromJson(Map<String, dynamic> json) {
    _planDetailsID = json['planDetailsID'];
    _planID = json['planID'];
    _tourDate = json['tourDate'];
    _canceledByUser = json['canceledByUser'];
    _activityName = json['activityName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['planDetailsID'] = this._planDetailsID;
    data['planID'] = this._planID;
    data['tourDate'] = this._tourDate;
    data['canceledByUser'] = this._canceledByUser;
    data['activityName'] = this._activityName;
    return data;
  }
}

