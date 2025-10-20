import 'dart:io';
import 'package:furniture_shop/model/model.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class CartDBHelper {
  CartDBHelper._();
  static final CartDBHelper getinstance = CartDBHelper._();

  static const String TABLE_CART = 'cart';
  static const String COLUMN_ID = 'id';
  static const String COLUMN_NAME = 'name';
  static const String COLUMN_TYPE = 'type';
  static const String COLUMN_IMAGE_URL = 'imageUrl';
  static const String COLUMN_PRICE = 'price';

  Database? _db;

  Future<Database> get database async {
    _db ??= await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String path = join(documentsDir.path, 'cartnewDB.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $TABLE_CART(
            $COLUMN_ID TEXT PRIMARY KEY,
            $COLUMN_NAME TEXT,
            $COLUMN_TYPE TEXT,
            $COLUMN_IMAGE_URL TEXT,
            $COLUMN_PRICE REAL
          )
        ''');
      },
    );
  }

  // Insert product
  Future<void> insertProduct(Product product) async {
    final db = await database;
    await db.insert(
      TABLE_CART,
      {
        COLUMN_ID: product.id,
        COLUMN_NAME: product.name,
        COLUMN_TYPE: product.type,
        COLUMN_IMAGE_URL: product.imageUrl,
        COLUMN_PRICE: product.price,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // Get all products
  Future<List<Product>> getAllProducts() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(TABLE_CART);

    return List.generate(maps.length, (i) {
      return Product(
        id: maps[i][COLUMN_ID],
        name: maps[i][COLUMN_NAME],
        type: maps[i][COLUMN_TYPE],
        imageUrl: maps[i][COLUMN_IMAGE_URL],
        price: maps[i][COLUMN_PRICE],
        // fill non-used fields with default values if Product requires them
        category: '',
        description: '',
        rating: 0.0,
        isNew: false,
      );
    });
  }

  // Delete a product by id
  Future<void> deleteProduct(String id) async {
    final db = await database;
    await db.delete(TABLE_CART, where: '$COLUMN_ID = ?', whereArgs: [id]);
  }

  // Clear all
  Future<void> clearCart() async {
    final db = await database;
    await db.delete(TABLE_CART);
  }
}
