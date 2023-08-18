class UserModel {
  String? userName;
  String? token;
  String? emailAddress;
  int? userId;
  int? roleId;
  bool? isPasswordExpired;
  bool? isFirstTimeLogin;
  String? teamRole;
  String? teamCode;
  String? areaCode;

  UserModel(
      {this.userName,
      this.token,
      this.emailAddress,
      this.userId,
      this.roleId,
      this.isPasswordExpired,
      this.isFirstTimeLogin,
      this.teamRole,
      this.teamCode,
      this.areaCode});

  UserModel.fromJson(Map<String, dynamic> json) {
    userName = json['UserName'];
    token = json['Token'];
    emailAddress = json['EmailAddress'];
    userId = json['UserId'];
    roleId = json['RoleId'];
    isPasswordExpired = json['IsPasswordExpired'];
    isFirstTimeLogin = json['IsFirstTimeLogin'];
    teamRole = json['TeamRole'];
    teamCode = json['TeamCode'];
    areaCode = json['AreaCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['UserName'] = this.userName;
    data['Token'] = this.token;
    data['EmailAddress'] = this.emailAddress;
    data['UserId'] = this.userId;
    data['RoleId'] = this.roleId;
    data['IsPasswordExpired'] = this.isPasswordExpired;
    data['IsFirstTimeLogin'] = this.isFirstTimeLogin;
    data['TeamRole'] = this.teamRole;
    data['TeamCode'] = this.teamCode;
    data['AreaCode'] = this.areaCode;
    return data;
  }
}
