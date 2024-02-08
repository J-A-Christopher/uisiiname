import 'package:flutter/material.dart';
import 'package:usiiname/components/donation_component.dart';
import 'package:usiiname/components/donation_request.dart';
import 'package:usiiname/components/profile_component.dart';
import 'package:usiiname/components/your_donation_component.dart';

class UserFirstRoute extends StatelessWidget {
  const UserFirstRoute({super.key});

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
              builder: (context) => const ProfileComponent()));
        },
        child: const Icon(
          Icons.person,
          size: 35,
          color: Color(0xff5BDDCD),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0, left: 15, right: 15),
        child: ListView(
          children: [
            Center(
              child: Text(
                'Welcome Back \nSaravana bavan !',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: mediaQuery.height * 0.6,
              child: Image.asset('assets/restaurant.png'),
            ),
            SizedBox(
              width: mediaQuery.width,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const DonationComponent()));
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
                      builder: (context) => const YourDonationsWrapper()));
                },
                style: ElevatedButton.styleFrom(
                    elevation: 5,
                    backgroundColor: Colors.white,
                    side: const BorderSide(color: Colors.black)),
                child: Text(
                  'Your Donations',
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
                      builder: (context) => const DonationRequets()));
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
    );
  }
}
