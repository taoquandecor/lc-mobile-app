import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lcmobileapp/data/repository/attachment_repo.dart';
import 'package:lcmobileapp/models/attachment_model.dart';
import 'package:lcmobileapp/models/response_model.dart';
import 'package:lcmobileapp/models/token_timeout_model.dart';
import 'package:lcmobileapp/models/upload_ticket_model.dart';
import 'package:lcmobileapp/utils/app_color.dart';
import 'package:lcmobileapp/utils/app_message.dart';

class AttachmentController extends GetxController implements GetxService {
  AttachmentRepo attachmentRepo;

  AttachmentController({required this.attachmentRepo});

  TokenTimeOut _tokenTimeOut = TokenTimeOut(isTimeOut: false);
  TokenTimeOut get tokenTimeOut => _tokenTimeOut;

  AttachmentModel _attachmentModel = AttachmentModel();
  AttachmentModel get attachmentModel => _attachmentModel;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  /*
  * Lấy ảnh vừa được upload bởi tally
  */
  Future<void> getImageTicket(String entityId) async {
    Response response = await attachmentRepo.getImageTicket(entityId);

    if (response.statusCode == 200 && response.body["Code"] == 200) {
      _attachmentModel =
          AttachmentModel.fromJson(response.body["Data"]["Attachment"]);
      _isLoaded = true;
      update();
    } else {
      Get.snackbar(
        "Attachment",
        "Can not got ticket",
        backgroundColor: AppColor.errorColor,
        colorText: Colors.white,
      );
    }
  }

  /*
    upload image ticket
  */
  Future<ResponseModel> uploadTicket(
      UploadTicketModel uploadTicketModel) async {
    ResponseModel responseModel;
    try {
      Response response = await attachmentRepo.upLoadTicket(uploadTicketModel);

      if (response.statusCode == 200) {
        if (response.body["Code"] == 460) {
          _tokenTimeOut = TokenTimeOut(isTimeOut: true);
          responseModel = ResponseModel(false, AppMessage.TOKEN_TIMEOUT);
        } else if (response.body["Code"] == 400 ||
            response.body["Code"] == 500) {
          responseModel = ResponseModel(false, response.body["Errors"]);
        } else {
          _tokenTimeOut = TokenTimeOut(isTimeOut: false);
          responseModel = ResponseModel(true, response.body["Message"]);
        }
      } else {
        responseModel = ResponseModel(false, response.statusText.toString());
      }
    } catch (e) {
      responseModel = ResponseModel(false, e.toString());
    }
    update();
    return responseModel;
  }
}
