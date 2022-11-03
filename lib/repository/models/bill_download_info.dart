class BillDownloadInfo {
  late bool _success;
  late String _messageEn;
  late String _messageBn;
  late List<Data> _data;

  BillDownloadInfo(
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

  BillDownloadInfo.fromJson(Map<String, dynamic> json) {
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
  late int _appdetailsID;
  late int _applicationid;
  late String _employeeCode;
  late String _employeeName;
  late String _designationName;
  late String _siteCode;
  late String _siteName;
  late String _startDate;
  late String _startTimePart;
  late String _enddate;
  late String _endTimePart;
  late String _appliedDate;
  late String _approvalstatus;
  late String _reason;
  late String _fromplace;
  late String _toplace;
  late String _requestholder;
  late String? _transportby;
  late int _billid;
  late int _transport;
  late int _morning;
  late int _evening;
  late int _night;
  late int _hotel;
  late int _dailyBill;
  late int _specialBill;
  late int _othersBill;
  late int _total;
  late String _employeenameNativelang;
  late String _sitenameNativelang;
  late String _designationnameNativelang;

  Data(
      {required int appdetailsID,
        required int applicationid,
        required String employeeCode,
        required String employeeName,
        required String designationName,
        required String siteCode,
        required String siteName,
        required String startDate,
        required String startTimePart,
        required String enddate,
        required String endTimePart,
        required String appliedDate,
        required String approvalstatus,
        required String reason,
        required String fromplace,
        required String toplace,
        required String requestholder,
        required String transportby,
        required int billid,
        required int transport,
        required int morning,
        required int evening,
        required int night,
        required int hotel,
        required int dailyBill,
        required int specialBill,
        required int othersBill,
        required int total,
        required String employeenameNativelang,
        required String sitenameNativelang,
        required String designationnameNativelang}) {
    this._appdetailsID = appdetailsID;
    this._applicationid = applicationid;
    this._employeeCode = employeeCode;
    this._employeeName = employeeName;
    this._designationName = designationName;
    this._siteCode = siteCode;
    this._siteName = siteName;
    this._startDate = startDate;
    this._startTimePart = startTimePart;
    this._enddate = enddate;
    this._endTimePart = endTimePart;
    this._appliedDate = appliedDate;
    this._approvalstatus = approvalstatus;
    this._reason = reason;
    this._fromplace = fromplace;
    this._toplace = toplace;
    this._requestholder = requestholder;
    this._transportby = transportby;
    this._billid = billid;
    this._transport = transport;
    this._morning = morning;
    this._evening = evening;
    this._night = night;
    this._hotel = hotel;
    this._dailyBill = dailyBill;
    this._specialBill = specialBill;
    this._othersBill = othersBill;
    this._total = total;
    this._employeenameNativelang = employeenameNativelang;
    this._sitenameNativelang = sitenameNativelang;
    this._designationnameNativelang = designationnameNativelang;
  }

  int get appdetailsID => _appdetailsID;
  set appdetailsID(int appdetailsID) => _appdetailsID = appdetailsID;
  int get applicationid => _applicationid;
  set applicationid(int applicationid) => _applicationid = applicationid;
  String get employeeCode => _employeeCode;
  set employeeCode(String employeeCode) => _employeeCode = employeeCode;
  String get employeeName => _employeeName;
  set employeeName(String employeeName) => _employeeName = employeeName;
  String get designationName => _designationName;
  set designationName(String designationName) =>
      _designationName = designationName;
  String get siteCode => _siteCode;
  set siteCode(String siteCode) => _siteCode = siteCode;
  String get siteName => _siteName;
  set siteName(String siteName) => _siteName = siteName;
  String get startDate => _startDate;
  set startDate(String startDate) => _startDate = startDate;
  String get startTimePart => _startTimePart;
  set startTimePart(String startTimePart) => _startTimePart = startTimePart;
  String get enddate => _enddate;
  set enddate(String enddate) => _enddate = enddate;
  String get endTimePart => _endTimePart;
  set endTimePart(String endTimePart) => _endTimePart = endTimePart;
  String get appliedDate => _appliedDate;
  set appliedDate(String appliedDate) => _appliedDate = appliedDate;
  String get approvalstatus => _approvalstatus;
  set approvalstatus(String approvalstatus) => _approvalstatus = approvalstatus;
  String get reason => _reason;
  set reason(String reason) => _reason = reason;
  String get fromplace => _fromplace;
  set fromplace(String fromplace) => _fromplace = fromplace;
  String get toplace => _toplace;
  set toplace(String toplace) => _toplace = toplace;
  String get requestholder => _requestholder;
  set requestholder(String requestholder) => _requestholder = requestholder;
  String? get transportby => _transportby;
  set transportby(String? transportby) => _transportby = transportby;
  int get billid => _billid;
  set billid(int billid) => _billid = billid;
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
  int get total => _total;
  set total(int total) => _total = total;
  String get employeenameNativelang => _employeenameNativelang;
  set employeenameNativelang(String employeenameNativelang) =>
      _employeenameNativelang = employeenameNativelang;
  String get sitenameNativelang => _sitenameNativelang;
  set sitenameNativelang(String sitenameNativelang) =>
      _sitenameNativelang = sitenameNativelang;
  String get designationnameNativelang => _designationnameNativelang;
  set designationnameNativelang(String designationnameNativelang) =>
      _designationnameNativelang = designationnameNativelang;

  Data.fromJson(Map<String, dynamic> json) {
    _appdetailsID = json['appdetailsID'];
    _applicationid = json['applicationid'];
    _employeeCode = json['employeeCode'];
    _employeeName = json['employeeName'];
    _designationName = json['designationName'];
    _siteCode = json['siteCode'];
    _siteName = json['siteName'];
    _startDate = json['startDate'];
    _startTimePart = json['startTimePart'];
    _enddate = json['enddate'];
    _endTimePart = json['endTimePart'];
    _appliedDate = json['applied_Date'];
    _approvalstatus = json['approvalstatus'];
    _reason = json['reason'];
    _fromplace = json['fromplace'];
    _toplace = json['toplace'];
    _requestholder = json['requestholder'];
    _transportby = json['transportby'];
    _billid = json['billid'];
    _transport = json['transport'];
    _morning = json['morning'];
    _evening = json['evening'];
    _night = json['night'];
    _hotel = json['hotel'];
    _dailyBill = json['dailyBill'];
    _specialBill = json['specialBill'];
    _othersBill = json['othersBill'];
    _total = json['total'];
    _employeenameNativelang = json['employeename_Nativelang'];
    _sitenameNativelang = json['sitename_Nativelang'];
    _designationnameNativelang = json['designationname_Nativelang'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appdetailsID'] = this._appdetailsID;
    data['applicationid'] = this._applicationid;
    data['employeeCode'] = this._employeeCode;
    data['employeeName'] = this._employeeName;
    data['designationName'] = this._designationName;
    data['siteCode'] = this._siteCode;
    data['siteName'] = this._siteName;
    data['startDate'] = this._startDate;
    data['startTimePart'] = this._startTimePart;
    data['enddate'] = this._enddate;
    data['endTimePart'] = this._endTimePart;
    data['applied_Date'] = this._appliedDate;
    data['approvalstatus'] = this._approvalstatus;
    data['reason'] = this._reason;
    data['fromplace'] = this._fromplace;
    data['toplace'] = this._toplace;
    data['requestholder'] = this._requestholder;
    data['transportby'] = this._transportby;
    data['billid'] = this._billid;
    data['transport'] = this._transport;
    data['morning'] = this._morning;
    data['evening'] = this._evening;
    data['night'] = this._night;
    data['hotel'] = this._hotel;
    data['dailyBill'] = this._dailyBill;
    data['specialBill'] = this._specialBill;
    data['othersBill'] = this._othersBill;
    data['total'] = this._total;
    data['employeename_Nativelang'] = this._employeenameNativelang;
    data['sitename_Nativelang'] = this._sitenameNativelang;
    data['designationname_Nativelang'] = this._designationnameNativelang;
    return data;
  }
}

