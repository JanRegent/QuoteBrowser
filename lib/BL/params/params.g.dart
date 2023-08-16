// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'params.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetParamsCollection on Isar {
  IsarCollection<String, Params> get params => this.collection();
}

const ParamsSchema = IsarCollectionSchema(
  schema:
      '{"name":"Params","idName":"key","properties":[{"name":"key","type":"String"},{"name":"scope","type":"String"},{"name":"value","type":"String"}]}',
  converter: IsarObjectConverter<String, Params>(
    serialize: serializeParams,
    deserialize: deserializeParams,
    deserializeProperty: deserializeParamsProp,
  ),
  embeddedSchemas: [],
  //hash: 3080802201397324532,
);

@isarProtected
int serializeParams(IsarWriter writer, Params object) {
  IsarCore.writeString(writer, 1, object.key);
  IsarCore.writeString(writer, 2, object.scope);
  IsarCore.writeString(writer, 3, object.value);
  return Isar.fastHash(object.key);
}

@isarProtected
Params deserializeParams(IsarReader reader) {
  final object = Params();
  object.key = IsarCore.readString(reader, 1) ?? '';
  object.scope = IsarCore.readString(reader, 2) ?? '';
  object.value = IsarCore.readString(reader, 3) ?? '';
  return object;
}

@isarProtected
dynamic deserializeParamsProp(IsarReader reader, int property) {
  switch (property) {
    case 1:
      return IsarCore.readString(reader, 1) ?? '';
    case 2:
      return IsarCore.readString(reader, 2) ?? '';
    case 3:
      return IsarCore.readString(reader, 3) ?? '';
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _ParamsUpdate {
  bool call({
    required String key,
    String? scope,
    String? value,
  });
}

class _ParamsUpdateImpl implements _ParamsUpdate {
  const _ParamsUpdateImpl(this.collection);

  final IsarCollection<String, Params> collection;

  @override
  bool call({
    required String key,
    Object? scope = ignore,
    Object? value = ignore,
  }) {
    return collection.updateProperties([
          key
        ], {
          if (scope != ignore) 2: scope as String?,
          if (value != ignore) 3: value as String?,
        }) >
        0;
  }
}

sealed class _ParamsUpdateAll {
  int call({
    required List<String> key,
    String? scope,
    String? value,
  });
}

class _ParamsUpdateAllImpl implements _ParamsUpdateAll {
  const _ParamsUpdateAllImpl(this.collection);

  final IsarCollection<String, Params> collection;

  @override
  int call({
    required List<String> key,
    Object? scope = ignore,
    Object? value = ignore,
  }) {
    return collection.updateProperties(key, {
      if (scope != ignore) 2: scope as String?,
      if (value != ignore) 3: value as String?,
    });
  }
}

extension ParamsUpdate on IsarCollection<String, Params> {
  _ParamsUpdate get update => _ParamsUpdateImpl(this);

  _ParamsUpdateAll get updateAll => _ParamsUpdateAllImpl(this);
}

sealed class _ParamsQueryUpdate {
  int call({
    String? scope,
    String? value,
  });
}

class _ParamsQueryUpdateImpl implements _ParamsQueryUpdate {
  const _ParamsQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<Params> query;
  final int? limit;

  @override
  int call({
    Object? scope = ignore,
    Object? value = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (scope != ignore) 2: scope as String?,
      if (value != ignore) 3: value as String?,
    });
  }
}

extension ParamsQueryUpdate on IsarQuery<Params> {
  _ParamsQueryUpdate get updateFirst => _ParamsQueryUpdateImpl(this, limit: 1);

  _ParamsQueryUpdate get updateAll => _ParamsQueryUpdateImpl(this);
}

extension ParamsQueryFilter on QueryBuilder<Params, Params, QFilterCondition> {
  QueryBuilder<Params, Params, QAfterFilterCondition> keyEqualTo(
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

  QueryBuilder<Params, Params, QAfterFilterCondition> keyGreaterThan(
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

  QueryBuilder<Params, Params, QAfterFilterCondition> keyGreaterThanOrEqualTo(
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

  QueryBuilder<Params, Params, QAfterFilterCondition> keyLessThan(
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

  QueryBuilder<Params, Params, QAfterFilterCondition> keyLessThanOrEqualTo(
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

  QueryBuilder<Params, Params, QAfterFilterCondition> keyBetween(
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

  QueryBuilder<Params, Params, QAfterFilterCondition> keyStartsWith(
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

  QueryBuilder<Params, Params, QAfterFilterCondition> keyEndsWith(
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

  QueryBuilder<Params, Params, QAfterFilterCondition> keyContains(String value,
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

  QueryBuilder<Params, Params, QAfterFilterCondition> keyMatches(String pattern,
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

  QueryBuilder<Params, Params, QAfterFilterCondition> keyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<Params, Params, QAfterFilterCondition> keyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<Params, Params, QAfterFilterCondition> scopeEqualTo(
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

  QueryBuilder<Params, Params, QAfterFilterCondition> scopeGreaterThan(
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

  QueryBuilder<Params, Params, QAfterFilterCondition> scopeGreaterThanOrEqualTo(
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

  QueryBuilder<Params, Params, QAfterFilterCondition> scopeLessThan(
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

  QueryBuilder<Params, Params, QAfterFilterCondition> scopeLessThanOrEqualTo(
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

  QueryBuilder<Params, Params, QAfterFilterCondition> scopeBetween(
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

  QueryBuilder<Params, Params, QAfterFilterCondition> scopeStartsWith(
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

  QueryBuilder<Params, Params, QAfterFilterCondition> scopeEndsWith(
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

  QueryBuilder<Params, Params, QAfterFilterCondition> scopeContains(
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

  QueryBuilder<Params, Params, QAfterFilterCondition> scopeMatches(
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

  QueryBuilder<Params, Params, QAfterFilterCondition> scopeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<Params, Params, QAfterFilterCondition> scopeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<Params, Params, QAfterFilterCondition> valueEqualTo(
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

  QueryBuilder<Params, Params, QAfterFilterCondition> valueGreaterThan(
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

  QueryBuilder<Params, Params, QAfterFilterCondition> valueGreaterThanOrEqualTo(
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

  QueryBuilder<Params, Params, QAfterFilterCondition> valueLessThan(
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

  QueryBuilder<Params, Params, QAfterFilterCondition> valueLessThanOrEqualTo(
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

  QueryBuilder<Params, Params, QAfterFilterCondition> valueBetween(
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

  QueryBuilder<Params, Params, QAfterFilterCondition> valueStartsWith(
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

  QueryBuilder<Params, Params, QAfterFilterCondition> valueEndsWith(
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

  QueryBuilder<Params, Params, QAfterFilterCondition> valueContains(
      String value,
      {bool caseSensitive = true}) {
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

  QueryBuilder<Params, Params, QAfterFilterCondition> valueMatches(
      String pattern,
      {bool caseSensitive = true}) {
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

  QueryBuilder<Params, Params, QAfterFilterCondition> valueIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<Params, Params, QAfterFilterCondition> valueIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }
}

extension ParamsQueryObject on QueryBuilder<Params, Params, QFilterCondition> {}

extension ParamsQuerySortBy on QueryBuilder<Params, Params, QSortBy> {
  QueryBuilder<Params, Params, QAfterSortBy> sortByKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<Params, Params, QAfterSortBy> sortByKeyDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<Params, Params, QAfterSortBy> sortByScope(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<Params, Params, QAfterSortBy> sortByScopeDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<Params, Params, QAfterSortBy> sortByValue(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<Params, Params, QAfterSortBy> sortByValueDesc(
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

extension ParamsQuerySortThenBy on QueryBuilder<Params, Params, QSortThenBy> {
  QueryBuilder<Params, Params, QAfterSortBy> thenByKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Params, Params, QAfterSortBy> thenByKeyDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Params, Params, QAfterSortBy> thenByScope(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Params, Params, QAfterSortBy> thenByScopeDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Params, Params, QAfterSortBy> thenByValue(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Params, Params, QAfterSortBy> thenByValueDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }
}

extension ParamsQueryWhereDistinct on QueryBuilder<Params, Params, QDistinct> {
  QueryBuilder<Params, Params, QAfterDistinct> distinctByScope(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Params, Params, QAfterDistinct> distinctByValue(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3, caseSensitive: caseSensitive);
    });
  }
}

extension ParamsQueryProperty1 on QueryBuilder<Params, Params, QProperty> {
  QueryBuilder<Params, String, QAfterProperty> keyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<Params, String, QAfterProperty> scopeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<Params, String, QAfterProperty> valueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }
}

extension ParamsQueryProperty2<R> on QueryBuilder<Params, R, QAfterProperty> {
  QueryBuilder<Params, (R, String), QAfterProperty> keyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<Params, (R, String), QAfterProperty> scopeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<Params, (R, String), QAfterProperty> valueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }
}

extension ParamsQueryProperty3<R1, R2>
    on QueryBuilder<Params, (R1, R2), QAfterProperty> {
  QueryBuilder<Params, (R1, R2, String), QOperations> keyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<Params, (R1, R2, String), QOperations> scopeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<Params, (R1, R2, String), QOperations> valueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }
}
