import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

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
/// If an error occurs during the [loader]'s execution, the loading dialog is
/// dismissed, the [onError] callback is invoked with the error, and a `SnackBar`
/// displaying the error message is shown.
///
/// The [context] is used to show/hide dialogs and SnackBars. It's crucial
/// that the widget associated with this [context] remains mounted during the
/// asynchronous operations. Checks for `context.mounted` are included to prevent
/// errors if the widget is disposed.
Future<void> executeNetworkOperation<T>({
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
      onError(Exception("No internet connection. Please check your network."));
    } else {
      // Default error handling if no onError callback is provided
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("No internet connection")));
    }
    return; // Exit the function if no network
  }

  if (!context.mounted) return;
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) =>
        const Center(child: CircularProgressIndicator.adaptive()),
  );

  try {
    final result = await loader();

    if (!context.mounted) return;
    Navigator.of(context, rootNavigator: true).pop();

    if (successMessage != null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(successMessage)));
    }

    if (onSuccess != null) onSuccess(result);
  } catch (error) {
    if (!context.mounted) return;
    Navigator.of(context, rootNavigator: true).pop();

    if (onError != null) {
      onError(error);
    }

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(error.toString())));
  }
}
