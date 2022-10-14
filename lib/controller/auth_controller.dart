import 'package:lcmobileapp/data/repository/auth_repo.dart';
import 'package:lcmobileapp/models/login_model.dart';
import 'package:lcmobileapp/models/response_model.dart';

class AuthController {
  final AuthRepo authRepo;
  AuthController({required this.authRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Future<ResponseModel> login(LoginModel loginModel) async {}
}
