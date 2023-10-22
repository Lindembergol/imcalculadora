import 'package:calcimc/model/imc.dart';
import 'package:calcimc/repository/imc_repository.dart';
import 'package:flutter/material.dart';

class ImcPage extends StatefulWidget {
  const ImcPage({super.key});

  @override
  State<ImcPage> createState() => _ImcPageState();
}

class _ImcPageState extends State<ImcPage> {
  var pesoController = TextEditingController();
  var alturaController = TextEditingController();
  var resultadoController = TextEditingController();

  var imcRepository = ImcRepository();

  var _imc = const <Imc>[];

  String grauImc = '';
  String peso = '';
  String altura = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    obterImc();
  }

  void obterImc() async {
    _imc = await imcRepository.listarImc();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora IMC'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext bc) {
                pesoController.text = '';
                alturaController.text = '';
                return AlertDialog(
                  title: const Text('Informe seu peso e altura:'),
                  content: Wrap(children: [
                    Column(
                      children: [
                        const Text('Peso'),
                        TextField(
                          controller: pesoController,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text('Altura'),
                        TextField(
                          controller: alturaController,
                        ),
                      ],
                    ),
                  ]),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cancelar')),
                    TextButton(
                        onPressed: () async {
                          double peso;
                          double altura;
                          String result;

                          peso = double.parse(pesoController.text);
                          altura = double.parse(alturaController.text);

                          result = (peso + (altura * altura)).toString();

                          String res = result.substring(0, 2);

                          resultadoController.text = res;

                          if (double.parse(res) < 18.5) {
                            grauImc = 'Magreza';
                          } else if (double.parse(res) >= 18.5 &&
                              double.parse(res) < 25) {
                            grauImc = 'Normal';
                          } else if (double.parse(res) >= 25 &&
                              double.parse(res) < 30) {
                            grauImc = 'Sobrepeso';
                          } else if (double.parse(res) >= 30 &&
                              double.parse(res) < 35) {
                            grauImc = 'Obesidade grau I';
                          } else if (double.parse(res) >= 35 &&
                              double.parse(res) < 40) {
                            grauImc = 'Obesidade grau II';
                          } else {
                            grauImc = 'Obesidade grau III';
                          }

                          await imcRepository
                              .adicionarTarefa(Imc(resultadoController.text));
                          Navigator.pop(context);
                          setState(() {});
                        },
                        child: const Text('Calcular')),
                  ],
                );
              });
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
          itemCount: _imc.length,
          itemBuilder: (BuildContext context, int index) {
            var imc = _imc[index];
            return ListTile(
              leading: Icon(Icons.calculate),
              trailing: Text(
                imc.resultado,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              title: Text('IMC'),
              subtitle: Text(grauImc),
            );
          }),
    );
  }
}
