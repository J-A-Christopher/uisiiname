import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class DonationComponent extends StatefulWidget {
  const DonationComponent({super.key});

  @override
  State<DonationComponent> createState() => _DonationComponentState();
}

class _DonationComponentState extends State<DonationComponent> {
  String selectedValue = "Yes";
  String? pickedFile;
  Future<void> getImage() async {
    final ImagePicker picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        pickedFile = pickedImage!.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Make a Donation'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0, left: 15, right: 15),
        child: ListView(
          children: [
            Text(
              'Food Details: ',
              style: Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  color: Colors.white,
                  image:
                      DecorationImage(image: NetworkImage(pickedFile ?? ''))),
              child: Center(
                child: Text(
                  'Take a picture of your food.',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontSize: 15),
                ),
              ),
            ),
            TextButton.icon(
                onPressed: () {},
                icon: const Icon(
                  Icons.camera_alt,
                  color: Colors.black,
                ),
                label: Text(
                  'Take  picture',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontSize: 15, color: Colors.black),
                )),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(5),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20)),
                  hintText: 'Food Name',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontSize: 15)),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(5),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20)),
                  hintText: 'Time of Preparation',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontSize: 15)),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(5),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20)),
                  hintText: 'Time required for Delivery',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontSize: 15)),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(5),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20)),
                  hintText: 'Quantity',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontSize: 15)),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              maxLines: 3,
              decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(5),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(20)),
                  hintText: 'Address',
                  hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 15,
                      )),
            ),
            const SizedBox(
              height: 10,
            ),
            Text('Utensils Required:',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 10,
            ),
            RadioListTile<String>.adaptive(
              value: "Yes",
              groupValue: selectedValue,
              onChanged: (value) {
                print('Selected Value: $value');
                setState(() {
                  selectedValue = value!;
                });
              },
              title: Text(
                'Yes',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontSize: 15),
              ),
            ),
            RadioListTile<String>.adaptive(
              value: "No",
              groupValue: selectedValue,
              onChanged: (value) {
                print('Selected Value: $value');
                setState(() {
                  selectedValue = value!;
                });
              },
              title: Text(
                'No',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall
                    ?.copyWith(fontSize: 15),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xff8FE1D7)),
              child: const Text(
                'Submit',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            const SizedBox(
              height: 15,
            )
          ],
        ),
      ),
    );
  }
}
