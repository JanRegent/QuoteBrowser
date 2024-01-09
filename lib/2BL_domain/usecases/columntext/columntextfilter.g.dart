// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'columntextfilter.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetColumnTextFilterCollection on Isar {
  IsarCollection<String, ColumnTextFilter> get columnTextFilters =>
      this.collection();
}

const ColumnTextFilterSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'ColumnTextFilter',
    idName: 'columnTextKey',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'columnTextKey',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'columnName',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'columnValue',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'searchText',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'sheetRownoKeys',
        type: IsarType.stringList,
      ),
    ],
    indexes: [],
  ),
  converter: IsarObjectConverter<String, ColumnTextFilter>(
    serialize: serializeColumnTextFilter,
    deserialize: deserializeColumnTextFilter,
    deserializeProperty: deserializeColumnTextFilterProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeColumnTextFilter(IsarWriter writer, ColumnTextFilter object) {
  IsarCore.writeString(writer, 1, object.columnTextKey);
  IsarCore.writeString(writer, 2, object.columnName);
  IsarCore.writeString(writer, 3, object.columnValue);
  IsarCore.writeString(writer, 4, object.searchText);
  {
    final list = object.sheetRownoKeys;
    final listWriter = IsarCore.beginList(writer, 5, list.length);
    for (var i = 0; i < list.length; i++) {
      IsarCore.writeString(listWriter, i, list[i]);
    }
    IsarCore.endList(writer, listWriter);
  }
  return Isar.fastHash(object.columnTextKey);
}

@isarProtected
ColumnTextFilter deserializeColumnTextFilter(IsarReader reader) {
  final object = ColumnTextFilter();
  object.columnTextKey = IsarCore.readString(reader, 1) ?? '';
  object.columnName = IsarCore.readString(reader, 2) ?? '';
  object.columnValue = IsarCore.readString(reader, 3) ?? '';
  object.searchText = IsarCore.readString(reader, 4) ?? '';
  {
    final length = IsarCore.readList(reader, 5, IsarCore.readerPtrPtr);
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
dynamic deserializeColumnTextFilterProp(IsarReader reader, int property) {
  switch (property) {
    case 1:
      return IsarCore.readString(reader, 1) ?? '';
    case 2:
      return IsarCore.readString(reader, 2) ?? '';
    case 3:
      return IsarCore.readString(reader, 3) ?? '';
    case 4:
      return IsarCore.readString(reader, 4) ?? '';
    case 5:
      {
        final length = IsarCore.readList(reader, 5, IsarCore.readerPtrPtr);
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

sealed class _ColumnTextFilterUpdate {
  bool call({
    required String columnTextKey,
    String? columnName,
    String? columnValue,
    String? searchText,
  });
}

class _ColumnTextFilterUpdateImpl implements _ColumnTextFilterUpdate {
  const _ColumnTextFilterUpdateImpl(this.collection);

  final IsarCollection<String, ColumnTextFilter> collection;

  @override
  bool call({
    required String columnTextKey,
    Object? columnName = ignore,
    Object? columnValue = ignore,
    Object? searchText = ignore,
  }) {
    return collection.updateProperties([
          columnTextKey
        ], {
          if (columnName != ignore) 2: columnName as String?,
          if (columnValue != ignore) 3: columnValue as String?,
          if (searchText != ignore) 4: searchText as String?,
        }) >
        0;
  }
}

sealed class _ColumnTextFilterUpdateAll {
  int call({
    required List<String> columnTextKey,
    String? columnName,
    String? columnValue,
    String? searchText,
  });
}

class _ColumnTextFilterUpdateAllImpl implements _ColumnTextFilterUpdateAll {
  const _ColumnTextFilterUpdateAllImpl(this.collection);

  final IsarCollection<String, ColumnTextFilter> collection;

  @override
  int call({
    required List<String> columnTextKey,
    Object? columnName = ignore,
    Object? columnValue = ignore,
    Object? searchText = ignore,
  }) {
    return collection.updateProperties(columnTextKey, {
      if (columnName != ignore) 2: columnName as String?,
      if (columnValue != ignore) 3: columnValue as String?,
      if (searchText != ignore) 4: searchText as String?,
    });
  }
}

extension ColumnTextFilterUpdate on IsarCollection<String, ColumnTextFilter> {
  _ColumnTextFilterUpdate get update => _ColumnTextFilterUpdateImpl(this);

  _ColumnTextFilterUpdateAll get updateAll =>
      _ColumnTextFilterUpdateAllImpl(this);
}

sealed class _ColumnTextFilterQueryUpdate {
  int call({
    String? columnName,
    String? columnValue,
    String? searchText,
  });
}

class _ColumnTextFilterQueryUpdateImpl implements _ColumnTextFilterQueryUpdate {
  const _ColumnTextFilterQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<ColumnTextFilter> query;
  final int? limit;

  @override
  int call({
    Object? columnName = ignore,
    Object? columnValue = ignore,
    Object? searchText = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (columnName != ignore) 2: columnName as String?,
      if (columnValue != ignore) 3: columnValue as String?,
      if (searchText != ignore) 4: searchText as String?,
    });
  }
}

extension ColumnTextFilterQueryUpdate on IsarQuery<ColumnTextFilter> {
  _ColumnTextFilterQueryUpdate get updateFirst =>
      _ColumnTextFilterQueryUpdateImpl(this, limit: 1);

  _ColumnTextFilterQueryUpdate get updateAll =>
      _ColumnTextFilterQueryUpdateImpl(this);
}

class _ColumnTextFilterQueryBuilderUpdateImpl
    implements _ColumnTextFilterQueryUpdate {
  const _ColumnTextFilterQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<ColumnTextFilter, ColumnTextFilter, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? columnName = ignore,
    Object? columnValue = ignore,
    Object? searchText = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (columnName != ignore) 2: columnName as String?,
        if (columnValue != ignore) 3: columnValue as String?,
        if (searchText != ignore) 4: searchText as String?,
      });
    } finally {
      q.close();
    }
  }
}

extension ColumnTextFilterQueryBuilderUpdate
    on QueryBuilder<ColumnTextFilter, ColumnTextFilter, QOperations> {
  _ColumnTextFilterQueryUpdate get updateFirst =>
      _ColumnTextFilterQueryBuilderUpdateImpl(this, limit: 1);

  _ColumnTextFilterQueryUpdate get updateAll =>
      _ColumnTextFilterQueryBuilderUpdateImpl(this);
}

extension ColumnTextFilterQueryFilter
    on QueryBuilder<ColumnTextFilter, ColumnTextFilter, QFilterCondition> {
  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      columnTextKeyEqualTo(
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

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      columnTextKeyGreaterThan(
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

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      columnTextKeyGreaterThanOrEqualTo(
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

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      columnTextKeyLessThan(
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

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      columnTextKeyLessThanOrEqualTo(
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

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      columnTextKeyBetween(
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

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      columnTextKeyStartsWith(
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

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      columnTextKeyEndsWith(
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

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      columnTextKeyContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      columnTextKeyMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      columnTextKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      columnTextKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      columnNameEqualTo(
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

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      columnNameGreaterThan(
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

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      columnNameGreaterThanOrEqualTo(
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

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      columnNameLessThan(
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

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      columnNameLessThanOrEqualTo(
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

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      columnNameBetween(
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

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      columnNameStartsWith(
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

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      columnNameEndsWith(
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

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      columnNameContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      columnNameMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      columnNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      columnNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      columnValueEqualTo(
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

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      columnValueGreaterThan(
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

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      columnValueGreaterThanOrEqualTo(
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

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      columnValueLessThan(
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

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      columnValueLessThanOrEqualTo(
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

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      columnValueBetween(
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

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      columnValueStartsWith(
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

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      columnValueEndsWith(
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

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      columnValueContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      columnValueMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      columnValueIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      columnValueIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      searchTextEqualTo(
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

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      searchTextGreaterThan(
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

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      searchTextGreaterThanOrEqualTo(
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

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      searchTextLessThan(
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

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      searchTextLessThanOrEqualTo(
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

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      searchTextBetween(
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

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      searchTextStartsWith(
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

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      searchTextEndsWith(
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

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      searchTextContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      searchTextMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      searchTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 4,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      searchTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 4,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      sheetRownoKeysElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EqualCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      sheetRownoKeysElementGreaterThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      sheetRownoKeysElementGreaterThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        GreaterOrEqualCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      sheetRownoKeysElementLessThan(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      sheetRownoKeysElementLessThanOrEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        LessOrEqualCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      sheetRownoKeysElementBetween(
    String lower,
    String upper, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        BetweenCondition(
          property: 5,
          lower: lower,
          upper: upper,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      sheetRownoKeysElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        StartsWithCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      sheetRownoKeysElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        EndsWithCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      sheetRownoKeysElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        ContainsCondition(
          property: 5,
          value: value,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      sheetRownoKeysElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        MatchesCondition(
          property: 5,
          wildcard: pattern,
          caseSensitive: caseSensitive,
        ),
      );
    });
  }

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      sheetRownoKeysElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 5,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      sheetRownoKeysElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 5,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      sheetRownoKeysIsEmpty() {
    return not().sheetRownoKeysIsNotEmpty();
  }

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterFilterCondition>
      sheetRownoKeysIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 5, value: null),
      );
    });
  }
}

extension ColumnTextFilterQueryObject
    on QueryBuilder<ColumnTextFilter, ColumnTextFilter, QFilterCondition> {}

extension ColumnTextFilterQuerySortBy
    on QueryBuilder<ColumnTextFilter, ColumnTextFilter, QSortBy> {
  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterSortBy>
      sortByColumnTextKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterSortBy>
      sortByColumnTextKeyDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterSortBy>
      sortByColumnName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterSortBy>
      sortByColumnNameDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterSortBy>
      sortByColumnValue({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterSortBy>
      sortByColumnValueDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterSortBy>
      sortBySearchText({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        4,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterSortBy>
      sortBySearchTextDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        4,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }
}

extension ColumnTextFilterQuerySortThenBy
    on QueryBuilder<ColumnTextFilter, ColumnTextFilter, QSortThenBy> {
  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterSortBy>
      thenByColumnTextKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterSortBy>
      thenByColumnTextKeyDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterSortBy>
      thenByColumnName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterSortBy>
      thenByColumnNameDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterSortBy>
      thenByColumnValue({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterSortBy>
      thenByColumnValueDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterSortBy>
      thenBySearchText({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterSortBy>
      thenBySearchTextDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(4, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }
}

extension ColumnTextFilterQueryWhereDistinct
    on QueryBuilder<ColumnTextFilter, ColumnTextFilter, QDistinct> {
  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterDistinct>
      distinctByColumnName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterDistinct>
      distinctByColumnValue({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterDistinct>
      distinctBySearchText({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ColumnTextFilter, ColumnTextFilter, QAfterDistinct>
      distinctBySheetRownoKeys() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(5);
    });
  }
}

extension ColumnTextFilterQueryProperty1
    on QueryBuilder<ColumnTextFilter, ColumnTextFilter, QProperty> {
  QueryBuilder<ColumnTextFilter, String, QAfterProperty>
      columnTextKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<ColumnTextFilter, String, QAfterProperty> columnNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<ColumnTextFilter, String, QAfterProperty> columnValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<ColumnTextFilter, String, QAfterProperty> searchTextProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<ColumnTextFilter, List<String>, QAfterProperty>
      sheetRownoKeysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }
}

extension ColumnTextFilterQueryProperty2<R>
    on QueryBuilder<ColumnTextFilter, R, QAfterProperty> {
  QueryBuilder<ColumnTextFilter, (R, String), QAfterProperty>
      columnTextKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<ColumnTextFilter, (R, String), QAfterProperty>
      columnNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<ColumnTextFilter, (R, String), QAfterProperty>
      columnValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<ColumnTextFilter, (R, String), QAfterProperty>
      searchTextProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<ColumnTextFilter, (R, List<String>), QAfterProperty>
      sheetRownoKeysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }
}

extension ColumnTextFilterQueryProperty3<R1, R2>
    on QueryBuilder<ColumnTextFilter, (R1, R2), QAfterProperty> {
  QueryBuilder<ColumnTextFilter, (R1, R2, String), QOperations>
      columnTextKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<ColumnTextFilter, (R1, R2, String), QOperations>
      columnNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<ColumnTextFilter, (R1, R2, String), QOperations>
      columnValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<ColumnTextFilter, (R1, R2, String), QOperations>
      searchTextProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }

  QueryBuilder<ColumnTextFilter, (R1, R2, List<String>), QOperations>
      sheetRownoKeysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(5);
    });
  }
}
