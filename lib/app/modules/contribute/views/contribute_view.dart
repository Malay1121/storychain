import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/contribute_controller.dart';

class ContributeView extends GetView<ContributeController> {
  const ContributeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ContributeView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ContributeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
