import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:html' as html;
// ignore: uri_does_not_exist
import 'dart:indexed_db' as idb
    if (dart.library.html) 'dart:indexed_db';
import 'dart:convert';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;
  static idb.Database? _webDatabase;
  static const String _dbName = 'wellnessbridge_db';
  static const int _dbVersion = 1;

  Future<Database?> get database async {
    if (kIsWeb) {
      await _initWebDatabase();
      return null; // Return null for web, use _webDatabase instead
    }
    
    if (_database != null) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  // Initialize IndexedDB for web
  Future<void> _initWebDatabase() async {
    if (_webDatabase != null) return;

    try {
      _webDatabase = await html.window.indexedDB!.open(_dbName, version: _dbVersion,
        onUpgradeNeeded: (idb.VersionChangeEvent event) {
          idb.Database db = event.target.result as idb.Database;
          
          // Create object stores (similar to tables)
          _createWebTables(db);
        });
      
      print('IndexedDB initialized successfully for offline web storage');
    } catch (e) {
      print('Error initializing IndexedDB: $e');
      rethrow;
    }
  }

  void _createWebTables(idb.Database db) {
    // Create stores for each table
    List<String> tableNames = [
      'birth_properties', 'cadres', 'children', 'child_health_records',
      'health_restrictions', 'health_workers', 'projects', 'project_assignments', 'users'
    ];

    for (String tableName in tableNames) {
      if (!db.objectStoreNames!.contains(tableName)) {
        var store = db.createObjectStore(tableName, autoIncrement: true);
        // Create indexes for common queries
        store.createIndex('isSynced', 'isSynced', unique: false);
        store.createIndex('remoteId', 'remoteId', unique: false);
      }
    }
  }

  // SQLite initialization (for mobile)
  Future<Database> _initDatabase() async {
    if (kIsWeb) {
      throw UnsupportedError('Use IndexedDB for web');
    }

    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'wellnessbridge.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onConfigure: _onConfigure,
    );
  }

  Future<String> getDatabasePath() async {
    if (kIsWeb) {
      return 'IndexedDB: $_dbName (persistent browser storage)';
    }
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    return join(documentsDirectory.path, 'wellnessbridge.db');
  }

  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future<void> _onCreate(Database db, int version) async {
    // --- `birth_properties` Table ---
    await db.execute('''
      CREATE TABLE birth_properties(
        bID INTEGER PRIMARY KEY AUTOINCREMENT,
        childID INTEGER NOT NULL,
        motherAge INTEGER NOT NULL,
        fatherAge INTEGER NOT NULL,
        numberOfChildren INTEGER NOT NULL,
        birthType TEXT NOT NULL,
        birthWeight REAL NOT NULL,
        childCondition TEXT NOT NULL,
        created_at TEXT,
        updated_at TEXT,
        isSynced INTEGER NOT NULL DEFAULT 0, -- Flag for offline-first sync
        remoteId INTEGER,                    -- Remote MySQL ID for syncing
        FOREIGN KEY (childID) REFERENCES children (childID) ON DELETE CASCADE
      )
    ''');

    // --- `cadres` Table ---
    await db.execute('''
      CREATE TABLE cadres(
        cadID INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT NOT NULL,
        qualification TEXT NOT NULL,
        created_at TEXT,
        updated_at TEXT,
        isSynced INTEGER NOT NULL DEFAULT 0,
        remoteId INTEGER
      )
    ''');

    // --- `children` Table ---
    await db.execute('''
      CREATE TABLE children(
        childID INTEGER PRIMARY KEY AUTOINCREMENT,
        firstName TEXT NOT NULL,
        lastName TEXT NOT NULL,
        gender TEXT NOT NULL,
        dob TEXT NOT NULL, -- Storing DATE as TEXT (ISO 8601 format)
        allergies TEXT,
        location TEXT NOT NULL,
        parentName TEXT NOT NULL,
        parentContact TEXT NOT NULL,
        healthWorkerID INTEGER NOT NULL,
        created_at TEXT,
        updated_at TEXT,
        isSynced INTEGER NOT NULL DEFAULT 0,
        remoteId INTEGER,
        FOREIGN KEY (healthWorkerID) REFERENCES health_workers (hwID) ON DELETE CASCADE
      )
    ''');

    // --- `child_health_records` Table ---
    await db.execute('''
      CREATE TABLE child_health_records(
        recordID INTEGER PRIMARY KEY AUTOINCREMENT,
        childID INTEGER NOT NULL,
        healthWorkerID INTEGER NOT NULL,
        recordDate TEXT NOT NULL, -- Storing DATE as TEXT
        diagnosis TEXT NOT NULL,
        treatment TEXT NOT NULL,
        notes TEXT,
        created_at TEXT,
        updated_at TEXT,
        isSynced INTEGER NOT NULL DEFAULT 0,
        remoteId INTEGER,
        FOREIGN KEY (childID) REFERENCES children (childID) ON DELETE CASCADE,
        FOREIGN KEY (healthWorkerID) REFERENCES health_workers (hwID) ON DELETE CASCADE
      )
    ''');

    // --- `failed_jobs` Table (Usually not synced, purely local Laravel internal) ---
    // Note: This table is typically for Laravel's internal job queue management and doesn't
    // usually need to be synced to the mobile app or have isSynced/remoteId.
    await db.execute('''
      CREATE TABLE failed_jobs(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        uuid TEXT NOT NULL UNIQUE,
        connection TEXT NOT NULL,
        queue TEXT NOT NULL,
        payload TEXT NOT NULL,
        exception TEXT NOT NULL,
        failed_at TEXT DEFAULT CURRENT_TIMESTAMP
      )
    ''');

    // --- `health_restrictions` Table ---
    await db.execute('''
      CREATE TABLE health_restrictions(
        hrID INTEGER PRIMARY KEY AUTOINCREMENT,
        recordID INTEGER NOT NULL,
        restrictionName TEXT NOT NULL,
        description TEXT NOT NULL,
        created_at TEXT,
        updated_at TEXT,
        isSynced INTEGER NOT NULL DEFAULT 0,
        remoteId INTEGER,
        FOREIGN KEY (recordID) REFERENCES child_health_records (recordID) ON DELETE CASCADE
      )
    ''');

    // --- `health_workers` Table ---
    await db.execute('''
      CREATE TABLE health_workers(
        hwID INTEGER PRIMARY KEY AUTOINCREMENT,
        firstName TEXT NOT NULL,
        lastName TEXT NOT NULL,
        phoneNumber TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        address TEXT NOT NULL,
        cadID INTEGER NOT NULL,
        created_at TEXT,
        updated_at TEXT,
        isSynced INTEGER NOT NULL DEFAULT 0,
        remoteId INTEGER,
        FOREIGN KEY (cadID) REFERENCES cadres (cadID) ON DELETE CASCADE
      )
    ''');

    // --- `migrations` Table (Usually not synced, purely local Laravel internal) ---
    // Note: This table is for Laravel's database migration tracking. Not needed for app sync.
    await db.execute('''
      CREATE TABLE migrations(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        migration TEXT NOT NULL,
        batch INTEGER NOT NULL
      )
    ''');

    // --- `password_reset_tokens` Table (Not synced, for Laravel's reset token management) ---
    await db.execute('''
      CREATE TABLE password_reset_tokens(
        email TEXT PRIMARY KEY NOT NULL,
        token TEXT NOT NULL,
        created_at TEXT
      )
    ''');

    // --- `personal_access_tokens` Table (Not synced, for Laravel's API token management) ---
    await db.execute('''
      CREATE TABLE personal_access_tokens(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        tokenable_type TEXT NOT NULL,
        tokenable_id INTEGER NOT NULL,
        name TEXT NOT NULL,
        token TEXT NOT NULL UNIQUE,
        abilities TEXT,
        last_used_at TEXT,
        expires_at TEXT,
        created_at TEXT,
        updated_at TEXT
      )
    ''');

    // --- `projects` Table ---
    await db.execute('''
      CREATE TABLE projects(
        prjID INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        description TEXT NOT NULL,
        startDate TEXT NOT NULL, -- Storing DATE as TEXT
        endDate TEXT NOT NULL,   -- Storing DATE as TEXT
        budget REAL NOT NULL,
        status TEXT NOT NULL,
        cadID INTEGER NOT NULL,
        created_at TEXT,
        updated_at TEXT,
        isSynced INTEGER NOT NULL DEFAULT 0,
        remoteId INTEGER,
        FOREIGN KEY (cadID) REFERENCES cadres (cadID) ON DELETE CASCADE
      )
    ''');

    // --- `project_assignments` Table ---
    await db.execute('''
      CREATE TABLE project_assignments(
        assignID INTEGER PRIMARY KEY AUTOINCREMENT,
        prjID INTEGER NOT NULL,
        hwID INTEGER NOT NULL,
        assignmentDate TEXT NOT NULL, -- Storing DATE as TEXT
        role TEXT NOT NULL,
        created_at TEXT,
        updated_at TEXT,
        isSynced INTEGER NOT NULL DEFAULT 0,
        remoteId INTEGER,
        FOREIGN KEY (prjID) REFERENCES projects (prjID) ON DELETE CASCADE,
        FOREIGN KEY (hwID) REFERENCES health_workers (hwID) ON DELETE CASCADE
      )
    ''');

    // --- `users` Table (If you plan to sync user data beyond authentication) ---
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        email_verified_at TEXT,
        password TEXT NOT NULL,
        remember_token TEXT,
        created_at TEXT,
        updated_at TEXT,
        isSynced INTEGER NOT NULL DEFAULT 0,
        remoteId INTEGER
      )
    ''');
   }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print('Database upgraded from version $oldVersion to $newVersion');
  }

  // Generic insert with web support
  Future<int> insert(String tableName, Map<String, dynamic> data) async {
    if (kIsWeb) {
      return await _webInsert(tableName, data);
    }
    
    Database db = await database as Database;
    return await db.insert(
      tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> _webInsert(String tableName, Map<String, dynamic> data) async {
    await _initWebDatabase();
    
    data['created_at'] = DateTime.now().toIso8601String();
    data['isSynced'] ??= 0;
    
    var transaction = _webDatabase!.transaction([tableName], 'readwrite');
    var store = transaction.objectStore(tableName);
    
    try {
      var key = await store.add(data);
      await transaction.completed;
      return key as int;
    } catch (e) {
      print('Error inserting into $tableName: $e');
      return -1;
    }
  }

  // Generic query with web support
  Future<List<Map<String, dynamic>>> queryAll(String tableName) async {
    if (kIsWeb) {
      return await _webQueryAll(tableName);
    }
    
    Database db = await database as Database;
    return await db.query(tableName);
  }

  Future<List<Map<String, dynamic>>> _webQueryAll(String tableName) async {
    await _initWebDatabase();
    
    var transaction = _webDatabase!.transaction([tableName], 'readonly');
    var store = transaction.objectStore(tableName);
    
    try {
      var cursors = store.openCursor();
      List<Map<String, dynamic>> results = [];
      
      await for (var cursor in cursors) {
        if (cursor.value != null) {
          Map<String, dynamic> record = Map<String, dynamic>.from(cursor.value as Map);
          record['id'] = cursor.primaryKey; // Add the key as id
          results.add(record);
        }
      }
      
      return results;
    } catch (e) {
      print('Error querying $tableName: $e');
      return [];
    }
  }

  // Update method with web support
  Future<int> update(
    String tableName,
    String primaryKeyColumn,
    Map<String, dynamic> data,
  ) async {
    if (kIsWeb) {
      return await _webUpdate(tableName, primaryKeyColumn, data);
    }
    
    Database db = await database as Database;
    dynamic id = data[primaryKeyColumn];
    return await db.update(
      tableName,
      data,
      where: '$primaryKeyColumn = ?',
      whereArgs: [id],
    );
  }

  Future<int> _webUpdate(String tableName, String primaryKeyColumn, Map<String, dynamic> data) async {
    await _initWebDatabase();
    
    dynamic id = data[primaryKeyColumn];
    data['updated_at'] = DateTime.now().toIso8601String();
    
    var transaction = _webDatabase!.transaction([tableName], 'readwrite');
    var store = transaction.objectStore(tableName);
    
    try {
      await store.put(data, id);
      await transaction.completed;
      return 1;
    } catch (e) {
      print('Error updating $tableName: $e');
      return 0;
    }
  }

  // Delete method with web support
  Future<int> delete(String tableName, String primaryKeyColumn, dynamic id) async {
    if (kIsWeb) {
      return await _webDelete(tableName, id);
    }
    
    Database db = await database as Database;
    return await db.delete(
      tableName,
      where: '$primaryKeyColumn = ?',
      whereArgs: [id],
    );
  }

  Future<int> _webDelete(String tableName, dynamic id) async {
    await _initWebDatabase();
    
    var transaction = _webDatabase!.transaction([tableName], 'readwrite');
    var store = transaction.objectStore(tableName);
    
    try {
      await store.delete(id);
      await transaction.completed;
      return 1;
    } catch (e) {
      print('Error deleting from $tableName: $e');
      return 0;
    }
  }

  // Get unsynced records
  Future<List<Map<String, dynamic>>> getUnsyncedRecords(String tableName) async {
    if (kIsWeb) {
      return await _webGetUnsyncedRecords(tableName);
    }
    
    Database db = await database as Database;
    return await db.query(tableName, where: 'isSynced = ?', whereArgs: [0]);
  }

  Future<List<Map<String, dynamic>>> _webGetUnsyncedRecords(String tableName) async {
    await _initWebDatabase();
    
    var transaction = _webDatabase!.transaction([tableName], 'readonly');
    var store = transaction.objectStore(tableName);
    var index = store.index('isSynced');
    
    try {
      var cursors = index.openCursor(key: 0);
      List<Map<String, dynamic>> results = [];
      
      await for (var cursor in cursors) {
        if (cursor.value != null) {
          Map<String, dynamic> record = Map<String, dynamic>.from(cursor.value as Map);
          record['id'] = cursor.primaryKey;
          results.add(record);
        }
      }
      
      return results;
    } catch (e) {
      print('Error getting unsynced records from $tableName: $e');
      return [];
    }
  }

  Future<int> markRecordAsSynced(
    String tableName,
    String primaryKeyColumn,
    int localId,
    int remoteId,
  ) async {
    Map<String, dynamic> updateData = {
      primaryKeyColumn: localId,
      'isSynced': 1,
      'remoteId': remoteId,
      'updated_at': DateTime.now().toIso8601String(),
    };
    
    return await update(tableName, primaryKeyColumn, updateData);
  }

  Future<void> close() async {
    if (kIsWeb) {
      _webDatabase?.close();
      _webDatabase = null;
      return;
    }
    
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }

  // Verification method
  Future<void> verifyDatabaseTables() async {
    try {
      print('=== DATABASE VERIFICATION ===');
      print('Platform: ${kIsWeb ? "Web (IndexedDB)" : "Mobile (SQLite)"}');
      print('Database Path: ${await getDatabasePath()}');
      
      if (kIsWeb) {
        await _initWebDatabase();
        print('IndexedDB Object Stores: ${_webDatabase!.objectStoreNames!.length}');
        for (String storeName in _webDatabase!.objectStoreNames!) {
          var records = await queryAll(storeName);
          print('  $storeName: ${records.length} records');
        }
      } else {
        Database db = await database as Database;
        List<Map<String, dynamic>> tables = await db.rawQuery(
          "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'"
        );
        
        print('SQLite Tables: ${tables.length}');
        for (var table in tables) {
          String tableName = table['name'];
          List<Map<String, dynamic>> count = await db.rawQuery(
            'SELECT COUNT(*) as count FROM $tableName'
          );
          print('  $tableName: ${count.first['count']} records');
        }
      }
      
      print('=== END VERIFICATION ===');
    } catch (e) {
      print('Database verification error: $e');
    }
  }
}