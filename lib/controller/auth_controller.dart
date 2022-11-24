import 'package:lcmobileapp/data/repository/auth_repo.dart';
import 'package:lcmobileapp/models/response_model.dart';
import 'package:get/get.dart';
import 'package:lcmobileapp/models/user_model.dart';

class AuthController extends GetxController implements GetxService {
  final AuthRepo authRepo;
  AuthController({required this.authRepo});

  bool _isLoading = false;
  late UserModel _userModel;

  bool get isLoading => _isLoading;
  UserModel get userModel => _userModel;

  Future<ResponseModel> login(String userName, String password) async {
    authRepo.getUserToken();
    _isLoading = true;
    update();
    Response response = await authRepo.login(userName, password);
    late ResponseModel responseModel;

    if (response.statusCode == 200) {
      if (response.body["Code"] != 200) {
        responseModel = ResponseModel(false, response.body["Errors"]);
      } else {
        var data = response.body["Data"];
        authRepo.saveUserToken(data["Token"]);
        authRepo.saveUserTerminal(data["User"]["TerminalId"]);
        print('My token is ' + data["Token"].toString());
        _userModel = UserModel.fromJson(data["User"]);
        responseModel = ResponseModel(true, response.body["Message"]);
      }
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  Future<ResponseModel> forgot(String userName) async {
    _isLoading = true;
    update();
    Response response = await authRepo.forgot(userName);
    late ResponseModel responseModel;

    if (response.statusCode == 200) {
      if (response.body["Code"] != 200) {
        responseModel = ResponseModel(false, response.body["Errors"]);
      } else {
        responseModel = ResponseModel(true, response.body["Message"]);
      }
    } else {
      responseModel = ResponseModel(false, response.statusText!);
    }
    _isLoading = false;
    update();
    return responseModel;
  }

  bool clearSharedData() {
    return authRepo.clearSharedData();
  }

  bool userLoggedIn() {
    return authRepo.userLoggedIn();
  }
}
