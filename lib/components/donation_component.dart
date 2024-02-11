import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:usiiname/components/user_first_route_component.dart';
import 'package:usiiname/features/createfood/models/create_food_model.dart';
import 'package:usiiname/features/createfood/presentation/bloc/food_creation_bloc.dart';

class DonationComponent extends StatefulWidget {
  const DonationComponent({super.key});

  @override
  State<DonationComponent> createState() => _DonationComponentState();
}

class _DonationComponentState extends State<DonationComponent> {
  String selectedValue = "Yes";
  String? pickedImage;
  UploadTask? uploadTask;
  bool isLoading = false;
  var foodName = '';
  var timeOfPreparation = '';
  var timeRequiredForDelivery = '';
  var foodQuantity = '';
  var address = '';
  final foodDetailsForm = GlobalKey<FormState>();
  TextEditingController addressController =
      TextEditingController(text: 'Ngeria mess');
  TextEditingController prepDateController = TextEditingController();
  TextEditingController prepTimeController = TextEditingController();
  TextEditingController deliveryTimeController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  Future<void> getImage() async {
    final ImagePicker picker = ImagePicker();
    setState(() {
      isLoading = true;
    });
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 0);
    if (pickedFile != null) {
      final extension = pickedFile.path.split('.').last;
      final name = 'food-${DateTime.now()}.$extension';
      final storageReference = FirebaseStorage.instance.ref();
      final foodRef = storageReference.child('food/$name');
      uploadTask = foodRef.putFile(File(pickedFile.path).absolute,
          SettableMetadata(contentType: 'image/$extension'));
      final snapShot = await uploadTask?.whenComplete(() => null);
      final downLoadUrl = await snapShot?.ref.getDownloadURL();
      setState(() {
        pickedImage = downLoadUrl;
        isLoading = false;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        prepTimeController.text = picked.format(context);
      });
    }
  }

  Future<void> _selectDeliveryTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null && picked != selectedTime) {
      setState(() {
        deliveryTimeController.text = picked.format(context);
      });
    }
  }

  void submitForm() {
    if (foodDetailsForm.currentState!.validate() && pickedImage != null) {
      foodDetailsForm.currentState!.save();
      final foodData = FoodResponse(
              address: address,
              dateOfPreparation: prepDateController.text,
              imageUrl: pickedImage,
              name: foodName,
              quantity: foodQuantity,
              timeRequiredForDelivery: deliveryTimeController.text,
              timeOfPreparation: prepTimeController.text,
              utensilsRequired: selectedValue,
              donationType: null)
          .toJson();
      context
          .read<FoodCreationBloc>()
          .add(OnFoodCreation(foodFormationData: foodData));
      deliveryTimeController.clear();
      prepDateController.clear();
      prepDateController.clear();
      foodDetailsForm.currentState!.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Make a Donation'),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20.0, left: 15, right: 15),
        child: Form(
          key: foodDetailsForm,
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
                  image: pickedImage != null
                      ? DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(pickedImage ?? ''))
                      : null,
                ),
                child: Center(
                  child: isLoading
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Color(0xff5BDDCD)),
                        )
                      : Text(
                          'Take a picture of your food.',
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall
                              ?.copyWith(fontSize: 15),
                        ),
                ),
              ),
              TextButton.icon(
                  onPressed: isLoading
                      ? null
                      : () async {
                          await getImage();
                        },
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
                onSaved: (value) {
                  foodName = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Food name cannot be empty';
                  }
                  return null;
                },
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
                readOnly: true,
                onTap: () async {
                  DateTime? pickedDate = await showDatePicker(
                      context: context,
                      firstDate: DateTime.now(),
                      lastDate: DateTime(2025));
                  if (pickedDate != null) {
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    setState(() {
                      prepDateController.text = formattedDate;
                    });
                  }
                },
                onSaved: (value) {
                  timeOfPreparation = value!;
                },
                controller: prepDateController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Date of preparation cannot be empty';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(5),
                    filled: true,
                    fillColor: Colors.white,
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20)),
                    hintText: 'Date of Preparation',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontSize: 15)),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                readOnly: true,
                onTap: () async {
                  _selectTime(context);
                },
                onSaved: (value) {
                  timeOfPreparation = value!;
                },
                controller: prepTimeController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Time of preparation cannot be empty';
                  }
                  return null;
                },
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
                readOnly: true,
                onTap: () {
                  _selectDeliveryTime(context);
                },
                controller: deliveryTimeController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Time required for delivery cannot be empty';
                  }
                  return null;
                },
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
                onSaved: (value) {
                  foodQuantity = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Quantity cannot be empty';
                  }
                  return null;
                },
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
                readOnly: true,
                onSaved: (value) {
                  address = value!;
                },
                controller: addressController,
                maxLines: 2,
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
                onPressed: () {
                  submitForm();
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff8FE1D7)),
                child: const Text(
                  'Submit',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              BlocListener<FoodCreationBloc, FoodCreationState>(
                listener: (context, state) {
                  if (state is FoodCreationError) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.message)));
                  }
                  if (state is FoodCreationLoaded) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Food Created Successfully')));
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const UserFirstRoute()));
                  }
                },
                child: BlocBuilder<FoodCreationBloc, FoodCreationState>(
                    builder: (context, state) {
                  if (state is FoodCreationLoading) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xff8FE1D7),
                      ),
                    );
                  }
                  return const SizedBox();
                }),
              ),
              const SizedBox(
                height: 40,
              )
            ],
          ),
        ),
      ),
    );
  }
}
