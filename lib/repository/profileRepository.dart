
import 'package:furniturezoid/api/profileAPI.dart';
import 'package:furniturezoid/response/profileResponse.dart';

class ProfileRepository {
  Future<ProfileResponse?> getprofile() async {
    return ProfileAPI().getprofile();
  }
}

