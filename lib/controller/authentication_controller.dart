import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tech_challenge/model/users.dart';
import 'package:tech_challenge/screens/home/main_screen.dart';
import 'package:tech_challenge/services/authentication_service.dart';
import 'package:tech_challenge/widgets/snackbar_widget.dart';

class AuthenticationController extends GetxController {
  RxBool isLoading = false.obs;
  RxList<String> interest = <String>[].obs;
  final AuthenticationService authenticationService =
      AuthenticationServiceImpl();
  final FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;

  signInUser({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await authenticationService.signInUser(
          email: email, password: password);
      if (userCredential.user != null) {
        isLoading.value = false;
        Get.off(() => MainScreen());
      } else {
        isLoading.value = false;
        showMessage("Something went wrong.");
      }
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      showMessage(e.code);
    }
  }

  signUpUser({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await authenticationService.signUpUser(
          email: email, password: password);
      if (userCredential.user != null) {
        Users user = Users(
            email: email,
            password: password,
            interest: interest,
            watchCount: 0);
        await _firebaseFireStore
            .collection("Users")
            .doc(userCredential.user!.uid)
            .set(user.toJson());
        isLoading.value = false;
        Get.back();
        showMessage("User created successfully.");
      } else {
        isLoading.value = false;
        showMessage("Something went wrong.");
      }
    } on FirebaseAuthException catch (e) {
      isLoading.value = false;
      showMessage(e.code);
    }
  }

  @override
  void dispose() {
    interest.clear();
    super.dispose();
  }
}
