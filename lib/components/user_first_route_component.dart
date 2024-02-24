import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:usiiname/components/donation_component.dart';
import 'package:usiiname/components/donation_request.dart';
import 'package:usiiname/components/profile_component.dart';
import 'package:usiiname/components/your_donation_component.dart';
import 'package:usiiname/features/createfood/presentation/bloc/food_creation_bloc.dart';
import 'package:usiiname/features/loginfeature/presentation/bloc/login_bloc.dart';
import 'package:usiiname/features/profilefetch/presentation/bloc/profile_fetch_bloc.dart';
import 'package:usiiname/utils/bottom_nav_bar.dart';
import 'package:usiiname/utils/storage_utils.dart';

class UserFirstRoute extends StatefulWidget {
  const UserFirstRoute({
    super.key,
  });

  @override
  State<UserFirstRoute> createState() => _UserFirstRouteState();
}

class _UserFirstRouteState extends State<UserFirstRoute> {
  String? username;
  String? imageUrl;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      username = await StorageUtils().getUserInfo(key: 'username');
      String? token = await StorageUtils().getUserInfo(key: 'token');
      var decodeToken = JwtDecoder.decode(token!);
      print(decodeToken);
      setState(() {
        imageUrl = decodeToken['user']['profilePicture'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10))),
        backgroundColor: const Color(0xffD6E2DF),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => BlocProvider(
                    create: (_) => ProfileFetchBloc(),
                    child: const ProfileComponent(),
                  )));
        },
        child: const Icon(
          Icons.person,
          size: 35,
          color: Color(0xff5BDDCD),
        ),
      ),
      body: BlocProvider.value(
        value: LoginBloc(),
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0, left: 15, right: 15),
          child: ListView(
            children: [
              Center(
                child: Text(
                  username == null ? 'Hi there' : 'Welcome Back \n$username !',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontSize: 25, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: mediaQuery.height * 0.6,
                child: imageUrl == null
                    ? Image.asset('assets/placeholder1.jpg')
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CachedNetworkImage(
                          imageUrl: imageUrl!,
                          placeholder: (context, url) {
                            return const Center(
                                child: CircularProgressIndicator(
                              color: Color(0xff8FE1D7),
                            ));
                          },
                        ),
                      ),
              ),
              SizedBox(
                width: mediaQuery.width,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => BlocProvider(
                              create: (_) => FoodCreationBloc(),
                              child: const DonationComponent(),
                            )));
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.black)),
                  child: Text(
                    'Make a Donation',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontSize: 15),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: mediaQuery.width,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const BottomNavgBar()
                        //const YourDonationsWrapper()
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.black)),
                  child: Text(
                    'Donations',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontSize: 15),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const DonationRequests()));
                  },
                  style: ElevatedButton.styleFrom(
                      elevation: 5,
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.black)),
                  child: Text(
                    'Donation Requests',
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontSize: 15),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
