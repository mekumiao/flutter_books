class AdaptResult {
  const AdaptResult({
    required this.headers,
    required this.queryParameters,
  });

  final Map<String, dynamic> headers;
  final Map<String, dynamic> queryParameters;

  AdaptResult copyWith({
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) {
    return AdaptResult(
      headers: headers ?? this.headers,
      queryParameters: queryParameters ?? this.queryParameters,
    );
  }

  void removeNull() {
    if (headers.isNotEmpty) {
      headers.removeWhere((key, value) => value == null);
    }
    if (queryParameters.isNotEmpty) {
      queryParameters.removeWhere((key, value) => value == null);
    }
  }

  void appendTo({
    required Map<String, dynamic> headers,
    required Map<String, dynamic> queryParameters,
  }) {
    if (this.headers.isNotEmpty) {
      headers.addAll(this.headers);
    }
    if (this.queryParameters.isNotEmpty) {
      queryParameters.addAll(this.queryParameters);
    }
  }

  void addQueryParameters([Map<String, dynamic> other = const {}]) {
    if (other.isNotEmpty) {
      queryParameters.addAll(other);
    }
  }
}
