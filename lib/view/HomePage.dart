// ignore_for_file: file_names

import 'package:crypto_tracker/controller/loading_controller.dart';
import 'package:crypto_tracker/service/model.dart';
import 'package:crypto_tracker/service/services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CoinModel>? _items;
  final LoadController _controller = Get.put(LoadController());
  late final IService _service;

  @override
  void initState() {
    super.initState();
    _service = CoinService();
    fetchItems();
  }

  Future<void> fetchItems() async {
    _controller.change();
    _items = await _service.fetchItems();
    _controller.change();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(actions: [
        _controller.isLoading.value
            ? const CircularProgressIndicator()
            : const SizedBox.shrink()
      ]),
      body: ListView.builder(
        itemCount: _items?.length ?? 0,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(_items?[index].name ?? 'not found'),
            subtitle: Text(_items?[index].currentPrice.toString() ?? ""),
          );
        },
      ),
    );
  }
}
