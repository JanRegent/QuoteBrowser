import 'package:isar/isar.dart';

part 'email.g.dart';
//dart run build_runner build

@collection
class Email {
  Email({
    this.id = -1,
    this.title,
    this.recipients,
    this.status = Status.pending,
  });

  final int id;

  @Index()
  final String? title;

  final List<Recipient>? recipients;

  final Status status;
}

@embedded
class Recipient {
  String? name;

  String? address;
}

enum Status {
  draft,
  pending,
  sent,
}
