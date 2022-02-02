import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:manager_app/src/models/user.dart';
import 'package:manager_app/src/repositories/users_repository.dart';
import 'package:manager_app/src/screens/splash/splash.dart';
import 'package:validators/validators.dart';

class RegisterScreen extends StatelessWidget {
  static MaterialPageRoute route() => MaterialPageRoute(
        builder: (context) => const RegisterScreen(),
      );

  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
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
                      if (user.name == value) return 'Username already in use';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(labelText: 'Username'),
                ),
                FormBuilderTextField(
                  name: 'password',
                  obscureText: true,
                  validator: (value) =>
                      (value ?? '').isNotEmpty ? null : 'Must not be empty',
                  decoration: const InputDecoration(labelText: 'Password'),
                ),
                FormBuilderTextField(
                  name: 'email',
                  validator: (value) =>
                      isEmail(value ?? '') ? null : 'Must be a valid E-mail',
                  decoration: const InputDecoration(labelText: 'E-mail'),
                ),
                Builder(builder: (context) {
                  return ElevatedButton(
                    onPressed: () async {
                      if (FormBuilder.of(context)!.validate()) {
                        FormBuilder.of(context)!.save();
                        await UsersRepository().register(
                          UserModel(
                            name: FormBuilder.of(context)!.value['name'],
                            password:
                                FormBuilder.of(context)!.value['password'],
                            email: FormBuilder.of(context)!.value['email'],
                          ),
                        );
                        Navigator.of(context).pushAndRemoveUntil(
                            SplashScreen.route(), (route) => false);
                      }
                    },
                    child: const Text('Register'),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
