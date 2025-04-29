/*import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:get/get.dart';
import 'qr_scanner_controller.dart';

class QRScannerScreen extends GetView<QRScannerController> {
  const QRScannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: QRView(
              key: controller.qrKey,
              onQRViewCreated: controller.onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: ElevatedButton(
              onPressed: () => Get.back(),
              child: const Text("Cerrar"),
            ),
          ),
        ],
      ),
    );
  }
}
*/