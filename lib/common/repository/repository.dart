import 'package:usiiname/common/datasources/datasouces.dart';
import 'package:usiiname/features/createfood/models/create_food_model.dart';
import 'package:usiiname/features/first-order-processing/models/first_order_processing_response.dart';
import 'package:usiiname/features/liveDonations/models/ive_donations_model.dart';
import 'package:usiiname/features/loginfeature/model/login_response.dart';
import 'package:usiiname/features/profilefetch/models/profile_fetch.dart';
import 'package:usiiname/features/signupfeature/model/sign_up_model.dart';
import 'package:usiiname/features/userDonations/model/userdonations_model.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<SignUpModelResponse> signUpUser({required userSignUpData}) async {
    return _provider.createUser(userSignUpData: userSignUpData);
  }

  Future<LoginResponse> loginUser({required userLoginData}) async {
    return _provider.userLogin(userLoginData: userLoginData);
  }

  Future<LiveDonations> liveDonations() async {
    return _provider.liveDonations();
  }

  Future<UserDonations> userDonations() async {
    return _provider.userDonations();
  }

  Future<FoodResponse> createFood(Map<String, dynamic> foodData) async {
    return _provider.foodCreationResponse(foodData);
  }

  Future<OrderReservationResponse> orderFood(
      Map<String, dynamic> foodId) async {
    return _provider.orderReservation(foodId);
  }

  Future<ProfileFetchModel> fetchProfile() async {
    return _provider.profileFetchDataSource();
  }
}
