class ValidationQuery {
  static final RegExp emailValidationQuery = RegExp(
    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
  );

  static final RegExp nameValidationQuery = RegExp(r'^[a-zA-ZğıüşöçİĞÜŞÖÇ ]*[a-zA-ZğıüşöçİĞÜŞÖÇ ]*');

  // Removed upper case letters in this query because the firebase does not delete have upper case letters in the list name. I think it is a bug.
  static final RegExp customListNameValidationQuery = RegExp(r'^[a-z0-9ğüşöç ]*[a-z0-9ğüşöç ]*');
}