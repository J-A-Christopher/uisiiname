import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:usiiname/components/signup_component.dart';
import 'package:usiiname/components/user_first_route_component.dart';
import 'package:usiiname/features/signupfeature/presentation/bloc/sign_up_bloc.dart';

class LoginComponent extends StatefulWidget {
  const LoginComponent({super.key});

  @override
  State<LoginComponent> createState() => _LoginComponentState();
}

class _LoginComponentState extends State<LoginComponent> {
  @override
  Widget build(BuildContext context) {
    final mediQuery = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0, left: 15, right: 15),
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
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const UserFirstRoute()));
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
