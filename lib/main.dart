import 'package:flutter/material.dart';
import 'package:twitter_qr_scanner/twitter_qr_scanner.dart';
import 'package:twitter_qr_scanner/QrScannerOverlayShape.dart';
import 'package:yami/institutionPage.dart';

void main(){
  runApp( MaterialApp(
    home:QRExample(),
  ));
}

class QRExample extends StatefulWidget {
  QRExample({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _QRExampleState createState() => _QRExampleState();
}

class _QRExampleState extends State<QRExample> {
  GlobalKey qrKey = GlobalKey();
  QRViewController controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: QRView(
          key: qrKey,
          overlay: QrScannerOverlayShape(
              borderRadius: 16,
              borderColor: Colors.white,
              borderLength: 120,
              borderWidth: 10,
              cutOutSize: 250),
          onQRViewCreated: _onQRViewCreate,
          data: "QR TEXT",
        ));
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreate(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        print("QRCode: $scanData");
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                InstitutionPage(qrCodeResult: scanData),
          ),
        );
      });

    });
  }
}