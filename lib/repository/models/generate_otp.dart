class GenerateOTP {
  late bool success;
  late String messageEn;
  late String messageBn;
  // Null data = null;
  //List<Data> data  = [];
   late Data? data;

  GenerateOTP(
      {required this.success,
        required this.messageEn,
        required this.messageBn,
        required List<Data> data});

  GenerateOTP.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    messageEn = json['messageEn'];
    messageBn = json['messageBn'];
    //data = (json['data'] != null ? new Data.fromJson(json['data']) : null)!;
    /*if (json['data'] != null) {
      //data = [];
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }*/

    if(json['data'] != null){

      data =  Data.fromJson(json['data']) ;
    } else {
      data = (json['data'] != null ? new Data.fromJson(json['data']) : null);

    }

   // data = (json['data'] != null ? new Data.fromJson(json['data']) : null)!;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['messageEn'] = this.messageEn;
    data['messageBn'] = this.messageBn;
   /* if (this.data != null) {
      data['data'] = this.data!.toJson();
    }*/

   /* if (this.data != null) {
      data['data'][0] = this.data.map((v) => v.toJson()).toList();
    }*/
    if (this.data != null) {
      data['data'] = this.data!.toJson();
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

