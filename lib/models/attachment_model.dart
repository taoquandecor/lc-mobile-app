class AttachmentModel {
  String? id;
  String? siteId;
  String? entityId;
  String? displayName;
  String? rawName;
  String? path;
  String? extension;
  String? fileSize;
  String? status;
  String? deleted;
  String? createdDate;
  String? createdBy;
  String? changedDate;
  String? changedBy;
  String? publicPortal;
  String? type;

  AttachmentModel(
      {this.id,
      this.siteId,
      this.entityId,
      this.displayName,
      this.rawName,
      this.path,
      this.extension,
      this.fileSize,
      this.status,
      this.deleted,
      this.createdDate,
      this.createdBy,
      this.changedDate,
      this.changedBy,
      this.publicPortal,
      this.type});

  AttachmentModel.fromJson(Map<String, dynamic> json) {
    if (json != null) {
      id = json['Id'];
      siteId = json['SiteId'];
      entityId = json['EntityId'];
      displayName = json['DisplayName'];
      rawName = json['RawName'];
      path = json['Path'];
      extension = json['Extension'];
      fileSize = json['FileSize'];
      status = json['Status'];
      deleted = json['Deleted'];
      createdDate = json['CreatedDate'];
      createdBy = json['CreatedBy'];
      changedDate = json['ChangedDate'];
      changedBy = json['ChangedBy'];
      publicPortal = json['PublicPortal'];
      type = json['Type'];
    }
  }
}
