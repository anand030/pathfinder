class Success {
  int code;
  String response;

  Success({required this.code, required this.response});
}

// class UnauthorizedUser {
//   int code;
//   String errorResponse;
//
//   UnauthorizedUser({required this.code, required this.errorResponse});
// }

class Failure {
  int code;
  String errorResponse;

  Failure({required this.code, required this.errorResponse});
}
