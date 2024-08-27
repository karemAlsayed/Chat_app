


import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodeScreen extends StatefulWidget {
  const QrCodeScreen({super.key});

  @override
  State<QrCodeScreen> createState() => _QrCodeScreenState();
}

class _QrCodeScreenState extends State<QrCodeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code'),
      ),
      body:  Center(
        child:SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: Card(
                  color: Colors.white,
                  
                  child: QrImageView(
                    data: 'https://flutter.dev',
                    version: 3,
                    size: 200.0,
                    
                    
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}