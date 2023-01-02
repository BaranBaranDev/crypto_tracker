import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'model.dart';

abstract class IService {
  // Interface
  Future<List<CoinModel>?>
      fetchItems(); // dışarıdan ulaşılmaması için  methodu soyut sınıf içinden yolluyorum
}

class CoinService implements IService {
  final Dio _dio;
  CoinService() : _dio = Dio();

  @override
  Future<List<CoinModel>?> fetchItems() async {
    // apide ki veriler modellendi ve dönüşüm modelmiz
    try {
      final response = await _dio.get(_path);
      if (response.statusCode == HttpStatus.ok) {
        final datas = response.data;
        if (datas is List) {
          return datas.map((json) => CoinModel.fromJson(json)).toList();
        }
      }
    } on DioError catch (error) {
      // hatanın tipi
      if (kDebugMode) {
        print(error.message);
      }
    }
    return null;
  }
}

String get _path =>
    "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=100&page=1&sparkline=false";
