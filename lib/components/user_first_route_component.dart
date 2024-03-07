import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:usiiname/components/donation_component.dart';
import 'package:usiiname/components/donation_request.dart';
import 'package:usiiname/components/onboarding_cubit.dart';
import 'package:usiiname/components/profile_component.dart';
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
      body: BlocProvider.value(
        value: LoginBloc(),
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0, left: 15, right: 15),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Row(
                  children: [
                    Text(
                      username == null
                          ? 'Hi there'
                          : 'Welcome Back $username !',
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Expanded(
                      child: IconButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MultiBlocProvider(
                                      providers: [
                                        BlocProvider(
                                          create: (_) => ProfileFetchBloc(),
                                        ),
                                        BlocProvider(
                                          create: (_) => OnboardingCubit(),
                                        ),
                                      ],
                                      child: const ProfileComponent(),
                                    )));
                          },
                          icon: Icon(
                            Icons.settings,
                            size: 30,
                            color: Theme.of(context).primaryColor,
                          )),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: mediaQuery.height * 0.6,
                child: imageUrl == null
                    ? Image.asset('assets/placeholder1.jpg')
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: CachedNetworkImage(
                            imageUrl: imageUrl!,
                            fit: BoxFit.cover,
                            placeholder: (context, url) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            },
                          ),
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
                  ),
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
                  ),
                  child: Text(
                    'Donations & Features',
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
                  ),
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
