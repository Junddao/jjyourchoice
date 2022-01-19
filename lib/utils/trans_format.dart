import 'package:jjyourchoice/enum/age.dart';
import 'package:jjyourchoice/enum/brand.dart';
import 'package:jjyourchoice/enum/gender.dart';

class TransFormat {
  static String getENStringFromEnumAge(EnumAge value) {
    String returnString;
    switch (value) {
      case EnumAge.ten:
        returnString = '10';
        break;
      case EnumAge.twenty:
        returnString = '20';
        break;
      case EnumAge.thirty:
        returnString = '30';
        break;
      case EnumAge.fourty:
        returnString = '40';
        break;
      case EnumAge.fifty:
        returnString = '50';
        break;
      case EnumAge.overSixty:
        returnString = '60';
        break;
    }
    return returnString;
  }

  static String getKRStringFromEnumAge(EnumAge value) {
    String returnString;
    switch (value) {
      case EnumAge.ten:
        returnString = '10대';
        break;
      case EnumAge.twenty:
        returnString = '20대';
        break;
      case EnumAge.thirty:
        returnString = '30대';
        break;
      case EnumAge.fourty:
        returnString = '40대';
        break;
      case EnumAge.fifty:
        returnString = '50대';
        break;
      case EnumAge.overSixty:
        returnString = '60대 이상';
        break;
    }
    return returnString;
  }

  static String getENStringFromEnumBrand(EnumBrand value) {
    String returnString;
    switch (value) {
      case EnumBrand.starbucks:
        returnString = 'starbucks';
        break;
      case EnumBrand.twosome:
        returnString = 'twosome';
        break;
      case EnumBrand.ediya:
        returnString = 'ediya';
        break;
    }
    return returnString;
  }

  static String getKRStringFromEnumBrand(EnumBrand value) {
    String returnString;
    switch (value) {
      case EnumBrand.starbucks:
        returnString = '스타벅스';
        break;
      case EnumBrand.twosome:
        returnString = '투썸플레이스';
        break;
      case EnumBrand.ediya:
        returnString = '이디야';
        break;
    }
    return returnString;
  }

  static String getENStringFromEnumGender(EnumGender value) {
    String returnString;
    switch (value) {
      case EnumGender.male:
        returnString = 'male';
        break;
      case EnumGender.female:
        returnString = 'female';
        break;
    }
    return returnString;
  }

  static String getKRStringFromEnumGender(EnumGender value) {
    String returnString;
    switch (value) {
      case EnumGender.male:
        returnString = '남성';
        break;
      case EnumGender.female:
        returnString = '여성';
        break;
    }
    return returnString;
  }
}
