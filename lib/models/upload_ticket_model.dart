import 'dart:io';

class UploadTicketModel {
  String? file;
  String? entityId;
  String? fileSize;
  String? fileName;
  int type = 1;

  UploadTicketModel(
      {this.file, this.entityId, this.fileSize, this.fileName, this.type = 1});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['File'] = file;
    data['EntityId'] = entityId;
    data['FileSize'] = fileSize;
    data['FileName'] = fileName;
    data['Type'] = type;

    return data;
  }
}
