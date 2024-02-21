import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:jwt_token_getx/model/jwt_decoder_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleStorageUtil {
  static late final SharedPreferences instance;

  static Future<SharedPreferences> init() async =>
      instance = await SharedPreferences.getInstance();

  static JwtTokenModel get tokenResponseModel => userData();

  static Future<void> saveUserDetails(String token) async {
    await instance.setString("token", token);
    print('token is $token');
  }

  static Future<String?> fetchToken() async {
    final token = instance.getString('token') ?? '';
    if (token.isEmpty) {
      return "";
    }
    return token;
  }

  static JwtTokenModel userData() {
    final token = instance.getString('token') ?? '';
    var userData = JwtDecoder.decode(token);
    var userDecoded = JwtTokenModel.fromJson(userData);
    return userDecoded;
  }
}
