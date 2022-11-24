import 'package:get/get.dart';
import 'package:lcmobileapp/data/api/api_client.dart';
import 'package:lcmobileapp/models/upload_ticket_model.dart';
import 'package:lcmobileapp/utils/app_constants.dart';

class AttachmentRepo extends GetxService {
  final ApiClient apiClient;

  AttachmentRepo({required this.apiClient});

  Future<Response> getImageTicket(String entityId) async {
    return await apiClient.getData(AppContants.GET_IMAGE_TICKET_URI + entityId);
  }

  Future<Response> upLoadTicket(UploadTicketModel uploadTicketModel) async {
    return await apiClient.postData(
        AppContants.UPLOAD_IMAGE_TICKET_URI, uploadTicketModel.toJson());
  }
}
