// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sheetcolscrud.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetSheetColCollection on Isar {
  IsarCollection<String, SheetCol> get sheetCols => this.collection();
}

const SheetColSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'SheetCol',
    idName: 'sheetRownoKey',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'sheetRownoKey',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'cols',
        type: IsarType.string,
      ),
    ],
    indexes: [],
  ),
  converter: IsarObjectConverter<String, SheetCol>(
    serialize: serializeSheetCol,
    deserialize: deserializeSheetCol,
    deserializeProperty: deserializeSheetColProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeSheetCol(IsarWriter writer, SheetCol object) {
  IsarCore.writeString(writer, 1, object.sheetRownoKey);
  IsarCore.writeString(writer, 2, object.cols);
  return Isar.fastHash(object.sheetRownoKey);
}

@isarProtected
SheetCol deserializeSheetCol(IsarReader reader) {
  final object = SheetCol();
  object.sheetRownoKey = IsarCore.readString(reader, 1) ?? '';
  object.cols = IsarCore.readString(reader, 2) ?? '';
  return object;
}

@isarProtected
dynamic deserializeSheetColProp(IsarReader reader, int property) {
  switch (property) {
    case 1:
      return IsarCore.readString(reader, 1) ?? '';
    case 2:
      return IsarCore.readString(reader, 2) ?? '';
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _SheetColUpdate {
  bool call({
    required String sheetRownoKey,
    String? cols,
  });
}

class _SheetColUpdateImpl implements _SheetColUpdate {
  const _SheetColUpdateImpl(this.collection);

  final IsarCollection<String, SheetCol> collection;

  @override
  bool call({
    required String sheetRownoKey,
    Object? cols = ignore,
  }) {
    return collection.updateProperties([
          sheetRownoKey
        ], {
          if (cols != ignore) 2: cols as String?,
        }) >
        0;
  }
}

sealed class _SheetColUpdateAll {
  int call({
    required List<String> sheetRownoKey,
    String? cols,
  });
}

class _SheetColUpdateAllImpl implements _SheetColUpdateAll {
  const _SheetColUpdateAllImpl(this.collection);

  final IsarCollection<String, SheetCol> collection;

  @override
  int call({
    required List<String> sheetRownoKey,
    Object? cols = ignore,
  }) {
    return collection.updateProperties(sheetRownoKey, {
      if (cols != ignore) 2: cols as String?,
    });
  }
}

extension SheetColUpdate on IsarCollection<String, SheetCol> {
  _SheetColUpdate get update => _SheetColUpdateImpl(this);

  _SheetColUpdateAll get updateAll => _SheetColUpdateAllImpl(this);
}

sealed class _SheetColQueryUpdate {
  int call({
    String? cols,
  });
}

class _SheetColQueryUpdateImpl implements _SheetColQueryUpdate {
  const _SheetColQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<SheetCol> query;
  final int? limit;

  @override
  int call({
    Object? cols = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (cols != ignore) 2: cols as String?,
    });
  }
}

extension SheetColQueryUpdate on IsarQuery<SheetCol> {
  _SheetColQueryUpdate get updateFirst =>
      _SheetColQueryUpdateImpl(this, limit: 1);

  _SheetColQueryUpdate get updateAll => _SheetColQueryUpdateImpl(this);
}

class _SheetColQueryBuilderUpdateImpl implements _SheetColQueryUpdate {
  const _SheetColQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<SheetCol, SheetCol, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? cols = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (cols != ignore) 2: cols as String?,
      });
    } finally {
      q.close();
    }
  }
}

extension SheetColQueryBuilderUpdate
    on QueryBuilder<SheetCol, SheetCol, QOperations> {
  _SheetColQueryUpdate get updateFirst =>
      _SheetColQueryBuilderUpdateImpl(this, limit: 1);

  _SheetColQueryUpdate get updateAll => _SheetColQueryBuilderUpdateImpl(this);
}

extension SheetColQueryFilter
    on QueryBuilder<SheetCol, SheetCol, QFilterCondition> {
  QueryBuilder<SheetCol, SheetCol, QAfterFilterCondition> sheetRownoKeyEqualTo(
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

  QueryBuilder<SheetCol, SheetCol, QAfterFilterCondition>
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

  QueryBuilder<SheetCol, SheetCol, QAfterFilterCondition>
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

  QueryBuilder<SheetCol, SheetCol, QAfterFilterCondition> sheetRownoKeyLessThan(
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

  QueryBuilder<SheetCol, SheetCol, QAfterFilterCondition>
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

  QueryBuilder<SheetCol, SheetCol, QAfterFilterCondition> sheetRownoKeyBetween(
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

  QueryBuilder<SheetCol, SheetCol, QAfterFilterCondition>
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

  QueryBuilder<SheetCol, SheetCol, QAfterFilterCondition> sheetRownoKeyEndsWith(
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

  QueryBuilder<SheetCol, SheetCol, QAfterFilterCondition> sheetRownoKeyContains(
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

  QueryBuilder<SheetCol, SheetCol, QAfterFilterCondition> sheetRownoKeyMatches(
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

  QueryBuilder<SheetCol, SheetCol, QAfterFilterCondition>
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

  QueryBuilder<SheetCol, SheetCol, QAfterFilterCondition>
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

  QueryBuilder<SheetCol, SheetCol, QAfterFilterCondition> colsEqualTo(
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

  QueryBuilder<SheetCol, SheetCol, QAfterFilterCondition> colsGreaterThan(
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

  QueryBuilder<SheetCol, SheetCol, QAfterFilterCondition>
      colsGreaterThanOrEqualTo(
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

  QueryBuilder<SheetCol, SheetCol, QAfterFilterCondition> colsLessThan(
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

  QueryBuilder<SheetCol, SheetCol, QAfterFilterCondition> colsLessThanOrEqualTo(
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

  QueryBuilder<SheetCol, SheetCol, QAfterFilterCondition> colsBetween(
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

  QueryBuilder<SheetCol, SheetCol, QAfterFilterCondition> colsStartsWith(
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

  QueryBuilder<SheetCol, SheetCol, QAfterFilterCondition> colsEndsWith(
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

  QueryBuilder<SheetCol, SheetCol, QAfterFilterCondition> colsContains(
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

  QueryBuilder<SheetCol, SheetCol, QAfterFilterCondition> colsMatches(
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

  QueryBuilder<SheetCol, SheetCol, QAfterFilterCondition> colsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<SheetCol, SheetCol, QAfterFilterCondition> colsIsNotEmpty() {
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

extension SheetColQueryObject
    on QueryBuilder<SheetCol, SheetCol, QFilterCondition> {}

extension SheetColQuerySortBy on QueryBuilder<SheetCol, SheetCol, QSortBy> {
  QueryBuilder<SheetCol, SheetCol, QAfterSortBy> sortBySheetRownoKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<SheetCol, SheetCol, QAfterSortBy> sortBySheetRownoKeyDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<SheetCol, SheetCol, QAfterSortBy> sortByCols(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<SheetCol, SheetCol, QAfterSortBy> sortByColsDesc(
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

extension SheetColQuerySortThenBy
    on QueryBuilder<SheetCol, SheetCol, QSortThenBy> {
  QueryBuilder<SheetCol, SheetCol, QAfterSortBy> thenBySheetRownoKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SheetCol, SheetCol, QAfterSortBy> thenBySheetRownoKeyDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SheetCol, SheetCol, QAfterSortBy> thenByCols(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SheetCol, SheetCol, QAfterSortBy> thenByColsDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }
}

extension SheetColQueryWhereDistinct
    on QueryBuilder<SheetCol, SheetCol, QDistinct> {
  QueryBuilder<SheetCol, SheetCol, QAfterDistinct> distinctByCols(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }
}

extension SheetColQueryProperty1
    on QueryBuilder<SheetCol, SheetCol, QProperty> {
  QueryBuilder<SheetCol, String, QAfterProperty> sheetRownoKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<SheetCol, String, QAfterProperty> colsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }
}

extension SheetColQueryProperty2<R>
    on QueryBuilder<SheetCol, R, QAfterProperty> {
  QueryBuilder<SheetCol, (R, String), QAfterProperty> sheetRownoKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<SheetCol, (R, String), QAfterProperty> colsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }
}

extension SheetColQueryProperty3<R1, R2>
    on QueryBuilder<SheetCol, (R1, R2), QAfterProperty> {
  QueryBuilder<SheetCol, (R1, R2, String), QOperations>
      sheetRownoKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<SheetCol, (R1, R2, String), QOperations> colsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }
}
