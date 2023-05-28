import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:online_bazaar/core/exceptions/network_exception.dart';

class NetworkInfo {
  final _internetChecker = InternetConnectionCheckerPlus();

  Future<bool> get isConnected => _internetChecker.hasConnection;

  Future<void> checkConnection() async {
    if (!await isConnected) {
      throw NetworkException('Tidak ada koneksi internet.');
    }
  }
}
