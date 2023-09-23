import 'package:imc/models/pessoa.dart';

class ImcRepository {
  final List<Pessoa> _imc = [];

  Future<void> add(Pessoa imc) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _imc.add(imc);
  }

  /* Future<void> edit(String id, bool done) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _imc.where((task) => task.id == id).first.done = done;
  } */

  Future<void> remove(String id) async {
    await Future.delayed(const Duration(milliseconds: 100));
    _imc.remove(_imc.where((imc) => imc.id == id).first);
  }

  Future<List<Pessoa>> list() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _imc;
  }

  /* Future<List<Imc>> listNotFinished() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return _imc.where((imc) => !imc.done).toList();
  } */
}