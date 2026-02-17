import 'package:password_strength_checker/password_strength_checker.dart';

class CustomPasswordStrength {
  static int calculatePasswordStrength({required String password}) {
    int strength = 0;

    final has8 = password.length >= 8;
    final hasUpper = RegExp(r'[A-Z]').hasMatch(password);
    final hasLower = RegExp(r'[a-z]').hasMatch(password);
    final hasNumber = RegExp(r'[0-9]').hasMatch(password);
    final hasSpecial = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);

    if (has8) strength += 60;
    if (hasUpper) strength += 10;
    if (hasLower) strength += 10;
    if (hasNumber) strength += 10;
    if (hasSpecial) strength += 10;

    return strength;
  }

  static PasswordGenerator generatePassword() {
    var config = const PasswordGeneratorConfiguration(
      length: 10,
      minUppercase: 1,
      minDigits: 1,
      minSpecial: 1,
      minLowercase: 1,
      specialChars: ['*', '#', '\$', '!', '@', '#', '%', '^', '(', ')'],
    );
    final passwordGenerator = PasswordGenerator.fromConfig(
      configuration: config,
    );

    return passwordGenerator;
  }
}
