import 'dart:async';
import 'package:riverpod/riverpod.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

final connectivityProvider = StreamProvider<ConnectivityResult>((ref) {
  final connectivity = Connectivity();
  final controller = StreamController<ConnectivityResult>();

  ConnectivityResult handleConnectivityList(List<ConnectivityResult> results) {
    if (results.isEmpty) return ConnectivityResult.none;
    return results.first;
  }

  void checkInitialConnectivity() async {
    try {
      final List<ConnectivityResult> initialResults = await connectivity.checkConnectivity();
      final result = handleConnectivityList(initialResults);
      controller.add(result);
    } catch (e) {
      controller.addError(e);
    }
  }

  checkInitialConnectivity();

  final subscription = connectivity.onConnectivityChanged.listen(
        (List<ConnectivityResult> results) {
      final result = handleConnectivityList(results);
      controller.add(result);
    },
    onError: (error) => controller.addError(error),
  );

  ref.onDispose(() {
    subscription.cancel();
    controller.close();
  });

  return controller.stream;
});

final isConnectedProvider = Provider<bool>((ref) {
  final connectivityResult = ref.watch(connectivityProvider).value;
  if (connectivityResult == null) return false;

  return connectivityResult == ConnectivityResult.mobile ||
      connectivityResult == ConnectivityResult.wifi;
});