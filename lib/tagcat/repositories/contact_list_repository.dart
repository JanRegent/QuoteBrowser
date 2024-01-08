import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entities/contact.dart';

import 'package:sqflite/sqflite.dart';

const String contactTable = 'contactTable';
const String idColumn = 'idColumn';
const String nameColumn = 'nameColumn';
const String surenameColumn = 'surenameColumn';
const String emailColumn = 'emailColumn';

class ContactListRepository {
  Database? _db;

  Future<Database> get db async {
    if (_db != null) {
      return _db!;
    } else {
      _db = await initDb();
      return _db!;
    }
  }

  Future<Database> initDb() async {
    return await openDatabase('./contact_list.db', version: 1,
        onCreate: (db, newerVersion) async {
      await db.execute('CREATE TABLE $contactTable('
          '$idColumn INTEGER PRIMARY KEY,'
          '$nameColumn TEXT,'
          '$emailColumn TEXT,'
          '$surenameColumn TEXT)');
    });
  }

  Future<Contact> saveContact(Contact contact) async {
    var dbContact = await db;
    contact.id = await dbContact.insert(contactTable, contact.toMap());
    return contact;
  }

  Future<Contact?> getContact(int id) async {
    var dbContact = await db;
    List<Map<String, dynamic>> maps = await dbContact.query(contactTable,
        columns: [idColumn, nameColumn, emailColumn, surenameColumn],
        where: '$idColumn = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      return Contact.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteContact(int id) async {
    var dbContact = await db;
    return await dbContact
        .delete(contactTable, where: '$idColumn = ?', whereArgs: [id]);
  }

  Future<int> updateContact(Contact contact) async {
    var dbContact = await db;
    return await dbContact.update(contactTable, contact.toMap(),
        where: '$idColumn = ?', whereArgs: [contact.id]);
  }

  Future<List<Contact>> getContactList(String filterText) async {
    List<Contact> contactList = [];
    var dbContact = await db;
    List listMap = await dbContact.rawQuery('SELECT * FROM $contactTable');
    if (filterText.isNotEmpty) {
      List<Contact> list = [];
      for (Map<String, dynamic> m in listMap) {
        Contact contact = Contact.fromMap(m);
        if ('${contact.name.toLowerCase()} ${contact.surename.toLowerCase()}'
            .contains(filterText.toLowerCase())) {
          list.add(contact);
        }
      }
      return list;
    } else {
      for (Map<String, dynamic> m in listMap) {
        Contact contact = Contact.fromMap(m);
        contactList.add(contact);
      }
      return contactList;
    }
  }
}

/// Providers used by rest of the app
final contactListRepositoryProvider = Provider<ContactListRepository>((ref) {
  return ContactListRepository();
});
