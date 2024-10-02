import 'dart:async';
import '../services/database_services.dart';

class HourlyUsageTable {
  static String tableName = "hourly_usage";
  static String idColName = "id";
  static String timestampColName = "timestamp";
  static String usageColName = "usage";


  Future<void> insertUsageIntoHourlyUsageTable(double usage) async {
    final db = await DatabaseServices.instance.database;
    await db.insert(tableName, {
      timestampColName:DateTime.now().millisecondsSinceEpoch ~/ 1000,
      usageColName:usage
    });
  }

  Future<List<Map<String,dynamic>>> getHourlyUsageForDateRange(DateTime sDate,DateTime eDate) async{
    final db = await DatabaseServices.instance.database;
    final startDate = sDate.millisecondsSinceEpoch~/1000;
    final endDate = eDate.millisecondsSinceEpoch~/1000;
    return await db.query(tableName , where: "$timestampColName>=$startDate AND $timestampColName<=$endDate");
  }
}
