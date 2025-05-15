import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static Isar? _isar;

  /// Initialize the Isar database
  static Future<void> initialize(List<CollectionSchema<dynamic>> schemas) async {
    if (_isar == null) {
      final dir = await getApplicationDocumentsDirectory();
      _isar = await Isar.open(
        schemas,
        directory: dir.path,
      );
    }
  }

  /// Get the Isar instance
  static Isar get isar {
    if (_isar == null) {
      throw Exception('Isar database is not initialized. Call initialize() first.');
    }
    return _isar!;
  }

  /// Add an object to the database
  static Future<void> add<T>(T object) async {
    await isar.writeTxn(() async {
      await isar.collection<T>().put(object);
    });
  }

  /// Add multiple objects to the database
  static Future<void> addAll<T>(List<T> objects) async {
    await isar.writeTxn(() async {
      await isar.collection<T>().putAll(objects);
    });
  }

  /// Retrieve all objects of a specific type
  static Future<List<T>> getAll<T>() async {
    return await isar.collection<T>().where().findAll();
  }

  /// Retrieve an object by its ID
  static Future<T?> getById<T>(int id) async {
    return await isar.collection<T>().get(id);
  }

  /// Update an object in the database
  static Future<void> update<T>(T object) async {
    await isar.writeTxn(() async {
      await isar.collection<T>().put(object);
    });
  }

  /// Delete an object by its ID
  static Future<void> deleteById<T>(int id) async {
    await isar.writeTxn(() async {
      await isar.collection<T>().delete(id);
    });
  }

  /// Delete all objects of a specific type
  static Future<void> deleteAll<T>() async {
    await isar.writeTxn(() async {
      await isar.collection<T>().clear();
    });
  }

  /// Query objects with a custom filter
static Future<List<T>> query<T>(Future<List<T>> Function(QueryBuilder<T, T, QWhere>) filter) async {
  final queryBuilder = isar.collection<T>().where();
  return await filter(queryBuilder);
}
}