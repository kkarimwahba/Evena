import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCode extends StatelessWidget {
  final String qrCode;
  const QrCode({
    Key? key,
    required this.qrCode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    if (qrCode == '') {
      return const Text('Enter Code');
    } else {
      return QrImageView(
        data: qrCode,
        version: QrVersions.auto,
        size: height * 0.45,
      );
    }
    // }
  }
}
