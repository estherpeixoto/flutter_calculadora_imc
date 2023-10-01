import 'package:imc/models/imc_sqflite_model.dart';
import 'package:imc/repositories/sqflite/sqflite_database.dart';

class ImcSQFliteRepository {
  Future<List<ImcSQFliteModel>> selectAll() async {
    List<ImcSQFliteModel> imc = [];

    var db = await SQFliteDatabase().getDatabase();
    var result = await db.rawQuery('SELECT id, height, weight FROM imc');

    for (var element in result) {
      imc.add(ImcSQFliteModel(
          int.parse(element['id'].toString()),
          double.parse(element['height'].toString()),
          double.parse(element['weight'].toString())));
    }
    return imc;
  }

  Future<void> insert(ImcSQFliteModel imcSQFliteModel) async {
    var db = await SQFliteDatabase().getDatabase();

    await db.rawInsert('INSERT INTO imc (height, weight) values(?,?)',
        [imcSQFliteModel.height, imcSQFliteModel.weight]);
  }

  Future<void> update(ImcSQFliteModel imcSQFliteModel) async {
    var db = await SQFliteDatabase().getDatabase();

    await db.rawInsert('UPDATE imc SET height = ?, weight = ? WHERE id = ?',
        [imcSQFliteModel.height, imcSQFliteModel.weight, imcSQFliteModel.id]);
  }

  Future<void> delete(int id) async {
    var db = await SQFliteDatabase().getDatabase();
    await db.rawInsert('DELETE FROM imc WHERE id = ?', [id]);
  }
}
