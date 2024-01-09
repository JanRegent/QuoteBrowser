// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sheetrowscrud.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetSheetRowCollection on Isar {
  IsarCollection<String, SheetRow> get sheetRows => this.collection();
}

const SheetRowSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'SheetRow',
    idName: 'sheetRownoKey',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'sheetRownoKey',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'rowNo',
        type: IsarType.long,
      ),
      IsarPropertySchema(
        name: 'sheetRowArr',
        type: IsarType.stringList,
      ),
    ],
    indexes: [],
  ),
  converter: IsarObjectConverter<String, SheetRow>(
    serialize: serializeSheetRow,
    deserialize: deserializeSheetRow,
    deserializeProperty: deserializeSheetRowProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeSheetRow(IsarWriter writer, SheetRow object) {
  IsarCore.writeString(writer, 1, object.sheetRownoKey);
  IsarCore.writeLong(writer, 2, object.rowNo);
  {
    final list = object.sheetRowArr;
    final listWriter = IsarCore.beginList(writer, 3, list.length);
    for (var i = 0; i < list.length; i++) {
      IsarCore.writeString(listWriter, i, list[i]);
    }
    IsarCore.endList(writer, listWriter);
  }
  return Isar.fastHash(object.sheetRownoKey);
}

@isarProtected
SheetRow deserializeSheetRow(IsarReader reader) {
  final object = SheetRow();
  object.sheetRownoKey = IsarCore.readString(reader, 1) ?? '';
  object.rowNo = IsarCore.readLong(reader, 2);
  {
    final length = IsarCore.readList(reader, 3, IsarCore.readerPtrPtr);
    {
      final reader = IsarCore.readerPtr;
      if (reader.isNull) {
        object.sheetRowArr = const <String>[];
      } else {
        final list = List<String>.filled(length, '', growable: true);
        for (var i = 0; i < length; i++) {
          list[i] = IsarCore.readString(reader, i) ?? '';
        }
        IsarCore.freeReader(reader);
        object.sheetRowArr = list;
      }
    }
  }
  return object;
}

@isarProtected
dynamic deserializeSheetRowProp(IsarReader reader, int property) {
  switch (property) {
    case 1:
      return IsarCore.readString(reader, 1) ?? '';
    case 2:
      return IsarCore.readLong(reader, 2);
    case 3:
      {
        final length = IsarCore.readList(reader, 3, IsarCore.readerPtrPtr);
        {
          final reader = IsarCore.readerPtr;
          if (reader.isNull) {
            return const <String>[];
          } else {
            final list = List<String>.filled(length, '', growable: true);
            for (var i = 0; i < length; i++) {
              list[i] = IsarCore.readString(reader, i) ?? '';
            }
            IsarCore.freeReader(reader);
            return list;
          }
        }
      }
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _SheetRowUpdate {
  bool call({
    required String sheetRownoKey,
    int? rowNo,
  });
}

class _SheetRowUpdateImpl implements _SheetRowUpdate {
  const _SheetRowUpdateImpl(this.collection);

  final IsarCollection<String, SheetRow> collection;

  @override
  bool call({
    required String sheetRownoKey,
    Object? rowNo = ignore,
  }) {
    return collection.updateProperties([
          sheetRownoKey
        ], {
          if (rowNo != ignore) 2: rowNo as int?,
        }) >
        0;
  }
}

sealed class _SheetRowUpdateAll {
  int call({
    required List<String> sheetRownoKey,
    int? rowNo,
  });
}

class _SheetRowUpdateAllImpl implements _SheetRowUpdateAll {
  const _SheetRowUpdateAllImpl(this.collection);

  final IsarCollection<String, SheetRow> collection;

  @override
  int call({
    required List<String> sheetRownoKey,
    Object? rowNo = ignore,
  }) {
    return collection.updateProperties(sheetRownoKey, {
      if (rowNo != ignore) 2: rowNo as int?,
    });
  }
}

extension SheetRowUpdate on IsarCollection<String, SheetRow> {
  _SheetRowUpdate get update => _SheetRowUpdateImpl(this);

  _SheetRowUpdateAll get updateAll => _SheetRowUpdateAllImpl(this);
}

sealed class _SheetRowQueryUpdate {
  int call({
    int? rowNo,
  });
}

class _SheetRowQueryUpdateImpl implements _SheetRowQueryUpdate {
  const _SheetRowQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<SheetRow> query;
  final int? limit;

  @override
  int call({
    Object? rowNo = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (rowNo != ignore) 2: rowNo as int?,
    });
  }
}

extension SheetRowQueryUpdate on IsarQuery<SheetRow> {
  _SheetRowQueryUpdate get updateFirst =>
      _SheetRowQueryUpdateImpl(this, limit: 1);

  _SheetRowQueryUpdate get updateAll => _SheetRowQueryUpdateImpl(this);
}

class _SheetRowQueryBuilderUpdateImpl implements _SheetRowQueryUpdate {
  const _SheetRowQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<SheetRow, SheetRow, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? rowNo = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (rowNo != ignore) 2: rowNo as int?,
      });
    } finally {
      q.close();
    }
  }
}

extension SheetRowQueryBuilderUpdate
    on QueryBuilder<SheetRow, SheetRow, QOperations> {
  _SheetRowQueryUpdate get updateFirst =>
      _SheetRowQueryBuilderUpdateImpl(this, limit: 1);

  _SheetRowQueryUpdate get updateAll => _SheetRowQueryBuilderUpdateImpl(this);
}

extension SheetRowQueryFilter
    on QueryBuilder<SheetRow, SheetRow, QFilterCondition> {
  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition> sheetRownoKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition>
      sheetRownoKeyGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition>
      sheetRownoKeyGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition> sheetRownoKeyLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition>
      sheetRownoKeyLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition> sheetRownoKeyBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 1,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition>
      sheetRownoKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition> sheetRownoKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition> sheetRownoKeyContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 1,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition> sheetRownoKeyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 1,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition>
      sheetRownoKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition>
      sheetRownoKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition> rowNoEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 2,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition> rowNoGreaterThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 2,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition>
      rowNoGreaterThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 2,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition> rowNoLessThan(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 2,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition>
      rowNoLessThanOrEqualTo(
    int value,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 2,
          value: value,
        ),
      );
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition> rowNoBetween(
    int lower,
    int upper,
  ) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 2,
          lower: lower,
          upper: upper,
        ),
      );
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition>
      sheetRowArrElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition>
      sheetRowArrElementGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition>
      sheetRowArrElementGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition>
      sheetRowArrElementLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition>
      sheetRowArrElementLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition>
      sheetRowArrElementBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 3,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition>
      sheetRowArrElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition>
      sheetRowArrElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition>
      sheetRowArrElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 3,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition>
      sheetRowArrElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 3,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition>
      sheetRowArrElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition>
      sheetRowArrElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition> sheetRowArrIsEmpty() {
    return not().sheetRowArrIsNotEmpty();
  }

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition>
      sheetRowArrIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 3, value: null),
      );
    });
  }
}

extension SheetRowQueryObject
    on QueryBuilder<SheetRow, SheetRow, QFilterCondition> {}

extension SheetRowQuerySortBy on QueryBuilder<SheetRow, SheetRow, QSortBy> {
  QueryBuilder<SheetRow, SheetRow, QAfterSortBy> sortBySheetRownoKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterSortBy> sortBySheetRownoKeyDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterSortBy> sortByRowNo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2);
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterSortBy> sortByRowNoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc);
    });
  }
}

extension SheetRowQuerySortThenBy
    on QueryBuilder<SheetRow, SheetRow, QSortThenBy> {
  QueryBuilder<SheetRow, SheetRow, QAfterSortBy> thenBySheetRownoKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterSortBy> thenBySheetRownoKeyDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterSortBy> thenByRowNo() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2);
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterSortBy> thenByRowNoDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc);
    });
  }
}

extension SheetRowQueryWhereDistinct
    on QueryBuilder<SheetRow, SheetRow, QDistinct> {
  QueryBuilder<SheetRow, SheetRow, QAfterDistinct> distinctByRowNo() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2);
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterDistinct> distinctBySheetRowArr() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3);
    });
  }
}

extension SheetRowQueryProperty1
    on QueryBuilder<SheetRow, SheetRow, QProperty> {
  QueryBuilder<SheetRow, String, QAfterProperty> sheetRownoKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<SheetRow, int, QAfterProperty> rowNoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<SheetRow, List<String>, QAfterProperty> sheetRowArrProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }
}

extension SheetRowQueryProperty2<R>
    on QueryBuilder<SheetRow, R, QAfterProperty> {
  QueryBuilder<SheetRow, (R, String), QAfterProperty> sheetRownoKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<SheetRow, (R, int), QAfterProperty> rowNoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<SheetRow, (R, List<String>), QAfterProperty>
      sheetRowArrProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }
}

extension SheetRowQueryProperty3<R1, R2>
    on QueryBuilder<SheetRow, (R1, R2), QAfterProperty> {
  QueryBuilder<SheetRow, (R1, R2, String), QOperations>
      sheetRownoKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<SheetRow, (R1, R2, int), QOperations> rowNoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<SheetRow, (R1, R2, List<String>), QOperations>
      sheetRowArrProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }
}
