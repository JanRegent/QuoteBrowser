// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tags.dart';

// ignore_for_file: type=lint
class $TagsItemsTable extends TagsItems
    with TableInfo<$TagsItemsTable, TagsItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TagsItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _tagMeta = const VerificationMeta('tag');
  @override
  late final GeneratedColumn<String> tag = GeneratedColumn<String>(
      'tag', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _rownosMeta = const VerificationMeta('rownos');
  @override
  late final GeneratedColumn<String> rownos = GeneratedColumn<String>(
      'rownos', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, tag, rownos];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tags_items';
  @override
  VerificationContext validateIntegrity(Insertable<TagsItem> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('tag')) {
      context.handle(
          _tagMeta, tag.isAcceptableOrUnknown(data['tag']!, _tagMeta));
    } else if (isInserting) {
      context.missing(_tagMeta);
    }
    if (data.containsKey('rownos')) {
      context.handle(_rownosMeta,
          rownos.isAcceptableOrUnknown(data['rownos']!, _rownosMeta));
    } else if (isInserting) {
      context.missing(_rownosMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  TagsItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return TagsItem(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      tag: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tag'])!,
      rownos: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}rownos'])!,
    );
  }

  @override
  $TagsItemsTable createAlias(String alias) {
    return $TagsItemsTable(attachedDatabase, alias);
  }
}

class TagsItem extends DataClass implements Insertable<TagsItem> {
  final int id;
  final String tag;
  final String rownos;
  const TagsItem({required this.id, required this.tag, required this.rownos});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['tag'] = Variable<String>(tag);
    map['rownos'] = Variable<String>(rownos);
    return map;
  }

  TagsItemsCompanion toCompanion(bool nullToAbsent) {
    return TagsItemsCompanion(
      id: Value(id),
      tag: Value(tag),
      rownos: Value(rownos),
    );
  }

  factory TagsItem.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return TagsItem(
      id: serializer.fromJson<int>(json['id']),
      tag: serializer.fromJson<String>(json['tag']),
      rownos: serializer.fromJson<String>(json['rownos']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'tag': serializer.toJson<String>(tag),
      'rownos': serializer.toJson<String>(rownos),
    };
  }

  TagsItem copyWith({int? id, String? tag, String? rownos}) => TagsItem(
        id: id ?? this.id,
        tag: tag ?? this.tag,
        rownos: rownos ?? this.rownos,
      );
  @override
  String toString() {
    return (StringBuffer('TagsItem(')
          ..write('id: $id, ')
          ..write('tag: $tag, ')
          ..write('rownos: $rownos')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, tag, rownos);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is TagsItem &&
          other.id == this.id &&
          other.tag == this.tag &&
          other.rownos == this.rownos);
}

class TagsItemsCompanion extends UpdateCompanion<TagsItem> {
  final Value<int> id;
  final Value<String> tag;
  final Value<String> rownos;
  const TagsItemsCompanion({
    this.id = const Value.absent(),
    this.tag = const Value.absent(),
    this.rownos = const Value.absent(),
  });
  TagsItemsCompanion.insert({
    this.id = const Value.absent(),
    required String tag,
    required String rownos,
  })  : tag = Value(tag),
        rownos = Value(rownos);
  static Insertable<TagsItem> custom({
    Expression<int>? id,
    Expression<String>? tag,
    Expression<String>? rownos,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (tag != null) 'tag': tag,
      if (rownos != null) 'rownos': rownos,
    });
  }

  TagsItemsCompanion copyWith(
      {Value<int>? id, Value<String>? tag, Value<String>? rownos}) {
    return TagsItemsCompanion(
      id: id ?? this.id,
      tag: tag ?? this.tag,
      rownos: rownos ?? this.rownos,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (tag.present) {
      map['tag'] = Variable<String>(tag.value);
    }
    if (rownos.present) {
      map['rownos'] = Variable<String>(rownos.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TagsItemsCompanion(')
          ..write('id: $id, ')
          ..write('tag: $tag, ')
          ..write('rownos: $rownos')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $TagsItemsTable tagsItems = $TagsItemsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [tagsItems];
}
