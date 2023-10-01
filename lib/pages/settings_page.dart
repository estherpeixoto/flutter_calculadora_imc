import 'package:flutter/material.dart';
import 'package:imc/models/settings_model.dart';
import 'package:imc/repositories/settings_repository.dart';
import 'package:imc/utils/input_utils.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final _formKey = GlobalKey<FormState>();
  var heightController = TextEditingController();

  void loadSettings() async {
    var settingsRepository = await SettingsRepository.get();
    heightController.text = settingsRepository.getFormattedHeight();
  }

  @override
  void initState() {
    super.initState();
    loadSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Settings'),
          backgroundColor: Colors.deepPurpleAccent.withOpacity(0.3),
          actions: [
            TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Save settings
                    var settingsModel = SettingsModel(
                        InputUtils.stringToDouble(heightController.text));
                    SettingsRepository.save(settingsModel);

                    // Go back to previous page
                    Navigator.of(context).pop();
                  }
                },
                child: const Text('Save')),
          ],
        ),
        body: Container(
            margin: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: TextFormField(
                controller: heightController,
                decoration: const InputDecoration(
                    labelText: 'Height (m)', border: OutlineInputBorder()),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  try {
                    if (value == null || value.isEmpty) {
                      return 'Fill';
                    }

                    double height = InputUtils.stringToDouble(value);
                    if (height <= 0) {
                      return 'Invalid height';
                    }
                  } catch (e) {
                    return 'Invalid format';
                  }

                  return null;
                },
              ),
            )));
  }
}
