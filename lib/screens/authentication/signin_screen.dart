import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tech_challenge/controller/authentication_controller.dart';
import 'package:tech_challenge/screens/authentication/signup_screen.dart';
import 'package:tech_challenge/utils/textfield_validator.dart';
import 'package:tech_challenge/widgets/text_field_widget.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextFieldValidator textFieldValidator = TextFieldValidator();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthenticationController _authenticationController =
      Get.put(AuthenticationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Sign In",
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
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.text,
                      onValidator: (password) {
                        return textFieldValidator.validatePassword(password);
                      },
                      labelText: 'Password'),
                  const SizedBox(height: 30),
                  Obx(
                    () => _authenticationController.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              _signIn();
                            },
                            child: const Text("Sign In")),
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
                        Get.to(() => SignUpScreen());
                      },
                      child: const Text("Sign Up")),
                ],
              ),
            ),
          ),
        ));
  }

  _signIn() {
    if (!formKey.currentState!.validate()) {
      return;
    }
    _authenticationController.isLoading.value = true;
    _authenticationController.signInUser(
        email: emailController.text, password: passwordController.text);
  }
}
