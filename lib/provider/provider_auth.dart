import 'package:firebase_auth/firebase_auth.dart';
import 'package:jjyourchoice/models/model_shared_preferences.dart';
import 'package:jjyourchoice/models/sign_in/sign_in_model.dart';
import 'package:jjyourchoice/models/sign_in/sign_in_request_model.dart';
import 'package:jjyourchoice/service/api_service.dart';
import 'package:jjyourchoice/service/login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb;

class ProviderAuth {
  final fb.FirebaseAuth _auth = fb.FirebaseAuth.instance;

  Future<User?> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final authResult =
          await FirebaseAuth.instance.signInWithCredential(oauthCredential);

      return authResult.user;
    } catch (error) {
      print('error');
      throw Exception();
    }
  }

  Future<SignInData?> signInWithKakao(String token) async {
    final Map<String, dynamic> data = await LoginService().kakaoLogin(token);

    String customToken = data['customToken'] ?? '';
    String email = data['email'] ?? '';

    fb.UserCredential? result = await _auth.signInWithCustomToken(customToken);

    fb.User? firebaseUser = result.user;
    SignInData signInData = await getTokenByServer(firebaseUser);
    signInData.socialEmail = email;

    return signInData;

    // aws server에 token 요청
  }

  Future<SignInData> getTokenByServer(fb.User? firebaseUser) async {
    // String idToken = await firebaseUser!.getIdToken();
    SignInRequestModel signInRequestModel =
        await LoginService().getSignInRequest(firebaseUser);

    var api = ApiService();
    // Map<String, dynamic> map = {
    //   'firebaseIdToken': idToken,
    //   'osType' : osType,
    //   'osVersion': osVersion,
    //   'deviceModel': deviceModel,
    // };

    Map<String, dynamic> _data =
        await api.post('/auth/signin', signInRequestModel.toMap());
    SignInData signInData = SignInData.fromMap(_data['data']);
    ModelSharedPreferences.writeToken(signInData.token!);

    return signInData;
  }
}
