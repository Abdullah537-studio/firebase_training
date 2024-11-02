String? userNameValidator(String? val) {
  if (val?.isEmpty ?? true) {
    return "this field is reqiured";
  } else if (val != null && val.length > 25 && val.length < 5) {
    return "name between 5 to 25 word";
  }
  return null;
}

String? passwordValidator(String? val) {
  final bool emailValid = RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(val ?? "");
  if (val?.isEmpty ?? true) {
    return "this field is reqiured";
  } else if (emailValid) {
    return "Rewrite correct email";
  }
  return null;
}

String? emailValidator(String? val) {
  if (val?.isEmpty ?? true) {
    return "this field is reqiured";
  } else {
    return null;
  }
}

String? generalValidator(String? val) {
  if (val?.isEmpty ?? true) {
    return "this field is reqiured";
  } else {
    return null;
  }
}
