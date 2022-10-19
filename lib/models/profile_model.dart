class ProfileModel {
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
  List<Roles>? roles;

  ProfileModel(
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

  ProfileModel.fromJson(Map<String, dynamic> json) {
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
    if (json['Roles'] != null) {
      roles = <Roles>[];
      json['Roles'].forEach((v) {
        roles!.add(Roles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Id'] = id;
    data['Agent'] = agent;
    data['IP'] = iP;
    data['ValidFrom'] = validFrom;
    data['ValidTo'] = validTo;
    data['Token'] = token;
    data['SiteId'] = siteId;
    data['Password'] = password;
    data['Code'] = code;
    data['Status'] = status;
    data['DisplayName'] = displayName;
    data['Phone'] = phone;
    data['Email'] = email;
    data['FailedLoginAttempts'] = failedLoginAttempts;
    data['ForcePasswordChange'] = forcePasswordChange;
    data['ImagePath'] = imagePath;
    data['DefaultRedirect'] = defaultRedirect;
    data['OrganizationId'] = organizationId;
    data['Platforms'] = platforms;
    data['AccountId'] = accountId;
    data['OrganizationName'] = organizationName;

    return data;
  }
}

class Roles {
  String? id;
  String? displayName;

  Roles({this.id, this.displayName});

  Roles.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    displayName = json['DisplayName'];
  }
}
