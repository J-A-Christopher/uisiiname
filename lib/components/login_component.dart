import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:usiiname/components/signup_component.dart';
import 'package:usiiname/components/user_first_route_component.dart';
import 'package:usiiname/features/loginfeature/model/login_body.dart';
import 'package:usiiname/features/loginfeature/presentation/bloc/login_bloc.dart';
import 'package:usiiname/features/signupfeature/presentation/bloc/sign_up_bloc.dart';
import 'package:usiiname/utils/storage_utils.dart';

class LoginComponentWrapper extends StatelessWidget {
  const LoginComponentWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(),
        child: const LoginComponent(),
      ),
    );
  }
}

class LoginComponent extends StatefulWidget {
  const LoginComponent({super.key});

  @override
  State<LoginComponent> createState() => _LoginComponentState();
}

final loginFormKey = GlobalKey<FormState>();

var username = '';
var password = '';

class _LoginComponentState extends State<LoginComponent> {
  @override
  Widget build(BuildContext context) {
    final mediQuery = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 15, right: 15),
      child: Form(
        key: loginFormKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Sign In: ',
              style: Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              onSaved: (value) {
                username = value!;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Usrname cannot be empty';
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
              onSaved: (value) {
                password = value!;
              },
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Password cannot be empty';
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
                  hintText: 'Password',
                  hintStyle: Theme.of(context)
                      .textTheme
                      .bodySmall
                      ?.copyWith(fontSize: 15)),
            ),
            const SizedBox(
              height: 10,
            ),
            TextButton(
                onPressed: () {},
                child: Text('Forgot password?',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 15, color: const Color(0xff23B8A6)))),
            const SizedBox(
              height: 10,
            ),
            SizedBox(
              width: 100,
              child: ElevatedButton(
                onPressed: () {
                  //submitLoginForm();
                  if (loginFormKey.currentState!.validate()) {
                    loginFormKey.currentState!.save();
                    final loginDetails =
                        LoginBody(password: password, username: username)
                            .toJson();
                    print(password);
                    print(username);

                    context
                        .read<LoginBloc>()
                        .add(OnLogin(loginResponse: loginDetails));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                ),
                child: const Text('LOGIN'),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            BlocListener<LoginBloc, LoginState>(
              listener: (context, state) {
                if (state is LoginLoaded) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const UserFirstRoute()));
                }
                if (state is LoginError) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              child:
                  BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
                if (state is LoginLoading) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
                if (state is LoginLoaded) {
                  final token = state.loginData.accessToken;
                  //final userId = state.loginData.id;
                  StorageUtils().writeUserInfo(key: 'token', userInfo: token);
                  // StorageUtils().writeUserInfo(key: 'uid', userInfo: userId);
                }
                return const SizedBox();
              }),
            ),
            const SizedBox(
              height: 30,
            ),
            const Stack(
              alignment: Alignment.center,
              children: [
                Divider(
                  color: Colors.black,
                  thickness: 1,
                ),
                CircleAvatar(
                  radius: 20,
                  backgroundColor: Color(0xff8FE1D7),
                  child: Text('OR'),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: mediQuery,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: SignUpBloc(),
                        child: const SignUpComponent(),
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff8FE1D7)),
                child: const Text(
                  'Sign Up',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
