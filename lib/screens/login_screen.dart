import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram/components/widgets.dart';
import 'package:instagram/resources/auth_methods.dart';
import 'package:instagram/screens/signup_screen.dart';
import 'package:instagram/utils/colors.dart';

import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsoive_layout_screen.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/gloabl_variabels.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void loginUser() async {
    setState(() {
      isLoading = true;
    });
    String res = await AuthMethods().signInUser(
        email: _emailController.text, password: _passwordController.text,context: context);
    if (res == 'success') {
      print('success');
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (context) => const ResponsiveLayout(
              mobileScreenLayout: MobileScreenLayout(),
              webScreenLayout: WebScreenLayout(),
            ),
          ),
              (route) => false);

      setState(() {
        isLoading = false;
      });
    } else {
      print('fail');

      setState(() {
        isLoading = false;
      });
      showSnackBar(res, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Container(
                padding: MediaQuery.of(context).size.width > webScreenSize
                    ? EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 3)
                    : const EdgeInsets.symmetric(horizontal: 32),                width: double.infinity,
                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/ic_instagram.svg',
                      color: primaryColor,
                      height: 64,
                    ),
                    const SizedBox(height: 40.0),
                    defaultFormField(
                        controller: _emailController,
                        type: TextInputType.emailAddress,
                        label: 'Email',
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please write your email';
                          }
                          return null;
                        },
                        prefix: Icons.email_outlined),
                    const SizedBox(height: 40.0),
                    defaultFormField(
                        controller: _passwordController,
                        type: TextInputType.text,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please write your password';
                          }
                          return null;
                        },
                        label: 'Password',
                        prefix: Icons.lock_outline),
                    const SizedBox(height: 40.0),
                    InkWell(
                      onTap:loginUser,
                      child: isLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(vertical: 13),
                              decoration: const ShapeDecoration(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  color: Colors.blue),
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text('Don\'t have any account?'),
                        TextButton(
                            onPressed: () {
                              navigateTo(context, const SignUpScreen());
                            },
                            child: const Text('Register Now'))
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
