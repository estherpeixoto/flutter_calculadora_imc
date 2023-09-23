import 'package:imc/models/pessoa.dart';
import 'package:imc/repositories/imc_repository.dart';
import 'package:flutter/material.dart';
import 'package:imc/services/calculadora_imc.dart';
import 'package:imc/utils/input_utils.dart';

class MyHomePage extends StatefulWidget {
  final String appName;

  const MyHomePage({Key? key, required this.appName}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();

  var imcRepository = ImcRepository();
  var _imc = const <Pessoa>[];
  var pesoController = TextEditingController();
  var alturaController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getImcList();
  }

  void getImcList() async {
    _imc = await imcRepository.list();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.appName),
          backgroundColor: Colors.deepPurpleAccent.withOpacity(0.3)
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            pesoController.text = "";
            alturaController.text = "";

            showDialog(
                context: context,
                builder: (BuildContext bc) {
                  return AlertDialog(
                    title: const Text("Add pessoa"),
                    content: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: pesoController,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            decoration: const InputDecoration(
                              labelText: 'Peso (kg)',
                            ),
                            validator: (value) {
                              try {
                                if (value == null || value.isEmpty) {
                                  return 'Preencha';
                                }

                                double peso = InputUtils.stringToDouble(value);

                                if (peso <= 0) {
                                  return 'Peso inválido';
                                }
                              } catch (e) {
                                return 'Formato inválido';
                              }

                              return null;
                            },
                          ),
                          TextFormField(
                            controller: alturaController,
                            keyboardType: const TextInputType.numberWithOptions(decimal: true),
                            decoration: const InputDecoration(
                              labelText: 'Altura (metros)',
                            ),
                            validator: (value) {
                              try {
                                if (value == null || value.isEmpty) {
                                  return 'Preencha';
                                }

                                double altura = InputUtils.stringToDouble(value);

                                if (altura <= 0) {
                                  return 'Altura inválida';
                                }
                              } catch (e) {
                                return 'Formato inválido';
                              }

                              return null;
                            },
                          )
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancel")),
                      TextButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              await imcRepository.add(
                                  Pessoa(
                                      InputUtils.stringToDouble(pesoController.text),
                                      InputUtils.stringToDouble(alturaController.text)
                                  )
                              );

                              if (context.mounted) {
                                Navigator.pop(context);
                              }

                              setState(() {});
                            }
                          },
                          child: const Text("Save"))
                    ],
                  );
                });
          },
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: _imc.length,
                    itemBuilder: (BuildContext bc, int index) {
                      var pessoa = _imc[index];
                      var calculadora = CalculadoraImc();
                      return Dismissible(
                        onDismissed: (DismissDirection dismissDirection) async {
                          await imcRepository.remove(pessoa.id);
                          getImcList();
                        },
                        key: Key(pessoa.id),
                        child: ListTile(
                          title: Text(calculadora.resultado(pessoa)),
                          subtitle: Text("Peso: ${pessoa.getPeso()}\nAltura: ${pessoa.getAltura()}"),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ));
  }
}