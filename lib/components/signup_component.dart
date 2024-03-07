import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:usiiname/components/login_component.dart';
import 'package:usiiname/features/signupfeature/model/sign_up_model.dart';
import 'package:usiiname/features/signupfeature/presentation/bloc/sign_up_bloc.dart';
import 'package:usiiname/utils/fcm_manager.dart';

class SignUpComponent extends StatefulWidget {
  const SignUpComponent({super.key});

  @override
  State<SignUpComponent> createState() => _SignUpComponentState();
}

class _SignUpComponentState extends State<SignUpComponent> {
  final formKey = GlobalKey<FormState>();
  String selectedValue = "Individual";
  TextEditingController passwordController = TextEditingController();
  var firstName = '';
  var lastName = '';
  var userName = '';
  var phoneNumber = '';
  var email = '';
  var password = '';
  String? pickedImage;
  UploadTask? uploadTask;
  bool isLoading = false;
  Future<void> getImage() async {
    final ImagePicker picker = ImagePicker();
    setState(() {
      isLoading = true;
    });
    final pickedFile =
        await picker.pickImage(source: ImageSource.camera, imageQuality: 10);
    if (pickedFile != null) {
      final extension = pickedFile.path.split('.').last;
      final name = 'profile-${DateTime.now()}.$extension';
      final storageReference = FirebaseStorage.instance.ref();
      final foodRef = storageReference.child('profile/$name');
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

  void submitSignUpForm() async {
    if (formKey.currentState!.validate() && pickedImage != null) {
      formKey.currentState!.save();
      var fcmToken = await FCMManager().initNotifications();
      var signUpData = UserData(
              id: null,
              createdAt: null,
              donationType: selectedValue,
              email: email,
              firstname: firstName,
              lastname: lastName,
              password: password,
              phoneNumber: phoneNumber,
              pushToken: fcmToken,
              updatedAt: null,
              username: userName,
              profilePicture: pickedImage)
          .toJson();

      if (context.mounted) {
        context.read<SignUpBloc>().add(OnSignUp(userData: signUpData));
        passwordController.clear();
        formKey.currentState!.reset();
      }
    }
    if (pickedImage == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Please take an image before proceeding..')));
        print(pickedImage);
        return;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediQuery = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50.0, left: 15, right: 15),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              Text(
                'Register: ',
                style: Theme.of(context)
                    .textTheme
                    .displaySmall
                    ?.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 10,
              ),
              Center(
                child: CircleAvatar(
                  radius: 40,
                  child: isLoading
                      ? const CircularProgressIndicator()
                      : pickedImage == null
                          ? null
                          : ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(50)),
                              child: Image.network(
                                '$pickedImage',
                                width: 80,
                                fit: BoxFit.cover,
                              ),
                            ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    getImage();
                  },
                  icon: const Icon(
                    Icons.camera_alt,
                    size: 40,
                  )),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                onSaved: (value) {
                  firstName = value!;
                },
                validator: (value) {
                  if (value!.length < 3 || value.contains(RegExp(r'[0-9]'))) {
                    return 'Invalid First name. Input should be atleast 3 characters.';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(5),
                    filled: true,
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'First Name',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontSize: 15)),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.length < 3 || value.contains(RegExp(r'[0-9]'))) {
                    return 'Invalid Last name. Input should be atleast 3 characters.';
                  }
                  return null;
                },
                onSaved: (value) {
                  lastName = value!;
                },
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(5),
                    filled: true,
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'Last Name',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontSize: 15)),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.length < 2) {
                    return 'Invalid User name. Input should be atleast 2 characters.';
                  }
                  return null;
                },
                onSaved: (value) {
                  userName = value!;
                },
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(5),
                    filled: true,
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'Username',
                    hintStyle: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontSize: 15)),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.length < 10 ||
                      value.contains(RegExp(r'[a-zA-Z]')) ||
                      value.length > 10) {
                    return 'Invalid phone number.';
                  }
                  return null;
                },
                onSaved: (value) {
                  phoneNumber = value!;
                },
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(5),
                    filled: true,
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'Phone Number',
                    hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 15,
                        )),
              ),
              const SizedBox(
                height: 10,
              ),
              Text('Join As  An:',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 10,
              ),
              RadioListTile<String>.adaptive(
                value: "Organization",
                groupValue: selectedValue,
                onChanged: (value) {
                  setState(() {
                    selectedValue = value!;
                  });
                },
                title: Text(
                  'Organization',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontSize: 15),
                ),
              ),
              RadioListTile<String>.adaptive(
                value: "Individual",
                groupValue: selectedValue,
                onChanged: (value) {
                  print('Selected Value: $value');
                  setState(() {
                    selectedValue = value!;
                  });
                },
                title: Text(
                  'Individual',
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontSize: 15),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                validator: (value) {
                  if (value!.length < 5 ||
                      !value.contains('@') ||
                      !value.contains('.com')) {
                    return 'Invalid Email.';
                  }
                  return null;
                },
                onSaved: (value) {
                  email = value!;
                },
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(5),
                    filled: true,
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'Email',
                    hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 15,
                        )),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: passwordController,
                validator: (value) {
                  if (value!.length < 5) {
                    return 'Invalid Password. Input should be atleast 5 characters.';
                  }
                  return null;
                },
                onSaved: (value) {
                  password = value!;
                },
                obscureText: true,
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(5),
                    filled: true,
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'Password',
                    hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 15,
                        )),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                obscureText: true,
                validator: (value) {
                  if (passwordController.text != value) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.all(5),
                    filled: true,
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(10)),
                    hintText: 'Confirm Password',
                    hintStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
                          fontSize: 15,
                        )),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: mediQuery,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    submitSignUpForm();
                  },
                  child: const Text(
                    'Submit',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              BlocListener<SignUpBloc, SignUpState>(
                listener: (context, state) {
                  if (state is SignUpError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.errorMessage)));
                  }
                  if (state is SignUpLoaded) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('${state.successUser.message}')));
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const LoginComponentWrapper()));
                  }
                },
                child: BlocBuilder<SignUpBloc, SignUpState>(
                    builder: (context, state) {
                  if (state is SignUpLoading) {
                    return const Center(
                        child: CircularProgressIndicator(
                      color: Colors.red,
                    ));
                  }
                  return const SizedBox();
                }),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) =>
                                const LoginComponentWrapper()));
                      },
                      child: Text(
                        'Sign in instead',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              fontSize: 15,
                            ),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
