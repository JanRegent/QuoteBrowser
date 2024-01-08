const String idColumn = 'idColumn';
const String nameColumn = 'nameColumn';
const String surenameColumn = 'surenameColumn';
const String emailColumn = 'emailColumn';

class Contact {
  int id = 0;
  final String name;
  final String surename;
  final String email;

  Contact({
    required this.id,
    required this.name,
    required this.surename,
    required this.email,
  });

  @override
  String toString() {
    return 'Contact($id, $name $surename, $email)';
  }

  static Contact fromMap(Map<String, dynamic> map) {
    return Contact(
        id: map[idColumn],
        name: map[nameColumn],
        surename: map[surenameColumn],
        email: map[emailColumn]);
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      nameColumn: name,
      emailColumn: email,
      surenameColumn: surename,
    };
    if (id > 0) {
      map[idColumn] = id;
    }
    return map;
  }
}
