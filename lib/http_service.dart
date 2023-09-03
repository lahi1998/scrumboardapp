import 'dart:io';
import 'package:flutter/services.dart';

class HttpClientService {
  //late final String ipAddress;
  //late final int port;
  late final HttpClient _httpClient;

  HttpClient get httpClient => _httpClient;

  HttpClientService();

  Future<void> initialiseHttpClient() async {
    ByteData ca = await rootBundle.load('assets/rootCA.pem');
    ByteData cert = await rootBundle.load('assets/fluttertest-client+4.pem');
    ByteData key = await rootBundle.load('assets/fluttertest-client+4-key.pem');

    List<int> caBytes = ca.buffer.asUint8List(ca.offsetInBytes, ca.lengthInBytes);
    List<int> certBytes = cert.buffer.asUint8List(cert.offsetInBytes, cert.lengthInBytes);
    List<int> keyBytes = key.buffer.asUint8List(key.offsetInBytes, key.lengthInBytes);

    SecurityContext secContext = SecurityContext(withTrustedRoots: true)
      ..setTrustedCertificatesBytes(caBytes)
      ..useCertificateChainBytes(certBytes)
      ..usePrivateKeyBytes(keyBytes);

    _httpClient = HttpClient(context: secContext);
  }
}
