import "package:flutter/material.dart";
import "package:connectivity_plus/connectivity_plus.dart";
import "package:khookbook/models/network_result.dart";

/// Executes an asynchronous [loader] function while displaying a loading indicator.
///
/// This function first checks for network connectivity. If offline, it invokes
/// [onError] or shows a default SnackBar.
///
/// While the [loader] is in progress, a modal dialog with a
/// `CircularProgressIndicator` is shown. This dialog is not dismissible by
/// tapping outside of it.
///
/// Upon successful completion of the [loader], the loading dialog is dismissed,
/// and the [onSuccess] callback is invoked with the result.
///
/// If an error occurs during the [loader]"s execution, the loading dialog is
/// dismissed, the [onError] callback is invoked with the error, and a `SnackBar`
/// displaying the error message is shown.
///
/// The [context] is used to show/hide dialogs and SnackBars. It"s crucial
/// that the widget associated with this [context] remains mounted during the
/// asynchronous operations. Checks for `context.mounted` are included to prevent
/// errors if the widget is disposed.
///
/// Returns the result from the [loader] function, or null if there was an error.
Future<T?> executeNetworkOperation<T>({
  required BuildContext context,
  required Future<T> Function() loader,
  void Function(T? result)? onSuccess,
  void Function(Object error)? onError,
  String? successMessage,
  String? loadingText,
}) async {
  final connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult.contains(ConnectivityResult.none)) {
    // Handle no network connection before showing loader
    if (onError != null) {
      onError("No internet connection. Please check your network.");
    }
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("No internet connection")));
    }
    return null; // Exit the function if no network
  }

  if (!context.mounted) return null;

  // Show loading dialog
  bool dialogShowing = true;
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator.adaptive(),
          if (loadingText != null)
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                loadingText,
                style: const TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
    ),
  ).then((_) => dialogShowing = false);

  try {
    final result = await loader();

    if (!context.mounted) return null;
    if (dialogShowing) {
      Navigator.of(context, rootNavigator: true).pop();
    }

    if (successMessage != null && context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(successMessage)));
    }

    if (onSuccess != null) onSuccess(result);
    return result;
  } catch (error) {
    if (!context.mounted) return null;
    if (dialogShowing) {
      Navigator.of(context, rootNavigator: true).pop();
    }

    if (onError != null) {
      onError(error);
    }

    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error.toString())));
    }
    return null;
  }
}

/// Specialized version of executeNetworkOperation that handles TheMealDB API calls
/// with proper caching behavior. When offline, it will attempt to load from cache
/// first before showing any network error messages.
Future<NetworkResult<T>> fetchMealDBWithCache<T>({
  required BuildContext context,
  required Future<T> Function() loader,
  required Future<T?> Function() cacheLoader,
  void Function(NetworkResult<T> result)? onComplete,
  String? successMessage,
  String? loadingText,
}) async {
  final connectivityResult = await Connectivity().checkConnectivity();

  // Try cache first if offline
  if (connectivityResult.contains(ConnectivityResult.none)) {
    try {
      final cachedResult = await cacheLoader();
      if (cachedResult != null) {
        final result = NetworkResult<T>.offline(cachedResult);
        if (onComplete != null) onComplete(result);
        return result;
      }
    } catch (e) {
      debugPrint("Cache error: $e");
    }

    // Only show no internet message if we don"t have cached data
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("No internet connection")));
    }
    return NetworkResult.error(
      "No internet connection and no cached data available",
    );
  }

  // Show loading dialog
  bool dialogShowing = true;
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator.adaptive(),
            if (loadingText != null)
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  loadingText,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    ),
  ).then((_) => dialogShowing = false);

  try {
    final data = await loader();
    if (dialogShowing) {
      Navigator.of(context, rootNavigator: true).pop();
    }

    if (successMessage != null && context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(successMessage)));
    }

    final result = NetworkResult<T>.success(data);
    if (onComplete != null) onComplete(result);
    return result;
  } catch (error) {
    if (context.mounted && dialogShowing) {
      Navigator.of(context, rootNavigator: true).pop();
    }

    // Try cache as fallback on network error
    try {
      final cachedResult = await cacheLoader();
      if (cachedResult != null) {
        final result = NetworkResult<T>.offline(cachedResult);
        if (onComplete != null) onComplete(result);
        return result;
      }
    } catch (e) {
      debugPrint("Cache error: $e");
    }

    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error.toString())));
    }
    return NetworkResult.error(error.toString());
  }
}

/// Specialized version of executeNetworkOperation that handles TheMealDB API calls
/// with proper caching behavior. When offline, it will attempt to load from cache
/// first before showing any network error messages.
/// @deprecated Use `executeMealDBOperation` instead.
@Deprecated(
  "Use executeMealDBOperation instead. This version is deprecated and may be removed in future versions.",
)
Future<T> deprecatedExecuteMealDBOperation<T>({
  required BuildContext context,
  required Future<T> Function() loader,
  required Future<T?> Function() cacheLoader,
  void Function(T? result)? onSuccess,
  void Function(Object error)? onError,
  String? successMessage,
  String? loadingText,
}) async {
  final connectivityResult = await Connectivity().checkConnectivity();

  // Try cache first if offline
  if (connectivityResult.contains(ConnectivityResult.none)) {
    try {
      final cachedResult = await cacheLoader();
      if (cachedResult != null) {
        if (onSuccess != null) onSuccess(cachedResult);
        return cachedResult;
      }
    } catch (e) {
      debugPrint("Cache error: $e");
    }

    // Only show no internet message if we don"t have cached data
    if (onError != null) {
      onError("No internet connection and no cached data available");
    }
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("No internet connection")));
    }
    throw Exception("No internet connection and no cached data available");
  }

  if (!context.mounted) {
    throw Exception("Context no longer mounted");
  }

  // Show loading dialog
  bool dialogShowing = true;
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator.adaptive(),
          if (loadingText != null)
            Padding(
              padding: const EdgeInsets.only(top: 16.0),
              child: Text(
                loadingText,
                style: const TextStyle(color: Colors.white),
              ),
            ),
        ],
      ),
    ),
  ).then((_) => dialogShowing = false);

  try {
    final result = await loader();

    if (!context.mounted) {
      throw Exception("Context no longer mounted");
    }

    if (dialogShowing) {
      Navigator.of(context, rootNavigator: true).pop();
    }

    if (successMessage != null && context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(successMessage)));
    }

    if (onSuccess != null) onSuccess(result);
    return result;
  } catch (error) {
    if (context.mounted && dialogShowing) {
      Navigator.of(context, rootNavigator: true).pop();
    }

    // Try cache as fallback on network error
    try {
      final cachedResult = await cacheLoader();
      if (cachedResult != null) {
        if (onSuccess != null) onSuccess(cachedResult);
        return cachedResult;
      }
    } catch (e) {
      debugPrint("Cache error: $e");
    }

    if (onError != null) {
      onError(error);
    }

    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error.toString())));
    }

    throw Exception("Failed to load data: $error");
  }
}
