import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfoI {
  Future<bool> isConnected();

  Future<List<ConnectivityResult>> get connectivityResult;

  Stream<List<ConnectivityResult>> get onConnectivityChanged;
}

class NetworkInfo implements NetworkInfoI {
  final Connectivity connectivity;

  NetworkInfo(this.connectivity);

  /// Check internet connection
  @override
  Future<bool> isConnected() async {
    final result = await connectivity.checkConnectivity();

    return result.isNotEmpty &&
        !result.contains(ConnectivityResult.none);
  }

  /// Get current connectivity type
  @override
  Future<List<ConnectivityResult>> get connectivityResult {
    return connectivity.checkConnectivity();
  }

  /// Listen to connectivity changes
  @override
  Stream<List<ConnectivityResult>> get onConnectivityChanged =>
      connectivity.onConnectivityChanged;
}
