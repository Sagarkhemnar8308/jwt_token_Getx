import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_token_getx/homeScreen.dart';
import 'package:jwt_token_getx/localestorageutils/localestorageutils.dart';
import 'package:jwt_token_getx/model/refresh_token_model.dart';
import 'package:jwt_token_getx/model/verify_otp_model.dart';

class SignUpController extends GetxController {
  int groupId = 1703228300417;
  final phonenumber = TextEditingController();
  final otpController = TextEditingController();

  Future<void> sendOtp(BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse(
            "https://gxppcdmn7h.execute-api.ap-south-1.amazonaws.com/authgw/sendotp"),
        headers: {'Content-Type': 'application/json'},
        body:
            json.encode({"phoneNumber": phonenumber.text, "groupId": groupId}),
      );

      if (response.statusCode == 200) {
        print("Otp send successfully");
      } else {
        print("Failed to send OTP. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error sending OTP: $e");
    }
  }

  Future<void> verifyOtp(BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse(
            "https://4r4iwhot12.execute-api.ap-south-1.amazonaws.com/auth/auth/validateOtp/"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "phoneNumber": phonenumber.text,
          "otp": int.parse(otpController.text)
        }),
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        print("verify Otp successfully");
        VerifyOtpModel verifyOtpModel = VerifyOtpModel.fromJson(data);
        print("object ${verifyOtpModel.token.toString()}");
        refreshToken(token:verifyOtpModel.token.toString(), groupId: groupId );
      } else {
        print("Failed to send OTP. Status code: ${response.statusCode}");
      }
    } catch (e) {
      print("Error $e");
    }
  }

  Future<void> refreshToken({required String token , required int groupId}) async {
    try {
      var response = await http.post(
        Uri.parse(
            "https://gxppcdmn7h.execute-api.ap-south-1.amazonaws.com//authgw/refresh-token"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"token": token, "groupId": groupId}),
      );

      if (response.statusCode == 200) {
         var data = jsonDecode(response.body);
         
        RefreshTokenModel referesToken = RefreshTokenModel.fromJson(data);
        LocaleStorageUtil.saveUserDetails(referesToken.token.toString());
        Get.to(const HomeScreen());
      } else {
        print("Getting error to save token ${response.statusCode}");
      }
      // ignore: empty_catches
    } catch (e) {
       print("error $e");
    }
  }
}
