import 'package:get_storage/get_storage.dart';
import 'package:jo_amman/config/enum/user_role_enum.dart';

class SharedPrefsClient {
  static const String _storageName = "MyPref";

  static final GetStorage _storage = GetStorage(_storageName);

  init() async {
    await GetStorage.init(_storageName);
  }

  void clearProfile() {
    isLogin = false;
    userRole = UserRoleEnum.unknown;
    phoneNumber = "";
    id = "";
  }

  String get deviceToken => _storage.read(keyDeviceToken) ?? "";

  set deviceToken(String value) {
    _storage.write(keyDeviceToken, value);
  }

  String get id => _storage.read(keyId) ?? "";

  set id(String value) {
    _storage.write(keyId, value);
  }

  String get phoneNumber => _storage.read(keyPhoneNumber) ?? "";

  set phoneNumber(String value) {
    _storage.write(keyPhoneNumber, value);
  }

  String get language => _storage.read(keyLanguage) ?? "";

  set language(String value) {
    _storage.write(keyLanguage, value);
  }

  bool get isLogin => _storage.read(keyIsLogin) ?? false;

  set isLogin(bool value) {
    _storage.write(keyIsLogin, value);
  }

  UserRoleEnum get userRole => UserRoleEnum.values.firstWhere((element) => element.value == (_storage.read(keyUserRole) ?? 0));

  set userRole(UserRoleEnum roleEnum) {
    _storage.write(keyUserRole, roleEnum.value);
  }

  bool get isGMS => _storage.read(keyIsGMS) ?? true;

  set isGMS(bool value) {
    _storage.write(keyIsGMS, value);
  }
}

final sharedPrefsClient = SharedPrefsClient();

const String keyDeviceToken = "key_device_token";
const String keyId = "key_id";
const String keyPhoneNumber = "key_phone_number";
const String keyIsLogin = "key_is_login";
const String keyLanguage = "key_language";
const String keyUserRole = "key_user_role";
const String keyIsGMS = "key_is_gms";
