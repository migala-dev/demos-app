import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BucketService {
  String? _bucketName;
  String _bucketNameKey = 'bucket-name-key';
  final _storage = new FlutterSecureStorage();
  static BucketService _imageService = new BucketService._internal();

  BucketService._internal();

  factory BucketService() {
    return _imageService;
  }

  Future<void> setBucketName(String bucketName) async {
    _bucketName = bucketName;
    await _storage.write(key: _bucketNameKey, value: bucketName);
  }

  Future<String?> _getBucketName() async {
    if (_bucketName != null) {
      return _bucketName;
    }

    String? bucketName = await _storage.read(key: _bucketNameKey);
    if (bucketName != null) {
      _bucketName = bucketName;
      return bucketName;
    }

    throw ErrorDescription('No bucket name set');
  }

  Future<String> getUrlFromKey(String? key) async {
    String? bucketName = await _getBucketName();
    return 'https://$bucketName.s3.amazonaws.com/$key';
  }
}
