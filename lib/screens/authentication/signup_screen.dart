import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_challenge/controller/authentication_controller.dart';
import 'package:tech_challenge/utils/textfield_validator.dart';
import 'package:tech_challenge/widgets/snackbar_widget.dart';
import 'package:tech_challenge/widgets/text_field_widget.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextFieldValidator textFieldValidator = TextFieldValidator();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthenticationController _authenticationController = Get.find();
  List<String> interest = ["Animals", "Football", "Funny", "Music"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: WillPopScope(
          onWillPop: () async {
            _authenticationController.interest.clear();
            return true;
          },
          child: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Sign Up",
                      style: TextStyle(
                        fontSize: 22,
                        letterSpacing: 5,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 40),
                    textFieldWidget(
                        controller: emailController,
                        hintText: 'Enter your email',
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                        onValidator: (email) {
                          return textFieldValidator.validateEmail(email);
                        },
                        labelText: 'Email'),
                    const SizedBox(height: 20),
                    textFieldWidget(
                        controller: passwordController,
                        hintText: 'Enter your password',
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.text,
                        onValidator: (password) {
                          return textFieldValidator.validatePassword(password);
                        },
                        labelText: 'Password'),
                    const SizedBox(height: 20),
                    textFieldWidget(
                        controller: confirmPasswordController,
                        hintText: 'Enter your confirm password',
                        textInputAction: TextInputAction.done,
                        keyboardType: TextInputType.text,
                        onValidator: (password) {
                          return textFieldValidator.validateConfirmPassword(
                              passwordController.text, password);
                        },
                        labelText: 'Confirm Password'),
                    const SizedBox(height: 16),
                    const Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Interest",
                        style: TextStyle(
                          fontSize: 18,
                          letterSpacing: 1,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Obx(
                      () => Wrap(
                        runSpacing: 8,
                        spacing: 10,
                        children: interest.map((e) {
                          bool isSelected =
                              _authenticationController.interest.contains(e);
                          return GestureDetector(
                            onTap: () {
                              if (_authenticationController.interest
                                  .contains(e)) {
                                _authenticationController.interest.remove(e);
                              } else {
                                _authenticationController.interest.add(e);
                              }
                            },
                            child: Chip(
                              backgroundColor: isSelected
                                  ? Get.theme.primaryColor
                                  : Colors.white,
                              label: Text(e),
                              labelStyle: TextStyle(
                                  color:
                                      isSelected ? Colors.white : Colors.black),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Obx(
                      () => _authenticationController.isLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : ElevatedButton(
                              onPressed: () {
                                _signUp();
                              },
                              child: const Text("Sign Up")),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text("----------"),
                        Text("OR"),
                        Text("----------"),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () {
                          _authenticationController.interest.clear();
                          Get.back();
                        },
                        child: const Text("Sign In")),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  _signUp() {
    if (!formKey.currentState!.validate()) {
      return;
    }
    if (_authenticationController.interest.isEmpty) {
      showMessage("Please select at least one interest.");
      return;
    }
    _authenticationController.isLoading.value = true;
    _authenticationController.signUpUser(
        email: emailController.text, password: passwordController.text);
  }
}
