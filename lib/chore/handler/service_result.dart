class ServiceResult<T> {
  final T? data;
  final String? error;

  ServiceResult._({this.data, this.error});

  factory ServiceResult.success(T data) => ServiceResult._(data: data);
  factory ServiceResult.failure(String error) => ServiceResult._(error: error);

  bool get isSuccess => data != null;
  bool get isFailure => error != null;
}
