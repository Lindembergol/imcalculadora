import 'package:calcimc/model/imc.dart';

class ImcRepository {
  List<Imc> _imc = [];

  Future<void> adicionarTarefa(Imc imc) async {
    await Future.delayed(const Duration(milliseconds: 0));
    _imc.add(imc);
  }

  Future<List<Imc>> listarImc() async {
    await Future.delayed(const Duration(milliseconds: 0));
    return _imc;
  }
}
