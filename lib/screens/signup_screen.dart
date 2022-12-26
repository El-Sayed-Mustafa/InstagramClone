import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:instagram/components/widgets.dart';
import 'package:instagram/screens/login_screen.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/widgets/text_field_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
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
                  const SizedBox(height: 20.0),
                  SizedBox(
                    width: 140,
                    child: Column(
                      children: [
                        Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            const CircleAvatar(
                              radius: 70.0,
                              backgroundImage: NetworkImage(
                                  'https://avatars.githubusercontent.com/u/110793510?s=400&u=f5747c7e44ce456de2a7fa241c702cbbb1630703&v=4'),
                            ),
                            Positioned(
                                bottom: -5,
                                right: -5,
                                child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.add_a_photo),
                                ))
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30.0),

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
                  const SizedBox(height: 30.0),
                  defaultFormField(
                      controller: _usernameController,
                      type: TextInputType.text,
                      validate: () {},
                      label: 'Username',
                      prefix: Icons.person),
                  const SizedBox(height: 30.0),
                  defaultFormField(
                      controller: _passwordController,
                      type: TextInputType.text,
                      validate: () {},
                      label: 'Password',
                      prefix: Icons.lock_outline),
                  const SizedBox(height: 30.0),
                  defaultFormField(
                      controller: _bioController,
                      type: TextInputType.text,
                      validate: () {},
                      label: 'Bio',
                      prefix: Icons.text_snippet),
                  const SizedBox(height: 30.0),
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
                        'Register',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text('Do you have already account?'),
                      TextButton(
                          onPressed: () {
                            navigateTo(context, const LoginScreen());
                          },
                          child: const Text('Login Now'))
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
