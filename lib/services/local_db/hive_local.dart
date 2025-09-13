import 'package:hive/hive.dart';
import 'package:noviindus/services/local_db/hive_constants.dart';
// import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

class HiveLocal {
  final Box<dynamic> _box;

  HiveLocal._(this._box);

  static Future<HiveLocal> getInstance() async {
    final directory = await getApplicationDocumentsDirectory();
    Hive.init(directory.path);
    // Hive.registerAdapter(UserDataAdapter());

    final box = await Hive.openBox<dynamic>(DataBoxes.kUser);
    return HiveLocal._(box);
  }

  Box getBox(String? boxType) {
    return Hive.box(boxType!);
  }

  //saving data in local
  saveData(String? key, dynamic data) {
    getBox(DataBoxes.kUser).put(key, data);
  }

  //getting data from local
  dynamic getData(String? key) {
    return getBox(DataBoxes.kUser).get(key, defaultValue: null);
  }

  //delete saved data from local
  deleteData(String? key) async {
    await getBox(DataBoxes.kUser).delete(key);
  }

  logout() async {
    await deleteData(DataBoxKey.kauthKey);
    await _box.clear();
    await _box.close();
    print('All data cleared from Hive on logout.');
  }
}
