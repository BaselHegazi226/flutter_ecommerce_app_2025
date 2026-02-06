class FieldsContranits {
  // Email (مقبول وعملي)
  static final RegExp emailReg = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  // Name (يسمح بحروف عربية ولاتينية ومسافة و - و ')
  static final RegExp nameReg = RegExp(r"^[A-Za-z\u0600-\u06FF' -]{2,50}$");

  // Password (min 8, at least 1 lower, 1 upper, 1 digit, 1 special char)
  static final RegExp passwordReg = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#\$&*~^%()_+\-=\[\]{};:"\\|,.<>\/?]).{8,}$',
  );
  static final RegExp egyptPhoneReg = RegExp(r'^\+201[0125][0-9]{8}$');
}
