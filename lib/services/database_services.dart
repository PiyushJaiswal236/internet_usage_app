import 'package:internet_usage_app/tables/hourly_usage.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';


class DatabaseServices{

  DatabaseServices._internal();

  static final instance = DatabaseServices._internal();
  // Database reference
  static Database? _database;

  HourlyUsageTable hourlyUsageTable= HourlyUsageTable();

  // Getter for the database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize the database
  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'my_database_test1.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  // Create the database schema
  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE ${HourlyUsageTable.tableName} (
        ${HourlyUsageTable.idColName} INTEGER PRIMARY KEY,
        ${HourlyUsageTable.timestampColName} INTEGER  NOT NULL,
        ${HourlyUsageTable.usageColName} REAL NOT NULL
      )
    ''');

  }


}