import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/libs/otp_field.dart';
import 'package:flutter_firebase_auth/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final phoneController = TextEditingController();
  final otpController = TextEditingController();
  bool otpCodeVisible = false;

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back_rounded),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: otpCodeVisible
            ? otpVerificationPage(phoneController, context)
            : otpCodeVerificationPage(phoneController, otpController, context),
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget otpVerificationPage(
          TextEditingController phoneController, BuildContext context) =>
      Column(
        children: [
          imageLoginPage('assets/images/image_page_login.png'),
          const SizedBox(
            height: 54,
          ),
          titleInstructions('We will send you a ', 'One Time Password\n',
              'on this mobile number'),
          const SizedBox(
            height: 80,
          ),
          editTextPhoneNumber(phoneController),
          const SizedBox(
            height: 38,
          ),
          buttonGetOTP(context)
        ],
      );

  Widget otpCodeVerificationPage(TextEditingController phoneController,
          TextEditingController otpController, BuildContext context) =>
      Column(
        children: [
          imageLoginPage('assets/images/image_page_code.png'),
          const SizedBox(
            height: 54,
          ),
          titleInstructions('Enter the OTP sent to', phoneController.text, ''),
          const SizedBox(
            height: 80,
          ),
          editTextVerification(otpController),
          const SizedBox(
            height: 38,
          ),
          buttonGetOTP(context)
        ],
      );

  Widget imageLoginPage(String imagePath) => Image(
        image: AssetImage(imagePath),
        height: 200,
      );

  Widget titleInstructions(
          String firstPart, String secondPart, String thirdPart) =>
      Column(
        children: [
          const Text(
            "OTP Verification",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(
            height: 16,
          ),
          Text.rich(
            TextSpan(text: firstPart, children: <TextSpan>[
              TextSpan(
                  text: secondPart,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: thirdPart)
            ]),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      );

  Widget editTextPhoneNumber(TextEditingController controller) => Column(
        children: [
          const Text("Enter mobile number"),
          Row(
            children: [
              Flexible(flex: 1, child: Container()),
              Flexible(
                  flex: 3,
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.send,
                    textAlign: TextAlign.center,
                    controller: controller,
                  )),
              Flexible(flex: 1, child: Container())
            ],
          ),
        ],
      );

  Widget buttonGetOTP(BuildContext context) => Row(
        children: [
          Flexible(flex: 1, child: Container()),
          Flexible(
              flex: 7,
              child: SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("GET OTP"),
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor),
                ),
              )),
          Flexible(flex: 1, child: Container())
        ],
      );

  Widget editTextVerification(TextEditingController controller) => Row(
        children: [
          Flexible(flex: 2, child: Container()),
          Flexible(
              flex: 3,
              child: TextField(
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.send,
                textAlign: TextAlign.center,
                controller: controller,
              )),
          Flexible(flex: 2, child: Container())
        ],
      );

  Widget buttonValidateCode(BuildContext context) => Row(
        children: [
          Flexible(flex: 1, child: Container()),
          Flexible(
              flex: 7,
              child: SizedBox(
                width: double.infinity,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text("VERIFY & PROCEED"),
                  style: ElevatedButton.styleFrom(
                      primary: Theme.of(context).primaryColor),
                ),
              )),
          Flexible(flex: 1, child: Container())
        ],
      );

  void sendConfirmationMessage(String phoneNumber, FirebaseAuth auth) async {
    await auth.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (AuthCredential credential) async {
          UserCredential userCredential =
              await auth.signInWithCredential(credential);
          if (userCredential.user != null) {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          }
        },
        verificationFailed: (FirebaseAuthException ex) {
          // ignore: avoid_print
          print(ex);
        },
        codeSent: (String verificationID, int? resendToken) async {
          String smsCode = "";
          PhoneAuthCredential credential = PhoneAuthProvider.credential(
              verificationId: verificationID, smsCode: smsCode);
          UserCredential userCredential =
              await auth.signInWithCredential(credential);
          if (userCredential.user != null) {
            Navigator.pop(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          }
        },
        codeAutoRetrievalTimeout: (_) {});
  }
}
