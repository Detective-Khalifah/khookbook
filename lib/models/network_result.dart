class NetworkResult<T> {
  final T? data;
  final bool fromCache;
  final String? error;

  NetworkResult.success(this.data, {this.fromCache = false}) : error = null;
  NetworkResult.error(this.error) : data = null, fromCache = false;
  NetworkResult.offline(this.data) : error = null, fromCache = true;

  bool get isSuccess => data != null;
  bool get isError => error != null;
  bool get isOffline => fromCache && data != null;
}
