import 'package:flutter/material.dart';
import 'package:usiiname/components/confirm_request.dart';

class DonationRequets extends StatelessWidget {
  const DonationRequets({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Donation Requets'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 15, right: 15),
        child: ListView(
          children: [
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ConfirmRequest()));
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Flexible(
                          flex: 1, child: Image.asset('assets/avatar.png')),
                      const SizedBox(
                        width: 10,
                      ),
                      const Flexible(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Youth Red Cross VEC',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                                'We are in need of 15 food packets in Eldoret Kenya.\nLocation before 1:30 PM. \n5 hours ago.'),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ConfirmRequest()));
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Flexible(
                          flex: 1, child: Image.asset('assets/avatar.png')),
                      const SizedBox(
                        width: 10,
                      ),
                      const Flexible(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Youth Red Cross VEC',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                                'We are in need of 15 food packets in Eldoret Kenya.\nLocation before 1:30 PM. \n5 hours ago.'),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ConfirmRequest()));
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Flexible(
                          flex: 1, child: Image.asset('assets/avatar.png')),
                      const SizedBox(
                        width: 10,
                      ),
                      const Flexible(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Youth Red Cross VEC',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                                'We are in need of 15 food packets in Eldoret Kenya.\nLocation before 1:30 PM. \n5 hours ago.'),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ConfirmRequest()));
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Flexible(
                          flex: 1, child: Image.asset('assets/avatar.png')),
                      const SizedBox(
                        width: 10,
                      ),
                      const Flexible(
                        flex: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Youth Red Cross VEC',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Text(
                                'We are in need of 15 food packets in Eldoret Kenya.\nLocation before 1:30 PM. \n5 hours ago.'),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
