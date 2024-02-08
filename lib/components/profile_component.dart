import 'package:flutter/material.dart';
import 'package:usiiname/components/login_component.dart';
import 'package:usiiname/components/reusable_profile_comp.dart';
import 'package:usiiname/utils/storage_utils.dart';

class ProfileComponent extends StatelessWidget {
  const ProfileComponent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // floatingActionButton: FloatingActionButton(

      //   onPressed: () {},
      //   child: const Row(children: [Icon(Icons.share), Text('Share App')]),
      // ),
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 15, right: 15),
        child: Column(
          children: [
            Center(child: Image.asset('assets/profile.png')),
            const Text(
              'Youth Red Cross VEC',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Non Governmental Organization',
              style: TextStyle(fontSize: 19, color: Color(0xffA1A1A1)),
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
            ReusableContainer(
                iconToBeUsed: const Icon(Icons.star),
                text: 'About',
                onpresssed: () {}),
            const SizedBox(
              height: 10,
            ),
            ReusableContainer(
                iconToBeUsed: const Icon(Icons.settings),
                text: 'Settings',
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
                          title: const Text('Logout',
                              style: TextStyle(color: Color(0xff8FE1D7))),
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
                                  style: TextStyle(color: Color(0xff8FE1D7)),
                                )),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('No',
                                    style: TextStyle(color: Color(0xff8FE1D7))))
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
