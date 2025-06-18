class NetworkResult<T> {
  final T? data;
  final String? error; // When both network and cache fail
  final bool isOffline; // Cached data when offline
  final DateTime? cachedAt;
  static const Duration cacheExpiration = Duration(days: 7);

  NetworkResult._({
    this.data,
    this.error,
    this.isOffline = false,
    this.cachedAt,
  });

  factory NetworkResult.success(T data) =>
      NetworkResult._(data: data, isOffline: false);

  factory NetworkResult.offline(T data, [DateTime? cachedAt]) =>
      NetworkResult._(data: data, isOffline: true, cachedAt: cachedAt);

  factory NetworkResult.error(String message) =>
      NetworkResult._(error: message, isOffline: false);

  // Fresh data from network
  bool get isSuccess => error == null && data != null;
  bool get isError => error != null;

  bool get isCacheValid {
    if (cachedAt == null) return false;
    return DateTime.now().difference(cachedAt!) < cacheExpiration;
  }
}
