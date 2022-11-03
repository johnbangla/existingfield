class ApprovedPlan {
  late bool _success;
  late String _messageEn;
  late String _messageBn;
  List<ApprovedPlanData> _data = [];

  ApprovedPlan(
      {required bool success, required String messageEn, required String messageBn, required List<ApprovedPlanData> data}) {
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
  List<ApprovedPlanData> get data => _data;
  set data(List<ApprovedPlanData> data) => _data = data;

  ApprovedPlan.fromJson(Map<String, dynamic> json) {
    _success = json['success'];
    _messageEn = json['messageEn'];
    _messageBn = json['messageBn'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data.add(new ApprovedPlanData.fromJson(v));
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

class ApprovedPlanData {
  late int _planID;
  late String _tourDetails;

  ApprovedPlanData({required int planID, required String tourDetails}) {
    this._planID = planID;
    this._tourDetails = tourDetails;
  }

  int get planID => _planID;
  set planID(int planID) => _planID = planID;
  String get tourDetails => _tourDetails;
  set tourDetails(String tourDetails) => _tourDetails = tourDetails;

  ApprovedPlanData.fromJson(Map<String, dynamic> json) {
    _planID = json['planID'];
    _tourDetails = json['tourDetails'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['planID'] = this._planID;
    data['tourDetails'] = this._tourDetails;
    return data;
  }
}

