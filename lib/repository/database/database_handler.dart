import 'package:buro_employee/repository/models/apply_request.dart';
import 'package:buro_employee/repository/models/branch.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataBaseHandler {
  Future<Database> initializeDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'employee.db'),
      onCreate: (database, version) async {
        await database.execute(
          "CREATE TABLE apply(id INTEGER PRIMARY KEY NOT NULL,"
              "startDate TEXT NOT NULL,"
              "startTime TEXT NOT NULL,"
              "endDate TEXT NOT NULL,"
              "endTime TEXT NOT NULL,"
              "fromBranch TEXT NOT NULL,"
              "fromOther TEXT NOT NULL,"
              "toBranch TEXT NOT NULL,"
              "toOther TEXT NOT NULL,"
              "reason TEXT NOT NULL,"
              "transport TEXT NOT NULL,"
              "transportFare TEXT NOT NULL,"
              "morning TEXT NOT NULL,"
              "afternoon TEXT NOT NULL,"
              "night NOT NULL,"
              "hotel NOT NULL,"
              "dailyAllowance TEXT NOT NULL,"
              "specialAllowance TEXT NOT NULL ,"
              "planId INTEGER NOT NULL ,"
              "planName TEXT NOT NULL , createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP)",
        );

        },
      version: 2,
    );
  }

  Future<Database> initializeDBBranch() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'branch.db'),
      onCreate: (database, version) async {
      /*  await database.execute(
          "CREATE TABLE apply(id INTEGER PRIMARY KEY NOT NULL,startDate TEXT NOT NULL,startTime TEXT NOT NULL,endDate TEXT NOT NULL,endTime TEXT NOT NULL,startForm TEXT NOT NULL,endForm TEXT NOT NULL,reason TEXT NOT NULL,transport TEXT NOT NULL,createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP)",
        );*/

        await database.execute(
          "CREATE TABLE branch(id TEXT PRIMARY KEY NOT NULL,name TEXT NOT NULL)",
        );


      },
      version: 1,
    );
  }

  Future<int> insertApplyItem(ApplyRequest applyRequest) async {
    final db = await initializeDB();

    //print('Insert Id ${applyRequest.id} ');

   /* print("Insert Item applyRequest ${applyRequest.fromBranch}");

    print('insertApplyItem Apply Item fromBranch ${applyRequest.fromBranch}\n'
        'fromOther ${applyRequest.fromOther}\n'
        'toBranch ${applyRequest.toBranch}\n'
        'toOther ${applyRequest.toOther}');*/
    return await db.insert(
      'apply',
      applyRequest.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return 0;
  }

  Future<List<ApplyRequest>> applyList() async {
    final db = await initializeDB();
    late List<Map<String, dynamic>> maps;

    try {
      maps = await db.query('apply');
      //print('Maps ${maps.length}');
      maps.asMap().forEach((index, value) => {
            //print("Index $index Value $value")
          });
    } catch (Exc) {
      print('Exception $Exc');
    }

    return List.generate(maps.length, (i) {
      return ApplyRequest(
        maps[i]['id'],
        maps[i]['startDate'],
        maps[i]['startTime'],
        maps[i]['endDate'],
        maps[i]['endTime'],
        maps[i]['fromBranch'],
        maps[i]['fromOther'],
        maps[i]['toBranch'],
        maps[i]['toOther'],
        maps[i]['reason'],
        maps[i]['transport'],
        maps[i]['transportFare'],
        maps[i]['morning'],
        maps[i]['afternoon'],
        maps[i]['night'],
        maps[i]['hotel'],
        maps[i]['dailyAllowance'],
        maps[i]['specialAllowance'],
        maps[i]['planId'],
        maps[i]['planName']
      );
    });
  }

  Future<void> deleteApplyItem(int? id) async {
    print('Delete Item id $id');
    final db = await initializeDB();
    try {
      var resut = await db.delete(
        'apply',
        where: "id = ?",
        whereArgs: [id],
      ).catchError((Error) {
        print(' Error ${Error.toString()}');
      });

      print('Result $resut');
    } catch (exc) {
      print('${exc.toString()}');
    }
  }

  Future<int> updateItem(
      int id,
      String startDate,
      String startTime,
      String endDate,
      String endTime,
      String fromBranch,
      String fromOther,
      String toBranch,
      String toOther,
      String reason,
      String transport,
      String transportFare,
      String morning,
      String afternoon,
      String night,
      String hotel,
      String dailyAllowance,
      String specialAllowance,
      int planId,
      String planName
      ) async {
    final db = await initializeDB();

    final data = {
      'startDate': startDate,
      'startTime': startTime,
      'endDate': endDate,
      'endTime': endTime,
      'fromBranch': fromBranch,
      'fromOther': fromOther,
      'toBranch': toBranch,
      'toOther': toOther,
      'reason': reason,
      'transport': transport,
      'transportFare':transportFare,
      'morning':morning,
      'afternoon':afternoon,
      'night':night,
      'hotel':hotel,
      'dailyAllowance':dailyAllowance,
      'specialAllowance':specialAllowance,
      'planId':planId,
      'planName':planName
    };

    final result =
        await db.update('apply', data, where: "id = ?", whereArgs: [id]);

    print('Update Result $result');
    return result;
  }

  Future<void> deleteAllItem() async {
    //print('Delete Item id $id');
    final db = await initializeDB();
    try {
      var resut = await db
          .delete(
        'apply',
      )
          .catchError((Error) {
        print(' Error ${Error.toString()}');
      });

      print('Result $resut');
    } catch (exc) {
      print('${exc.toString()}');
    }
  }


  Future<int> insertBranchItem(Item item) async {
    final db = await initializeDBBranch();

    //print('Insert Id ${applyRequest.id} ');
    return await db.insert(
      'branch',
      item.toMap(),
      conflictAlgorithm: ConflictAlgorithm.ignore,
    );
  }
}
