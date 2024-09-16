import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

class ScannerScreen extends StatefulWidget {
  @override
  _ScannerScreenState createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final CollectionReference barcodeCollection =
      FirebaseFirestore.instance.collection('Barcode');
  TextEditingController _ingredientController = TextEditingController();
  String _nutritionInfo = '';

  @override
  void dispose() {
    _ingredientController.dispose();
    super.dispose();
  }

  Future<void> _getNutritionInfo(String ingredient) async {
    final String appId = 'c40b2057';
    final String appKey = '2846a3e6040cafec42c4cf5b7c9508ff';
    final String endpoint =
        'https://api.edamam.com/api/nutrition-data?app_id=$appId&app_key=$appKey&ingr=$ingredient&nutrition-type=logging';

    try {
      final response = await http.get(Uri.parse(endpoint));
      if (response.statusCode == 200) {
        setState(() {
          _nutritionInfo = response.body;
        });
      } else {
        throw Exception('Failed to load nutrition info');
      }
    } catch (e) {
      setState(() {
        _nutritionInfo = 'Failed to fetch nutrition info: $e';
      });
    }
  }

  Future<void> _postRecipeAndGetNutritionInfo(Map<String, dynamic> recipe) async {
    // Implement your POST request here
  }

  Future<void> _scanBarcodeAndGetData(BuildContext context) async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.BARCODE,
      );
      debugPrint(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform';
    }

    DocumentSnapshot barcodeDoc =
        await barcodeCollection.doc(barcodeScanRes).get();

    String resultMessage = 'Barcode not found';
    if (barcodeDoc.exists) {
      final data = barcodeDoc.data() as Map<String, dynamic>;
      resultMessage = 'Item: ${data['Item_name'] ?? 'Unknown'}';
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Scan Result'),
        content: Text(resultMessage),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scanner'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: _ingredientController,
            decoration: InputDecoration(labelText: 'Enter Ingredient'),
          ),
          ElevatedButton(
            onPressed: () async {
              String ingredient = _ingredientController.text;
              await _getNutritionInfo(ingredient);
              // Optionally, you can also post the recipe and get nutrition info
              // await _postRecipeAndGetNutritionInfo(recipe);
            },
            child: Text('OK'),
          ),
          Text(_nutritionInfo),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        icon: Icon(Icons.camera_alt),
        label: Text("Scan"),
        onPressed: () => _scanBarcodeAndGetData(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
