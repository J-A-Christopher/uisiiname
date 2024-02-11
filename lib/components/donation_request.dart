
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class DonationRequests extends StatefulWidget {
  const DonationRequests({super.key});

  @override
  State<DonationRequests> createState() => _DonationRequestsState();
}

class _DonationRequestsState extends State<DonationRequests> {
  List<RemoteMessage> messages = [];

  @override
  Widget build(BuildContext context) {
    // final messages =
    //     ModalRoute.of(context)!.settings.arguments as List<RemoteMessage>?;

    return Scaffold(
        appBar: AppBar(
          title: const Text('Donation Request'),
        ),
        body: messages.isEmpty
            ? const Center(
                child: Text('No donation request here'),
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(messages[index].data['imageUrl'])),
                    title: Text('${messages[index].data['foodName']}'),
                    subtitle:
                        Text('Ordered by: ${messages[index].data['name']}'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.check)),
                        IconButton(
                            onPressed: () {}, icon: const Icon(Icons.close))
                      ],
                    ),
                  );
                },
                itemCount: messages.length,
              ));
  }
}
