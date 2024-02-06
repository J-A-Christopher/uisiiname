import 'package:usiiname/common/datasources/datasouces.dart';
import 'package:usiiname/features/signupfeature/model/sign_up_model.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<SignUpModelResponse> signUpUser({required userSignUpData}) async {
    return _provider.createUser(userSignUpData: userSignUpData);
  }
}
