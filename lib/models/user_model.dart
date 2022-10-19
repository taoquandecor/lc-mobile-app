class UserModel {
  String? id;
  String? agent;
  String? iP;
  String? validFrom;
  String? validTo;
  String? token;
  String? siteId;
  String? password;
  String? code;
  String? status;
  String? displayName;
  String? phone;
  String? email;
  String? failedLoginAttempts;
  String? forcePasswordChange;
  String? imagePath;
  String? defaultRedirect;
  String? organizationId;
  String? platforms;
  String? accountId;
  String? organizationName;
  Roles? roles;

  UserModel(
      {this.id,
      this.agent,
      this.iP,
      this.validFrom,
      this.validTo,
      this.token,
      this.siteId,
      this.password,
      this.code,
      this.status,
      this.displayName,
      this.phone,
      this.email,
      this.failedLoginAttempts,
      this.forcePasswordChange,
      this.imagePath,
      this.defaultRedirect,
      this.organizationId,
      this.platforms,
      this.accountId,
      this.organizationName,
      this.roles});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    agent = json['Agent'];
    iP = json['IP'];
    validFrom = json['ValidFrom'];
    validTo = json['ValidTo'];
    token = json['Token'];
    siteId = json['SiteId'];
    password = json['Password'];
    code = json['Code'];
    status = json['Status'];
    displayName = json['DisplayName'];
    phone = json['Phone'];
    email = json['Email'];
    failedLoginAttempts = json['FailedLoginAttempts'];
    forcePasswordChange = json['ForcePasswordChange'];
    imagePath = json['ImagePath'];
    defaultRedirect = json['DefaultRedirect'];
    organizationId = json['OrganizationId'];
    platforms = json['Platforms'];
    accountId = json['AccountId'];
    organizationName = json['OrganizationName'];
    roles = json['Roles'] != null ? Roles.fromJson(json['Roles']) : null;
  }
}

class Roles {
  String? weighingBridgeMobile;

  Roles({this.weighingBridgeMobile});

  Roles.fromJson(Map<String, dynamic> json) {
    weighingBridgeMobile = json['WeighingBridgeMobile'];
  }
}
