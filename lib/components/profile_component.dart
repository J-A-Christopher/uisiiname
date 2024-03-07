import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:usiiname/components/login_component.dart';
import 'package:usiiname/components/reusable_profile_comp.dart';
import 'package:usiiname/features/profilefetch/presentation/bloc/profile_fetch_bloc.dart';
import 'package:usiiname/main.dart';
import 'package:usiiname/utils/storage_utils.dart';

class ProfileComponent extends ConsumerStatefulWidget {
  const ProfileComponent({super.key});

  @override
  ConsumerState<ProfileComponent> createState() => _ProfileComponentState();
}

class _ProfileComponentState extends ConsumerState<ProfileComponent> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileFetchBloc>().add(ProfileFetch());
  }

  @override
  Widget build(BuildContext context) {
    final themeWatcher = ref.watch(themeStateProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                onPressed: () {
                  ref.read(themeStateProvider.notifier).state =
                      !ref.read(themeStateProvider);
                },
                icon: themeWatcher
                    ? const Icon(Icons.light_mode)
                    : const Icon(Icons.dark_mode)),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 15, right: 15),
        child: ListView(
          children: [
            BlocBuilder<ProfileFetchBloc, ProfileFetchState>(
              builder: (context, state) {
                if (state is ProfileFetchLoaded) {
                  final userObject = state.profileData.userModel;
                  return Column(
                    children: [
                      Center(
                          child: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                        child: CachedNetworkImage(
                            imageUrl: '${userObject!.profilePicture}',
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error)),
                      )),
                      Text(
                        '${userObject.firstname}',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 28),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Contact: ${userObject.phoneNumber}',
                        style: const TextStyle(
                          fontSize: 19,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ReusableContainer(
                          iconToBeUsed: const Icon(Icons.person),
                          text: 'Edit Profile',
                          onpresssed: () {}),
                      const SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
            ReusableContainer(
                iconToBeUsed: const Icon(Icons.star),
                text: 'About',
                onpresssed: () {}),
            const SizedBox(
              height: 10,
            ),
            ReusableContainer(
                iconToBeUsed: const Icon(Icons.description),
                text: 'Terms & Privacy Policy',
                onpresssed: () {}),
            const SizedBox(
              height: 10,
            ),
            ReusableContainer(
                iconToBeUsed: const Icon(Icons.logout),
                text: 'Logout',
                onpresssed: () async {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Logout', style: TextStyle()),
                          content:
                              const Text('Are you sure you wanna log out?'),
                          actions: [
                            TextButton(
                                onPressed: () async {
                                  await StorageUtils().logoutUser();
                                  if (context.mounted) {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginComponentWrapper()));
                                  }
                                },
                                child: const Text(
                                  'Yes',
                                  style: TextStyle(),
                                )),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('No', style: TextStyle())),
                          ],
                        );
                      });
                }),
          ],
        ),
      ),
    );
  }
}
