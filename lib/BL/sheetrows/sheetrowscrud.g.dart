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
        name: 'sheetRowArr',
        type: IsarType.string,
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
  IsarCore.writeString(writer, 2, object.sheetRowArr);
  return Isar.fastHash(object.sheetRownoKey);
}

@isarProtected
SheetRow deserializeSheetRow(IsarReader reader) {
  final object = SheetRow();
  object.sheetRownoKey = IsarCore.readString(reader, 1) ?? '';
  object.sheetRowArr = IsarCore.readString(reader, 2) ?? '';
  return object;
}

@isarProtected
dynamic deserializeSheetRowProp(IsarReader reader, int property) {
  switch (property) {
    case 1:
      return IsarCore.readString(reader, 1) ?? '';
    case 2:
      return IsarCore.readString(reader, 2) ?? '';
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _SheetRowUpdate {
  bool call({
    required String sheetRownoKey,
    String? sheetRowArr,
  });
}

class _SheetRowUpdateImpl implements _SheetRowUpdate {
  const _SheetRowUpdateImpl(this.collection);

  final IsarCollection<String, SheetRow> collection;

  @override
  bool call({
    required String sheetRownoKey,
    Object? sheetRowArr = ignore,
  }) {
    return collection.updateProperties([
          sheetRownoKey
        ], {
          if (sheetRowArr != ignore) 2: sheetRowArr as String?,
        }) >
        0;
  }
}

sealed class _SheetRowUpdateAll {
  int call({
    required List<String> sheetRownoKey,
    String? sheetRowArr,
  });
}

class _SheetRowUpdateAllImpl implements _SheetRowUpdateAll {
  const _SheetRowUpdateAllImpl(this.collection);

  final IsarCollection<String, SheetRow> collection;

  @override
  int call({
    required List<String> sheetRownoKey,
    Object? sheetRowArr = ignore,
  }) {
    return collection.updateProperties(sheetRownoKey, {
      if (sheetRowArr != ignore) 2: sheetRowArr as String?,
    });
  }
}

extension SheetRowUpdate on IsarCollection<String, SheetRow> {
  _SheetRowUpdate get update => _SheetRowUpdateImpl(this);

  _SheetRowUpdateAll get updateAll => _SheetRowUpdateAllImpl(this);
}

sealed class _SheetRowQueryUpdate {
  int call({
    String? sheetRowArr,
  });
}

class _SheetRowQueryUpdateImpl implements _SheetRowQueryUpdate {
  const _SheetRowQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<SheetRow> query;
  final int? limit;

  @override
  int call({
    Object? sheetRowArr = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (sheetRowArr != ignore) 2: sheetRowArr as String?,
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
    Object? sheetRowArr = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (sheetRowArr != ignore) 2: sheetRowArr as String?,
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

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition> sheetRowArrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition>
      sheetRowArrGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition>
      sheetRowArrGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition> sheetRowArrLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition>
      sheetRowArrLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition> sheetRowArrBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 2,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition> sheetRowArrStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition> sheetRowArrEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition> sheetRowArrContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 2,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition> sheetRowArrMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 2,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition> sheetRowArrIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition>
      sheetRowArrIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 2,
          value: '',
        ),
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

  QueryBuilder<SheetRow, SheetRow, QAfterSortBy> sortBySheetRowArr(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterSortBy> sortBySheetRowArrDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
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

  QueryBuilder<SheetRow, SheetRow, QAfterSortBy> thenBySheetRowArr(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SheetRow, SheetRow, QAfterSortBy> thenBySheetRowArrDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }
}

extension SheetRowQueryWhereDistinct
    on QueryBuilder<SheetRow, SheetRow, QDistinct> {
  QueryBuilder<SheetRow, SheetRow, QAfterDistinct> distinctBySheetRowArr(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
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

  QueryBuilder<SheetRow, String, QAfterProperty> sheetRowArrProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
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

  QueryBuilder<SheetRow, (R, String), QAfterProperty> sheetRowArrProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
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

  QueryBuilder<SheetRow, (R1, R2, String), QOperations> sheetRowArrProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }
}
