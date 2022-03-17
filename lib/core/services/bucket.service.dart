/*
  DEMOS
  Copyright (C) 2022 Julian Alejandro Ortega Zepeda, Erik Ivanov Domínguez Rivera, Luis Ángel Meza Acosta
  This file is part of DEMOS.

  DEMOS is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  DEMOS is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <https://www.gnu.org/licenses/>.
*/

import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class BucketService {
  String? _bucketName;
  final String _bucketNameKey = 'bucket-name-key';
  final _storage = const FlutterSecureStorage();
  static final BucketService _imageService = BucketService._internal();

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
