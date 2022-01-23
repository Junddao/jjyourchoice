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
      default:
        returnString = "";
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
      default:
        returnString = "선택안함";
    }
    return returnString;
  }

  static EnumAge getEnumAgeFromString(String value) {
    EnumAge _age;
    switch (value) {
      case "10":
        _age = EnumAge.ten;
        break;
      case "20":
        _age = EnumAge.twenty;
        break;
      case "30":
        _age = EnumAge.thirty;
        break;
      case "40":
        _age = EnumAge.fourty;
        break;
      case "50":
        _age = EnumAge.fifty;
        break;
      case "60":
        _age = EnumAge.overSixty;
        break;
      default:
        _age = EnumAge.none;
    }

    return _age;
  }

  static String getENStringFromEnumBrand(EnumBrand value) {
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
      case EnumBrand.paul:
        returnString = '폴 바셋';
        break;
      case EnumBrand.hollys:
        returnString = '할리스';
        break;
      case EnumBrand.angel:
        returnString = '엔제리어스';
        break;
      case EnumBrand.bean:
        returnString = '커피빈';
        break;
      case EnumBrand.mega:
        returnString = '메가커피';
        break;
      case EnumBrand.paik:
        returnString = '빽다방';
        break;
      case EnumBrand.tom:
        returnString = '탐앤탐스';
        break;
      default:
        returnString = "";
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
      case EnumBrand.paul:
        returnString = '폴 바셋';
        break;
      case EnumBrand.hollys:
        returnString = '할리스';
        break;
      case EnumBrand.angel:
        returnString = '엔제리어스';
        break;
      case EnumBrand.bean:
        returnString = '커피빈';
        break;
      case EnumBrand.mega:
        returnString = '메가커피';
        break;
      case EnumBrand.paik:
        returnString = '빽다방';
        break;
      case EnumBrand.tom:
        returnString = '탐앤탐스';
        break;
      default:
        returnString = "선택안함";
    }
    return returnString;
  }

  static EnumBrand getEnumBrandFromString(String value) {
    EnumBrand _brand;
    switch (value) {
      case "엔제리어스":
        _brand = EnumBrand.angel;
        break;
      case "스타벅스":
        _brand = EnumBrand.starbucks;
        break;
      case "투썸플레이스":
        _brand = EnumBrand.twosome;
        break;
      case "이디야":
        _brand = EnumBrand.ediya;
        break;
      case "폴 바셋":
        _brand = EnumBrand.paul;
        break;
      case "할리스":
        _brand = EnumBrand.hollys;
        break;
      case "커피빈":
        _brand = EnumBrand.bean;
        break;
      case "메가커피":
        _brand = EnumBrand.mega;
        break;
      case "빽다방":
        _brand = EnumBrand.paik;
        break;
      case "탐앤탐스":
        _brand = EnumBrand.tom;
        break;
      default:
        _brand = EnumBrand.none;
        break;
    }

    return _brand;
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
      default:
        returnString = "";
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
      default:
        returnString = "선택안함";
    }
    return returnString;
  }

  static EnumGender getEnumGenderFromString(String value) {
    EnumGender _gender;
    switch (value) {
      case 'male':
        _gender = EnumGender.male;
        break;
      case 'female':
        _gender = EnumGender.female;
        break;

      default:
        _gender = EnumGender.none;
    }

    return _gender;
  }
}
