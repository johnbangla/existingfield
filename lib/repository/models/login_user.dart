class LoginUser {
  late bool success;
  late String messageEn;
  late String messageBn;
  late Data data;

  LoginUser(
      {required this.success,
      required this.messageEn,
      required this.messageBn,
      required this.data});

  LoginUser.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    messageEn = json['messageEn'];
    messageBn = json['messageBn'];
    data = (json['data'] != null ? new Data.fromJson(json['data']) : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['messageEn'] = this.messageEn;
    data['messageBn'] = this.messageBn;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  late bool otpToMobile;
  late bool otpToEmail;
  late String? mobile;
  late String? email;
  late String? token;
  late String otpValidity;

  Data(
      {required this.otpToMobile,
      required this.otpToEmail,
      required this.mobile,
      required this.email,
      required this.token,
      required this.otpValidity});

  Data.fromJson(Map<String, dynamic> json) {
    otpToMobile = json['otpToMobile'];
    otpToEmail = json['otpToEmail'];
    mobile = json['mobile'];
    email = json['email'];
    token = json['token'];
    otpValidity = json['otpValidity'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['otpToMobile'] = this.otpToMobile;
    data['otpToEmail'] = this.otpToEmail;
    data['mobile'] = this.mobile;
    data['email'] = this.email;
    data['token'] = this.token;
    data['otpValidity'] = this.otpValidity;
    return data;
  }
}
