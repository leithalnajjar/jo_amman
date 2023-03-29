import 'package:get/get.dart';
import 'package:jo_amman/config/en.dart';
import 'package:jo_amman/config/ar.dart';

class Translation extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
    'en' : en,
    'ar' : ar,
  };
}