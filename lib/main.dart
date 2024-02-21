import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jwt_token_getx/localestorageutils/localestorageutils.dart';
import 'package:jwt_token_getx/sign_up_controller.dart';

void main() async{
  runApp(const MyApp());
  await LocaleStorageUtil.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    return GetMaterialApp(
      home: Scaffold(
          body: Column(
        children: [
          TextFormField(
            decoration: const InputDecoration(hintText: "Enter Mobile Number"),
            controller: controller.phonenumber,
          ),
          ElevatedButton(onPressed: () {
            controller.sendOtp(context);
          }, child: const Text('send otp')),
          TextFormField(
            decoration: const InputDecoration(hintText: "Enter Otp"),
            controller: controller.otpController,
          ),
          ElevatedButton(onPressed: () {
          controller.verifyOtp(context);
          }, child: const Text('verify otp')),

         
         
        ],
      )),
    );
  }
}
