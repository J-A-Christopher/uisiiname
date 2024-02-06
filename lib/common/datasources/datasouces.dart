import 'package:dio/dio.dart';
import 'package:usiiname/features/signupfeature/model/sign_up_model.dart';
import 'package:usiiname/utils/constants.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String signUpUrl = '$BASEURL/auth/signup';

  Future<SignUpModelResponse> createUser({required userSignUpData}) async {
    try {
      Response response = await _dio.post(signUpUrl, data: userSignUpData);
      print("Registration response: $response");
      if (response.statusCode != 200) {
        throw Exception(response.statusMessage);
      } else {
        SignUpModelResponse signUpResponse =
            SignUpModelResponse.fromJson(response.data);
        return signUpResponse;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        //Request reached server but failed
        print('Dio e.response: ${e.response!.data}');
        throw Exception(e.response?.data['message']);
      } else {
        //If you're offfline and request did not reach server
        String? errorMessage = e.message;
        int colonIndex = errorMessage!.indexOf(':');
        String extractedPart = errorMessage.substring(0, colonIndex).trim();
        print('Response.data${e.response?.data}');
        throw Exception(extractedPart);
      }
    } catch (err) {
      rethrow;
    }
  }
}
