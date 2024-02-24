import 'package:dio/dio.dart';
import 'package:usiiname/features/createfood/models/create_food_model.dart';
import 'package:usiiname/features/first-order-processing/models/first_order_processing_response.dart';
import 'package:usiiname/features/liveDonations/models/ive_donations_model.dart';
import 'package:usiiname/features/loginfeature/model/login_response.dart';
import 'package:usiiname/features/orderstatus/model/order_status_response.dart';
import 'package:usiiname/features/profilefetch/models/profile_fetch.dart';
import 'package:usiiname/features/signupfeature/model/sign_up_model.dart';
import 'package:usiiname/features/userDonations/model/userdonations_model.dart';
import 'package:usiiname/utils/constants.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:usiiname/utils/storage_utils.dart';

class ApiProvider {
  final Dio _dio = Dio();
  final String signUpUrl = '$BASEURL/auth/signup';
  final String loginUrl = '$BASEURL/auth/signin';
  final String liveDonationUrl = '$BASEURL/live-donations';
  final String userDonationUrl = '$BASEURL/user-donations';
  final String userFoodCreationUrl = '$BASEURL/add-food';
  final String foodReservation = '$BASEURL/order-food';
  final String profileFetch = '$BASEURL/get-user-profile';
  final String processOrder = '$BASEURL/process-order';
  late final String token;

  ApiProvider() {
    init();
  }

  Future<void> init() async {
    try {
      final retrievedToken = await StorageUtils().getUserInfo(key: 'token');
      if (retrievedToken == null) throw AssertionError('NO token provider');
      token = retrievedToken;
    } catch (error) {
      print(error);
    }
  }

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

  //user Login

  Future<LoginResponse> userLogin({required userLoginData}) async {
    try {
      Response response = await _dio.post(loginUrl,
          data: userLoginData,
          options: Options(sendTimeout: const Duration(seconds: 10)));
      print('LOgin response: $response');
      //var token = response.headers['x-access-token'];
      var tokenFromResponse = response.data['accessToken'];
      //print('My token$token');
      Map<String, dynamic> userInfo = JwtDecoder.decode(tokenFromResponse);
      print("User info: $userInfo");
      print("Registration response: ${response.data['accessToken']}");
      if (response.statusCode != 200) {
        throw Exception(response.statusMessage);
      } else {
        LoginResponse logInResponse = LoginResponse.fromJson(response.data);
        return logInResponse;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        //Request reached server but failed
        print('Dio e.response: ${e.response!.data}');
        print('Dio e.response: ${e.response!.data['message']}');
        throw Exception(e.response?.data['message']);
      } else {
        //If you're offfline and request did not reach server
        String? errorMessage = e.message;
        print(e);
        int colonIndex = errorMessage!.indexOf(':');
        String extractedPart = errorMessage.substring(0, colonIndex).trim();
        print('Response.data${e.response?.data}');
        throw Exception(extractedPart);
      }
    } catch (err, stackTrace) {
      print(stackTrace);
      print('In Here${err.toString()}');
      rethrow;
    }
  }

  //Live donations

  Future<LiveDonations> liveDonations() async {
    try {
      print('MyTokennn$token');
      // options.headers!.addAll();
      Response response = await _dio.post(liveDonationUrl,
          options: Options(
            method: "POST",
            contentType: 'application/json; charset=utf-8',
            headers: {'Accept': 'application/json', 'x-access-token': token},
            validateStatus: (_) => true,
          ));
      print("LiveDonation response: ${response.data}");
      if (response.statusCode != 200) {
        throw Exception(response.statusMessage);
      } else {
        LiveDonations liveDonations = LiveDonations.fromJson(response.data);
        return liveDonations;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        //Request reached server but failed
        print('Dio e.response: ${e.response!.data}');
        print('Dio e.response: ${e.response!.data['message']}');
        throw Exception(e.response?.data['message']);
      } else {
        //If you're offfline and request did not reach server
        String? errorMessage = e.message;
        int colonIndex = errorMessage!.indexOf(':');
        String extractedPart = errorMessage.substring(0, colonIndex).trim();
        print('Response.data${e.response?.data}');
        throw Exception(extractedPart);
      }
    } catch (err, stackTrace) {
      print(stackTrace);
      print('In Here${err.toString()}');
      rethrow;
    }
  }

  //User Donation

  Future<UserDonations> userDonations() async {
    try {
      Response response = await _dio.post(userDonationUrl,
          options: Options(
            method: "POST",
            contentType: 'application/json; charset=utf-8',
            headers: {'Accept': 'application/json', 'x-access-token': token},
            validateStatus: (_) => true,
          ));

      print("LiveDonation response: ${response.data}");
      if (response.statusCode != 200) {
        throw Exception(response.statusMessage);
      } else {
        UserDonations liveDonations = UserDonations.fromJson(response.data);
        return liveDonations;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        //Request reached server but failed
        print('Dio e.response: ${e.response!.data}');
        print('Dio e.response: ${e.response!.data['message']}');
        throw Exception(e.response?.data['message']);
      } else {
        //If you're offfline and request did not reach server
        String? errorMessage = e.message;
        int colonIndex = errorMessage!.indexOf(':');
        String extractedPart = errorMessage.substring(0, colonIndex).trim();
        print('Response.data${e.response?.data}');
        throw Exception(extractedPart);
      }
    } catch (err, stackTrace) {
      print(stackTrace);
      print('In Here${err.toString()}');
      rethrow;
    }
  }

  //Food Creation

  Future<FoodResponse> foodCreationResponse(
      Map<String, dynamic> foodData) async {
    try {
      Response response = await _dio.post(userFoodCreationUrl,
          data: foodData,
          options: Options(
            method: "POST",
            contentType: 'application/json; charset=utf-8',
            headers: {'Accept': 'application/json', 'x-access-token': token},
            validateStatus: (_) => true,
          ));

      print("LiveDonation response: ${response.data}");
      if (response.statusCode != 200) {
        throw Exception(response.statusMessage);
      } else {
        FoodResponse liveDonations = FoodResponse.fromJson(response.data);
        return liveDonations;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        //Request reached server but failed
        print('Dio e.response: ${e.response!.data}');
        print('Dio e.response: ${e.response!.data['message']}');
        throw Exception(e.response?.data['message']);
      } else {
        //If you're offfline and request did not reach server
        String? errorMessage = e.message;
        int colonIndex = errorMessage!.indexOf(':');
        String extractedPart = errorMessage.substring(0, colonIndex).trim();
        print('Response.data${e.response?.data}');
        throw Exception(extractedPart);
      }
    } catch (err, stackTrace) {
      print(stackTrace);
      print('In Here${err.toString()}');
      rethrow;
    }
  }

  //Order Reservation

  Future<OrderReservationResponse> orderReservation(
      Map<String, dynamic> foodId) async {
    try {
      Response response = await _dio.post(foodReservation,
          data: foodId,
          options: Options(
            method: "POST",
            contentType: 'application/json; charset=utf-8',
            headers: {'Accept': 'application/json', 'x-access-token': token},
            validateStatus: (_) => true,
          ));

      print("LiveDonation response: ${response.data}");
      if (response.statusCode != 200) {
        throw Exception(response.statusMessage);
      } else {
        OrderReservationResponse orderReservation =
            OrderReservationResponse.fromJson(response.data);
        return orderReservation;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        //Request reached server but failed
        print('Dio e.response: ${e.response!.data}');
        print('Dio e.response: ${e.response!.data['message']}');
        throw Exception(e.response?.data['message']);
      } else {
        //If you're offfline and request did not reach server
        String? errorMessage = e.message;
        int colonIndex = errorMessage!.indexOf(':');
        String extractedPart = errorMessage.substring(0, colonIndex).trim();
        print('Response.data${e.response?.data}');
        throw Exception(extractedPart);
      }
    } catch (err, stackTrace) {
      print(stackTrace);
      print('In Here${err.toString()}');
      rethrow;
    }
  }

// Profile Fetch
  Future<ProfileFetchModel> profileFetchDataSource() async {
    try {
      Response response = await _dio.post(profileFetch,
          options: Options(
            method: "POST",
            contentType: 'application/json; charset=utf-8',
            headers: {'Accept': 'application/json', 'x-access-token': token},
            validateStatus: (_) => true,
          ));

      print("Profile response: ${response.data}");
      if (response.statusCode != 200) {
        throw Exception(response.statusMessage);
      } else {
        ProfileFetchModel orderReservation =
            ProfileFetchModel.fromJson(response.data);
        return orderReservation;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        //Request reached server but failed
        print('Dio e.response: ${e.response!.data}');
        print('Dio e.response: ${e.response!.data['message']}');
        throw Exception(e.response?.data['message']);
      } else {
        //If you're offfline and request did not reach server
        String? errorMessage = e.message;
        int colonIndex = errorMessage!.indexOf(':');
        String extractedPart = errorMessage.substring(0, colonIndex).trim();
        print('Response.data${e.response?.data}');
        throw Exception(extractedPart);
      }
    } catch (err, stackTrace) {
      print(stackTrace);
      print('In Here${err.toString()}');
      rethrow;
    }
  }

  //Process-order
  Future<OrderResponse> processOrderByFoodOwner(
      {required Map<String, dynamic> orderData}) async {
    try {
      Response response = await _dio.post(processOrder,
          data: orderData,
          options: Options(
            method: "POST",
            contentType: 'application/json; charset=utf-8',
            headers: {'Accept': 'application/json', 'x-access-token': token},
            validateStatus: (_) => true,
          ));

      print("order verification response: ${response.data}");
      if (response.statusCode != 201) {
        throw Exception(response.statusMessage);
      } else {
        OrderResponse orderReservation = OrderResponse.fromJson(response.data);
        return orderReservation;
      }
    } on DioException catch (e) {
      if (e.response != null) {
        //Request reached server but failed
        print('Dio e.response: ${e.response!.data}');
        print('Dio e.response: ${e.response!.data['message']}');
        throw Exception(e.response?.data['message']);
      } else {
        //If you're offfline and request did not reach server
        String? errorMessage = e.message;
        int colonIndex = errorMessage!.indexOf(':');
        String extractedPart = errorMessage.substring(0, colonIndex).trim();
        print('Response.data${e.response?.data}');
        throw Exception(extractedPart);
      }
    } catch (err, stackTrace) {
      print(stackTrace);
      print('In Here${err.toString()}');
      rethrow;
    }
  }
}
