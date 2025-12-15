 
class PhoneValidator {
    static bool validate(String phone) {
     phone = phone.replaceAll(" ", "");

     final regex = RegExp(r'^(0?[1-9][0-9]{6,14})$');

    return regex.hasMatch(phone);
  }
}
