import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lcmobileapp/data/repository/user_repo.dart';
import 'package:lcmobileapp/models/profile_model.dart';
import 'package:lcmobileapp/models/response_error_model.dart';
import 'package:lcmobileapp/models/response_model.dart';
import 'package:lcmobileapp/utils/app_color.dart';

class UserController extends GetxController implements GetxService {
  final UserRepo userRepo;
  UserController({required this.userRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ProfileModel _profileModel = ProfileModel();
  ProfileModel get profileModel => _profileModel;

  Future<void> getUserInfo() async {
    Response response = await userRepo.getUserInfo();

    if (response.statusCode == 200 && response.body["Code"] == 200) {
      _profileModel = ProfileModel.fromJson(response.body["Data"]["User"]);
      _isLoading = true;
      update();
    } else {
      Get.snackbar(
        "Profile",
        "Can not got profile",
        backgroundColor: AppColor.errorColor,
        colorText: Colors.white,
      );
    }
  }

  Future<ResponseModel> updateProfile(
      String displayName, String phone, String email) async {
    Response response = await userRepo.updateProfile(displayName, phone, email);
    ResponseModel responseModel;

    if (response.statusCode == 200) {
      if (response.body["Code"] == 200) {
        responseModel = ResponseModel(true, response.body["Message"]);
      } else {
        ResponseErrorModel responseErrorModel = ResponseErrorModel();
        responseErrorModel = ResponseErrorModel.fromJson(response.body);
        responseModel = ResponseModel(false, "sdfdsafadf");
      }
    } else {
      responseModel = ResponseModel(false, response.statusText.toString());
    }
    _isLoading = true;
    update();
    return responseModel;
  }
}
