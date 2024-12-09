import 'package:dropdown_search/dropdown_search.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:proper_life/components/privacy_policy_dialog.dart';
import 'package:proper_life/domain/event_repository/lib/src/models/cities.dart';
import 'package:proper_life/generated/l10n.dart';
import 'package:proper_life/theme/theme.dart';

class AuthForm extends StatelessWidget {
  const AuthForm({
    super.key,
    required this.onAuth,
    required this.authButtonText,
    required this.emailController,
    required this.passwordController,
  });

  final VoidCallback onAuth;
  final String authButtonText;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  void _signInButton() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      Fluttertoast.showToast(
          msg: S.current.pleaseEnterBothEmailAndPassword,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 4,
          backgroundColor: const Color(0xffe7d9ff),
          textColor: const Color(0xbf000000),
          fontSize: 16.0);
      return;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      onAuth();
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Invalid email or password.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 4,
          backgroundColor: const Color(0xffe7d9ff),
          textColor: const Color(0xbf000000),
          fontSize: 16.0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 30,
        ),
        Center(
          child: Image.asset(
            'assets/images/pp_Logo.png',
            height: 200,
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        SizedBox(
          height: 50,
          child: FormBuilderTextField(
            name: 'email',
            controller: emailController,
            decoration: const InputDecoration(label: Text('Email')),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 50,
          child: FormBuilderTextField(
            obscureText: true,
            name: 'password',
            controller: passwordController,
            decoration: const InputDecoration(label: Text('Password')),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(theme.primaryColor),
            shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)))),
          ),
          onPressed: () {
            _signInButton();
          },
          child: SizedBox(
            width: 80,
            height: 50,
            child: Center(
                child: Text(authButtonText,
                    style: const TextStyle(color: Colors.white, fontSize: 18))),
          ),
        ),
      ],
    );
  }
}

class RegisterForm extends StatelessWidget {
  const RegisterForm({
    super.key,
    required this.onAuth,
    required this.authButtonText,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.nameController,
    required this.usernameController,
    required this.cityController,
  });

  final VoidCallback onAuth;
  final String authButtonText;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController nameController;
  final TextEditingController usernameController;
  final TextEditingController cityController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        const SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 50,
          child: FormBuilderTextField(
            name: 'name',
            controller: nameController,
            decoration:
                InputDecoration(label: Text(S.of(context).enterYourName)),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 50,
          child: FormBuilderTextField(
            name: 'userName',
            controller: usernameController,
            decoration: InputDecoration(
                prefixText: '@', label: Text(S.of(context).enterYourUsername)),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 60,
          child: DropdownSearch(
            items: citiesOptions,
            popupProps: const PopupProps.dialog(
              showSearchBox: true,
            ),
            dropdownDecoratorProps: DropDownDecoratorProps(
              baseStyle: theme.textTheme.bodyLarge,
              dropdownSearchDecoration:
                  InputDecoration(labelText: S.of(context).choseYourCity),
            ),
            onChanged: (dynamic val) {
              cityController.text = val;
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 50,
          child: FormBuilderTextField(
            name: 'email',
            controller: emailController,
            decoration: const InputDecoration(label: Text('Email')),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 50,
          child: FormBuilderTextField(
            obscureText: true,
            name: 'password',
            controller: passwordController,
            decoration: const InputDecoration(label: Text('Password')),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 50,
          child: FormBuilderTextField(
            obscureText: true,
            name: 'Confirm password',
            controller: confirmPasswordController,
            decoration: const InputDecoration(label: Text('Confirm password')),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: 'By creating an account, you are agreeing to our\n',
              style: theme.textTheme.bodyMedium,
              children: [
                TextSpan(
                  text: 'Privacy Policy',
                  style: theme.textTheme.bodyMedium!
                      .copyWith(color: theme.primaryColor),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return const PrivacyDialog(
                                mdFileName: 'privacy_policy.md');
                          });
                    },
                ),
                const TextSpan(text: ' and '),
                TextSpan(
                    text: 'Terms & Conditions!',
                    style: theme.textTheme.bodyMedium!
                        .copyWith(color: theme.primaryColor),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return const PrivacyDialog(
                                  mdFileName: 'terms&conditions.md');
                            });
                      }),
              ]),
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(theme.primaryColor),
            shape: MaterialStateProperty.all(const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12)))),
          ),
          onPressed: () {
            passwordController.text == confirmPasswordController.text
                ? onAuth()
                : Fluttertoast.showToast(
                    msg: S.of(context).writeTheCorrectlyConfirmPassword,
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 4,
                    backgroundColor: const Color(0xffe7d9ff),
                    textColor: const Color(0xbf000000),
                    fontSize: 16.0);
          },
          child: SizedBox(
            width: 80,
            height: 50,
            child: Center(
                child: Text(authButtonText,
                    style: const TextStyle(color: Colors.white, fontSize: 18))),
          ),
        )
      ],
    );
  }
}
