class ApiResponse<T> {
  T? result;
  bool? success;
  String? error;

  ApiResponse.result({this.result, this.error}) {
    success = (error == null);
  }
}
