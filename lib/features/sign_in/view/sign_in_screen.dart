import 'package:flutter/material.dart';
import 'package:proper_life/features/sign_in/widgets/auth_form.dart';
import 'package:proper_life/generated/l10n.dart';
// import 'package:proper_life/router/router.dart';
import 'package:proper_life/services/firebase_service.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool isLoggedIn = true;
  final FirebaseService firebaseService = FirebaseService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    final onAuth = isLoggedIn
        ? () => firebaseService.onLogin(
            email: emailController.text, password: passwordController.text)
        : () => firebaseService.onRegister(
              email: emailController.text,
              password: passwordController.text,
              name: nameController.text,
              userName: '@${usernameController.text}',
              userCity: cityController.text,
            );
    final buttonText = isLoggedIn
        ? S.of(context).notRegisterSignUpNow
        : S.of(context).alreadySignUpGoToSignIn;
    final theme = Theme.of(context);
    
    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: Text(
            "ProPer life",
            style: theme.textTheme.titleLarge,
          ),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                  Color(0xff9257ff),
                  Color(0xff5900ff),
                ])),
          ),
        ),
        body: Container(
          margin: const EdgeInsets.only(top: 10, left: 40, right: 40),
          child: ListView(
            children: <Widget>[
              isLoggedIn
                  ? AuthForm(
                      authButtonText: S.of(context).signIn,
                      onAuth: onAuth,
                      emailController: emailController,
                      passwordController: passwordController,
                    )
                  : RegisterForm(
                      onAuth: onAuth,
                      authButtonText: S.of(context).signUp,
                      emailController: emailController,
                      passwordController: passwordController,
                      confirmPasswordController: confirmPasswordController,
                      nameController: nameController,
                      usernameController: usernameController,
                      cityController: cityController,
                    ),
              TextButton(
                  onPressed: () {
                    setState(() {
                      isLoggedIn = !isLoggedIn;
                    });
                  },
                  child: Text(buttonText))
            ],
          ),
        ));
  }
}
