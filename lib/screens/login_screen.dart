import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram/components/widgets.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/widgets/text_field_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/ic_instagram.svg',
                    color: primaryColor,
                    height: 64,
                  ),
                  const SizedBox(height: 40.0),

                  /*   TextFieldInput(textEditingController: _emailController,
                      hintText: "Enter your email",
                      textInputType: TextInputType.emailAddress),
                  TextFieldInput(textEditingController: _passwordController,
                      hintText: "Enter your password",
                      textInputType: TextInputType.text)*/
                  defaultFormField(
                      controller: _emailController,
                      type: TextInputType.emailAddress,
                      validate: () {},
                      label: 'Email',
                      prefix: Icons.email_outlined),
                  const SizedBox(height: 40.0),
                  defaultFormField(
                      controller: _passwordController,
                      type: TextInputType.text,
                      validate: () {},
                      label: 'Password',
                      prefix: Icons.lock_outline),
                  const SizedBox(height: 40.0),
                  InkWell(
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 13),
                      decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          color: Colors.blue),
                      child: const Text(
                        'Log in',
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('Don\'t have any account?'),
                      TextButton(
                          onPressed: () {
                            // navigateTo(context, const RegisterScreen());
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
    );
  }
}
