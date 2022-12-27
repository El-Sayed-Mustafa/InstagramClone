import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:instagram/components/widgets.dart';
import 'package:instagram/resources/auth_methods.dart';
import 'package:instagram/screens/login_screen.dart';
import 'package:instagram/utils/colors.dart';
import 'package:instagram/utils/utils.dart';
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
  Uint8List? _image;
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

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
            child: Form(
              key: _formKey,
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
                              _image != null
                                  ? CircleAvatar(
                                      radius: 70.0,
                                      backgroundImage: MemoryImage(_image!))
                                  : const CircleAvatar(
                                      radius: 70.0,
                                      backgroundImage: NetworkImage(
                                          'https://avatars.githubusercontent.com/u/110793510?s=400&u=f5747c7e44ce456de2a7fa241c702cbbb1630703&v=4'),
                                    ),
                              Positioned(
                                  bottom: -5,
                                  right: -5,
                                  child: IconButton(
                                    onPressed: selectImage,
                                    icon: const Icon(Icons.add_a_photo),
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30.0),
                    defaultFormField(
                        controller: _emailController,
                        type: TextInputType.emailAddress,
                        validate: (value) {
                          bool isValid = RegExp(
                                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                              .hasMatch(value);
                          if (!isValid) {
                            return "Your email is badly formatted ";
                          }
                          return null;
                        },
                        label: 'Email',
                        prefix: Icons.email_outlined),
                    const SizedBox(height: 30.0),
                    defaultFormField(
                        controller: _usernameController,
                        type: TextInputType.text,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please Enter yor name';
                          }
                          return null;
                        },
                        label: 'Username',
                        prefix: Icons.person),
                    const SizedBox(height: 30.0),
                    defaultFormField(
                        controller: _passwordController,
                        type: TextInputType.text,
                        label: 'Password',
                        validate: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              value.toString().length < 6) {
                            return 'Your password must contain at least 6 characters';
                          }
                          return null;
                        },
                        prefix: Icons.lock_outline),
                    const SizedBox(height: 30.0),
                    defaultFormField(
                        controller: _bioController,
                        type: TextInputType.text,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please write your bio';
                          }
                          return null;
                        },
                        label: 'Bio',
                        prefix: Icons.text_snippet),
                    const SizedBox(height: 30.0),
                    InkWell(
                      onTap: () async {
                        if (_image == null) {
                          showToast(
                              msg: "Please select image",
                              state: ToastState.ERROR);
                        }
                        if (_formKey.currentState!.validate() &&
                            _image != null) {
                          setState(() {
                            isLoading = true;
                          });
                          await AuthMethods().signUpUser(
                              email: _emailController.text,
                              password: _passwordController.text,
                              username: _usernameController.text,
                              bio: _bioController.text,
                              file: _image!,
                              context: context);
                          setState(() {
                            isLoading = false;
                          });
                        }
                      },
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
      ),
    );
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }
}
