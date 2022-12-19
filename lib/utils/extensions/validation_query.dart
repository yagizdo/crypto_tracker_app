class ValidationQuery {
  static final RegExp emailValidationQuery = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  static final RegExp nameValidationQuery = RegExp(r'^[a-zA-ZğıüşöçİĞÜŞÖÇ ]*[a-zA-ZğıüşöçİĞÜŞÖÇ ]*');
}