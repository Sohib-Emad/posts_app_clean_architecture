import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

abstract class NetworkChecker {
  Future<bool> get isConnected;
  Stream<bool> get onConnectionChange;
}

class NetworkCheckerImpl implements NetworkChecker {
  final InternetConnection connection;

  NetworkCheckerImpl({required this.connection});

  @override
  Future<bool> get isConnected async {
    return await connection.hasInternetAccess;
  }

  @override
  Stream<bool> get onConnectionChange => connection.onStatusChange.map(
    (status) => status == InternetStatus.connected,
  );
}
