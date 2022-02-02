import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:manager_app/src/repositories/users_repository.dart';
import 'package:manager_app/src/screens/auth/register.dart';
import 'package:manager_app/src/screens/splash/splash.dart';

class LoginScreen extends StatelessWidget {
  static MaterialPageRoute route() => MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      );

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: FormBuilder(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FormBuilderTextField(
                  name: 'name',
                  validator: (value) {
                    if ((value ?? '').isEmpty) return 'Must not be empty';

                    for (final user in UsersRepository().readAllUser()) {
                      if (user.name == value) return null;
                    }
                    return 'Username not found';
                  },
                  decoration: const InputDecoration(labelText: 'Username'),
                ),
                FormBuilderTextField(
                  name: 'password',
                  validator: (value) =>
                      (value ?? '').isNotEmpty ? null : 'Must not be empty',
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password'),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () =>
                          Navigator.of(context).push(RegisterScreen.route()),
                      child: const Text('Register'),
                    ),
                    const SizedBox(width: 10),
                    Builder(builder: (context) {
                      return ElevatedButton(
                        onPressed: () async {
                          if (FormBuilder.of(context)!.validate()) {
                            FormBuilder.of(context)!.save();
                            await UsersRepository().login(
                              FormBuilder.of(context)!.value['name'],
                              FormBuilder.of(context)!.value['password'],
                            );

                            Navigator.of(context).pushAndRemoveUntil(
                                SplashScreen.route(), (route) => false);
                          }
                        },
                        child: const Text('Login'),
                      );
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
