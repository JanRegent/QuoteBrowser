// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filterscrud.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetSimpleFilterCollection on Isar {
  IsarCollection<String, SimpleFilter> get simpleFilters => this.collection();
}

const SimpleFilterSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'SimpleFilter',
    idName: 'filterKey',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'filterKey',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'filterName',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'filterExpr',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'sheetRownoKeys',
        type: IsarType.stringList,
      ),
    ],
    indexes: [],
  ),
  converter: IsarObjectConverter<String, SimpleFilter>(
    serialize: serializeSimpleFilter,
    deserialize: deserializeSimpleFilter,
    deserializeProperty: deserializeSimpleFilterProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeSimpleFilter(IsarWriter writer, SimpleFilter object) {
  IsarCore.writeString(writer, 1, object.filterKey);
  IsarCore.writeString(writer, 2, object.filterName);
  IsarCore.writeString(writer, 3, object.filterExpr);
  {
    final list = object.sheetRownoKeys;
    final listWriter = IsarCore.beginList(writer, 4, list.length);
    for (var i = 0; i < list.length; i++) {
      IsarCore.writeString(listWriter, i, list[i]);
    }
    IsarCore.endList(writer, listWriter);
  }
  return Isar.fastHash(object.filterKey);
}

@isarProtected
SimpleFilter deserializeSimpleFilter(IsarReader reader) {
  final object = SimpleFilter();
  object.filterKey = IsarCore.readString(reader, 1) ?? '';
  object.filterName = IsarCore.readString(reader, 2) ?? '';
  object.filterExpr = IsarCore.readString(reader, 3) ?? '';
  {
    final length = IsarCore.readList(reader, 4, IsarCore.readerPtrPtr);
    {
      final reader = IsarCore.readerPtr;
      if (reader.isNull) {
        object.sheetRownoKeys = const <String>[];
      } else {
        final list = List<String>.filled(length, '', growable: true);
        for (var i = 0; i < length; i++) {
          list[i] = IsarCore.readString(reader, i) ?? '';
        }
        IsarCore.freeReader(reader);
        object.sheetRownoKeys = list;
      }
    }
  }
  return object;
}

@isarProtected
dynamic deserializeSimpleFilterProp(IsarReader reader, int property) {
  switch (property) {
    case 1:
      return IsarCore.readString(reader, 1) ?? '';
    case 2:
      return IsarCore.readString(reader, 2) ?? '';
    case 3:
      return IsarCore.readString(reader, 3) ?? '';
    case 4:
      {
        final length = IsarCore.readList(reader, 4, IsarCore.readerPtrPtr);
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

sealed class _SimpleFilterUpdate {
  bool call({
    required String filterKey,
    String? filterName,
    String? filterExpr,
  });
}

class _SimpleFilterUpdateImpl implements _SimpleFilterUpdate {
  const _SimpleFilterUpdateImpl(this.collection);

  final IsarCollection<String, SimpleFilter> collection;

  @override
  bool call({
    required String filterKey,
    Object? filterName = ignore,
    Object? filterExpr = ignore,
  }) {
    return collection.updateProperties([
          filterKey
        ], {
          if (filterName != ignore) 2: filterName as String?,
          if (filterExpr != ignore) 3: filterExpr as String?,
        }) >
        0;
  }
}

sealed class _SimpleFilterUpdateAll {
  int call({
    required List<String> filterKey,
    String? filterName,
    String? filterExpr,
  });
}

class _SimpleFilterUpdateAllImpl implements _SimpleFilterUpdateAll {
  const _SimpleFilterUpdateAllImpl(this.collection);

  final IsarCollection<String, SimpleFilter> collection;

  @override
  int call({
    required List<String> filterKey,
    Object? filterName = ignore,
    Object? filterExpr = ignore,
  }) {
    return collection.updateProperties(filterKey, {
      if (filterName != ignore) 2: filterName as String?,
      if (filterExpr != ignore) 3: filterExpr as String?,
    });
  }
}

extension SimpleFilterUpdate on IsarCollection<String, SimpleFilter> {
  _SimpleFilterUpdate get update => _SimpleFilterUpdateImpl(this);

  _SimpleFilterUpdateAll get updateAll => _SimpleFilterUpdateAllImpl(this);
}

sealed class _SimpleFilterQueryUpdate {
  int call({
    String? filterName,
    String? filterExpr,
  });
}

class _SimpleFilterQueryUpdateImpl implements _SimpleFilterQueryUpdate {
  const _SimpleFilterQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<SimpleFilter> query;
  final int? limit;

  @override
  int call({
    Object? filterName = ignore,
    Object? filterExpr = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (filterName != ignore) 2: filterName as String?,
      if (filterExpr != ignore) 3: filterExpr as String?,
    });
  }
}

extension SimpleFilterQueryUpdate on IsarQuery<SimpleFilter> {
  _SimpleFilterQueryUpdate get updateFirst =>
      _SimpleFilterQueryUpdateImpl(this, limit: 1);

  _SimpleFilterQueryUpdate get updateAll => _SimpleFilterQueryUpdateImpl(this);
}

class _SimpleFilterQueryBuilderUpdateImpl implements _SimpleFilterQueryUpdate {
  const _SimpleFilterQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<SimpleFilter, SimpleFilter, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? filterName = ignore,
    Object? filterExpr = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (filterName != ignore) 2: filterName as String?,
        if (filterExpr != ignore) 3: filterExpr as String?,
      });
    } finally {
      q.close();
    }
  }
}

extension SimpleFilterQueryBuilderUpdate
    on QueryBuilder<SimpleFilter, SimpleFilter, QOperations> {
  _SimpleFilterQueryUpdate get updateFirst =>
      _SimpleFilterQueryBuilderUpdateImpl(this, limit: 1);

  _SimpleFilterQueryUpdate get updateAll =>
      _SimpleFilterQueryBuilderUpdateImpl(this);
}

extension SimpleFilterQueryFilter
    on QueryBuilder<SimpleFilter, SimpleFilter, QFilterCondition> {
  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      filterKeyEqualTo(
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

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      filterKeyGreaterThan(
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

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      filterKeyGreaterThanOrEqualTo(
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

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      filterKeyLessThan(
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

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      filterKeyLessThanOrEqualTo(
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

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      filterKeyBetween(
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

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      filterKeyStartsWith(
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

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      filterKeyEndsWith(
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

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      filterKeyContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      filterKeyMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      filterKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      filterKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      filterNameEqualTo(
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

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      filterNameGreaterThan(
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

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      filterNameGreaterThanOrEqualTo(
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

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      filterNameLessThan(
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

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      filterNameLessThanOrEqualTo(
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

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      filterNameBetween(
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

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      filterNameStartsWith(
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

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      filterNameEndsWith(
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

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      filterNameContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      filterNameMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      filterNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      filterNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      filterExprEqualTo(
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

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      filterExprGreaterThan(
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

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      filterExprGreaterThanOrEqualTo(
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

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      filterExprLessThan(
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

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      filterExprLessThanOrEqualTo(
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

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      filterExprBetween(
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

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      filterExprStartsWith(
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

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      filterExprEndsWith(
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

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      filterExprContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      filterExprMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      filterExprIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      filterExprIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      sheetRownoKeysElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      sheetRownoKeysElementGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      sheetRownoKeysElementGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      sheetRownoKeysElementLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      sheetRownoKeysElementLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      sheetRownoKeysElementBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 4,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      sheetRownoKeysElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      sheetRownoKeysElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      sheetRownoKeysElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 4,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      sheetRownoKeysElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 4,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      sheetRownoKeysElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 4,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      sheetRownoKeysElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 4,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      sheetRownoKeysIsEmpty() {
    return not().sheetRownoKeysIsNotEmpty();
  }

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      sheetRownoKeysIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 4, value: null),
      );
    });
  }
}

extension SimpleFilterQueryObject
    on QueryBuilder<SimpleFilter, SimpleFilter, QFilterCondition> {}

extension SimpleFilterQuerySortBy
    on QueryBuilder<SimpleFilter, SimpleFilter, QSortBy> {
  QueryBuilder<SimpleFilter, SimpleFilter, QAfterSortBy> sortByFilterKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterSortBy> sortByFilterKeyDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterSortBy> sortByFilterName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterSortBy> sortByFilterNameDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterSortBy> sortByFilterExpr(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterSortBy> sortByFilterExprDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }
}

extension SimpleFilterQuerySortThenBy
    on QueryBuilder<SimpleFilter, SimpleFilter, QSortThenBy> {
  QueryBuilder<SimpleFilter, SimpleFilter, QAfterSortBy> thenByFilterKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterSortBy> thenByFilterKeyDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterSortBy> thenByFilterName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterSortBy> thenByFilterNameDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterSortBy> thenByFilterExpr(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterSortBy> thenByFilterExprDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }
}

extension SimpleFilterQueryWhereDistinct
    on QueryBuilder<SimpleFilter, SimpleFilter, QDistinct> {
  QueryBuilder<SimpleFilter, SimpleFilter, QAfterDistinct> distinctByFilterName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterDistinct> distinctByFilterExpr(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterDistinct>
      distinctBySheetRownoKeys() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4);
    });
  }
}

extension SimpleFilterQueryProperty1
    on QueryBuilder<SimpleFilter, SimpleFilter, QProperty> {
  QueryBuilder<SimpleFilter, String, QAfterProperty> filterKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<SimpleFilter, String, QAfterProperty> filterNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<SimpleFilter, String, QAfterProperty> filterExprProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<SimpleFilter, List<String>, QAfterProperty>
      sheetRownoKeysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }
}

extension SimpleFilterQueryProperty2<R>
    on QueryBuilder<SimpleFilter, R, QAfterProperty> {
  QueryBuilder<SimpleFilter, (R, String), QAfterProperty> filterKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<SimpleFilter, (R, String), QAfterProperty> filterNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<SimpleFilter, (R, String), QAfterProperty> filterExprProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<SimpleFilter, (R, List<String>), QAfterProperty>
      sheetRownoKeysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }
}

extension SimpleFilterQueryProperty3<R1, R2>
    on QueryBuilder<SimpleFilter, (R1, R2), QAfterProperty> {
  QueryBuilder<SimpleFilter, (R1, R2, String), QOperations>
      filterKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<SimpleFilter, (R1, R2, String), QOperations>
      filterNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<SimpleFilter, (R1, R2, String), QOperations>
      filterExprProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<SimpleFilter, (R1, R2, List<String>), QOperations>
      sheetRownoKeysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }
}
