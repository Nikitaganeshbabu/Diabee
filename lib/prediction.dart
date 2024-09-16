import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; 

class PredictionScreen extends StatefulWidget {
  @override
  _PredictionScreenState createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  String? _selectedAge;
  String? _selectedGender;
  String? _selectedPolyuria;
  String? _selectedPolydipsia;
  String? _selectedSuddenWeightLoss;
  String? _selectedWeakness;
  String? _selectedPolyphagia;
  String? _selectedGenitalThrush;
  String? _selectedVisualBlurring;
  String? _selectedItching;
  String? _selectedIrritability;
  String? _selectedDelayedHealing;
  String? _selectedPartialParesis;
  String? _selectedMuscleStiffness;
  String? _selectedAlopecia;
  String? _selectedObesity;
 
 Future<String> predictDiabetes() async {
    final response = await http.post(
      Uri.parse('http://192.168.1.40:8000/predict'),
     headers: <String, String>{
        'Content-Type': 'application/json', // Set content type to JSON
      },
      body: jsonEncode({
        'age': _selectedAge ?? '',
        'gender': _selectedGender ?? '',
        'polyuria': _selectedPolyuria ?? '',
        'polydipsia': _selectedPolydipsia ?? '',
        'sudden_weight_loss': _selectedSuddenWeightLoss ?? '',
        'weakness': _selectedWeakness ?? '',
        'polyphagia': _selectedPolyphagia ?? '',
        'genital_thrush': _selectedGenitalThrush ?? '',
        'visual_blurring': _selectedVisualBlurring ?? '',
        'itching': _selectedItching ?? '',
        'irritability': _selectedIrritability ?? '',
        'delayed_healing': _selectedDelayedHealing ?? '',
        'partial_paresis': _selectedPartialParesis ?? '',
        'muscle_stiffness': _selectedMuscleStiffness ?? '',
        'alopecia': _selectedAlopecia ?? '',
        'obesity': _selectedObesity ?? '',
      }),
    );
    if (response.statusCode == 200) {
      return response.body; // Return prediction (positive/negative)
    } else {
      throw Exception('Failed to predict');
    }
  }
  final List<String> ageList =
      List.generate(46, (index) => (index + 20).toString());
  final List<String> genderList = ['Male', 'Female'];
  final List<String> yesNoList = ['Yes', 'No'];
  final List<String> polyphagiaList = ['Yes', 'No'];
  final List<String> genitalThrushList = ['Yes', 'No'];
  final List<String> visualBlurringList = ['Yes', 'No'];
  final List<String> itchingList = ['Yes', 'No'];
  final List<String> irritabilityList = ['Yes', 'No'];
  final List<String> delayedHealingList = ['Yes', 'No'];
  final List<String> partialParesisList = ['Yes', 'No'];
  final List<String> muscleStiffnessList = ['Yes', 'No'];
  final List<String> alopeciaList = ['Yes', 'No'];
  final List<String> obesityList = ['Yes', 'No'];
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Diabetes Prediction'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Age:',
              style: TextStyle(fontSize: 16.0),
            ),
            DropdownButtonFormField(
              value: _selectedAge,
              onChanged: (value) {
                setState(() {
                  _selectedAge = value!;
                });
              },
              items: ageList.map((age) {
                return DropdownMenuItem(
                  value: age,
                  child: Text(age),
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            Text(
              'Gender:',
              style: TextStyle(fontSize: 16.0),
            ),
            DropdownButtonFormField(
              value: _selectedGender,
              onChanged: (value) {
                setState(() {
                  _selectedGender = value!;
                });
              },
              items: genderList.map((gender) {
                return DropdownMenuItem(
                  value: gender,
                  child: Text(gender),
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            Text(
              'Polyuria:',
              style: TextStyle(fontSize: 16.0),
            ),
            DropdownButtonFormField(
              value: _selectedPolyuria,
              onChanged: (value) {
                setState(() {
                  _selectedPolyuria = value!;
                });
              },
              items: yesNoList.map((option) {
                return DropdownMenuItem(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            Text(
              'Polydipsia:',
              style: TextStyle(fontSize: 16.0),
            ),
            DropdownButtonFormField(
              value: _selectedPolydipsia,
              onChanged: (value) {
                setState(() {
                  _selectedPolydipsia = value!;
                });
              },
              items: yesNoList.map((option) {
                return DropdownMenuItem(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            Text(
              'Sudden weight loss:',
              style: TextStyle(fontSize: 16.0),
            ),
            DropdownButtonFormField(
              value: _selectedSuddenWeightLoss,
              onChanged: (value) {
                setState(() {
                  _selectedSuddenWeightLoss = value!;
                });
              },
              items: yesNoList.map((option) {
                return DropdownMenuItem(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            Text(
              'Weakness:',
              style: TextStyle(fontSize: 16.0),
            ),
            DropdownButtonFormField(
              value: _selectedWeakness,
              onChanged: (value) {
                setState(() {
                  _selectedWeakness = value!;
                });
              },
              items: yesNoList.map((option) {
                return DropdownMenuItem(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            Text(
              'Polyphagia:',
              style: TextStyle(fontSize: 16.0),
            ),
            DropdownButtonFormField(
              value: _selectedPolyphagia,
              onChanged: (value) {
                setState(() {
                  _selectedPolyphagia = value!;
                });
              },
              items: yesNoList.map((option) {
                return DropdownMenuItem(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),

            Text(
              'Genital Thrush:',
              style: TextStyle(fontSize: 16.0),
            ),
            DropdownButtonFormField(
              value: _selectedGenitalThrush,
              onChanged: (value) {
                setState(() {
                  _selectedGenitalThrush = value!;
                });
              },
              items: yesNoList.map((option) {
                return DropdownMenuItem(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            Text(
              'Visual Blurring:',
              style: TextStyle(fontSize: 16.0),
            ),
            DropdownButtonFormField(
              value: _selectedVisualBlurring,
              onChanged: (value) {
                setState(() {
                  _selectedVisualBlurring = value!;
                });
              },
              items: yesNoList.map((option) {
                return DropdownMenuItem(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            Text(
              'Itching:',
              style: TextStyle(fontSize: 16.0),
            ),
            DropdownButtonFormField(
              value: _selectedItching,
              onChanged: (value) {
                setState(() {
                  _selectedItching = value!;
                });
              },
              items: yesNoList.map((option) {
                return DropdownMenuItem(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            Text(
              'Irritability:',
              style: TextStyle(fontSize: 16.0),
            ),
            DropdownButtonFormField(
              value: _selectedIrritability,
              onChanged: (value) {
                setState(() {
                  _selectedIrritability = value!;
                });
              },
              items: yesNoList.map((option) {
                return DropdownMenuItem(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
            ),
            SizedBox(
                height:
                    20.0), // Repeat similar blocks for the remaining parameters
            Text(
              'DelayedHealing:',
              style: TextStyle(fontSize: 16.0),
            ),
            DropdownButtonFormField(
              value: _selectedDelayedHealing,
              onChanged: (value) {
                setState(() {
                  _selectedDelayedHealing = value!;
                });
              },
              items: yesNoList.map((option) {
                return DropdownMenuItem(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            Text(
              'PartialParesis:',
              style: TextStyle(fontSize: 16.0),
            ),
            DropdownButtonFormField(
              value: _selectedPartialParesis,
              onChanged: (value) {
                setState(() {
                  _selectedPartialParesis = value!;
                });
              },
              items: yesNoList.map((option) {
                return DropdownMenuItem(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            Text(
              'MuscleStiffness:',
              style: TextStyle(fontSize: 16.0),
            ),
            DropdownButtonFormField(
              value: _selectedMuscleStiffness,
              onChanged: (value) {
                setState(() {
                  _selectedMuscleStiffness = value!;
                });
              },
              items: yesNoList.map((option) {
                return DropdownMenuItem(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            Text(
              'Alopecia:',
              style: TextStyle(fontSize: 16.0),
            ),
            DropdownButtonFormField(
              value: _selectedAlopecia,
              onChanged: (value) {
                setState(() {
                  _selectedAlopecia = value!;
                });
              },
              items: yesNoList.map((option) {
                return DropdownMenuItem(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            Text(
              'Obesity:',
              style: TextStyle(fontSize: 16.0),
            ),
            DropdownButtonFormField(
              value: _selectedObesity,
              onChanged: (value) {
                setState(() {
                  _selectedObesity = value!;
                });
              },
              items: yesNoList.map((option) {
                return DropdownMenuItem(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                predictDiabetes().then((prediction) {
                  // Show prediction result
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text('Prediction Result'),
                      content: Text(prediction),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Close'),
                        ),
                      ],
                    ),
                  );
                }).catchError((error) {
                  // Show error if prediction fails
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text('Prediction Error'),
                      content: Text(error.toString()),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text('Close'),
                        ),
                      ],
                    ),
                  );
                });
              },
              child: Text('Go for Prediction'),
            ),
          ],
        ),
      ),
    );
  }
}
