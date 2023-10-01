import 'package:flutter/material.dart';
import 'package:imc/models/imc_sqflite_model.dart';
import 'package:imc/pages/settings_page.dart';
import 'package:imc/repositories/sqflite/imc_sqflite_repository.dart';
import 'package:imc/services/calculator.dart';
import 'package:imc/utils/input_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  final String appName;

  const MyHomePage({Key? key, required this.appName}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var imcSQFliteRepository = ImcSQFliteRepository();
  var _imc = const <ImcSQFliteModel>[];

  final _formKey = GlobalKey<FormState>();
  var weightController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getImcList();
  }

  void getImcList() async {
    _imc = await imcSQFliteRepository.selectAll();
    setState(() {});
  }

  void handleFormSubmit() async {
    if (_formKey.currentState!.validate()) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final double height = prefs.getDouble('height') ?? 0.0;

      await imcSQFliteRepository.insert(ImcSQFliteModel(
          0,
          InputUtils.stringToDouble(height.toStringAsFixed(2)),
          InputUtils.stringToDouble(weightController.text)));

      if (context.mounted) {
        Navigator.pop(context);
      }

      getImcList();

      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.appName),
          backgroundColor: Colors.deepPurpleAccent.withOpacity(0.3),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SettingsPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.settings)),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            weightController.text = '';

            showDialog(
                context: context,
                builder: (BuildContext bc) {
                  return AlertDialog(
                    title: const Text('Add new weight'),
                    content: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: weightController,
                            keyboardType: const TextInputType.numberWithOptions(
                                decimal: true),
                            decoration: const InputDecoration(
                              labelText: 'Weight (kg)',
                            ),
                            validator: (value) {
                              try {
                                if (value == null || value.isEmpty) {
                                  return 'Fill';
                                }

                                double peso = InputUtils.stringToDouble(value);

                                if (peso <= 0) {
                                  return 'Invalid weight';
                                }
                              } catch (e) {
                                return 'Invalid format';
                              }

                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel')),
                      TextButton(
                          onPressed: handleFormSubmit,
                          child: const Text('Save'))
                    ],
                  );
                });
          },
        ),
        body: Container(
          margin: const EdgeInsets.all(16),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: _imc.length,
                    itemBuilder: (BuildContext bc, int index) {
                      var imc = _imc[index];
                      var calculator = Calculator();
                      return Dismissible(
                        onDismissed: (DismissDirection dismissDirection) async {
                          await imcSQFliteRepository.delete(imc.id);
                          getImcList();
                        },
                        key: Key(imc.id.toString()),
                        child: ListTile(
                          title: Text(calculator.result(imc)),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Weight: ${imc.weight} kg'),
                              Text('Height: ${imc.height} m'),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ));
  }
}
