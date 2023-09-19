// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authorscrud.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetAuthorCollection on Isar {
  IsarCollection<String, Author> get authors => this.collection();
}

const AuthorSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'Author',
    idName: 'auhor',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'auhor',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'authorsAliases',
        type: IsarType.string,
      ),
    ],
    indexes: [],
  ),
  converter: IsarObjectConverter<String, Author>(
    serialize: serializeAuthor,
    deserialize: deserializeAuthor,
    deserializeProperty: deserializeAuthorProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeAuthor(IsarWriter writer, Author object) {
  IsarCore.writeString(writer, 1, object.auhor);
  IsarCore.writeString(writer, 2, object.authorsAliases);
  return Isar.fastHash(object.auhor);
}

@isarProtected
Author deserializeAuthor(IsarReader reader) {
  final object = Author();
  object.auhor = IsarCore.readString(reader, 1) ?? '';
  object.authorsAliases = IsarCore.readString(reader, 2) ?? '';
  return object;
}

@isarProtected
dynamic deserializeAuthorProp(IsarReader reader, int property) {
  switch (property) {
    case 1:
      return IsarCore.readString(reader, 1) ?? '';
    case 2:
      return IsarCore.readString(reader, 2) ?? '';
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

sealed class _AuthorUpdate {
  bool call({
    required String auhor,
    String? authorsAliases,
  });
}

class _AuthorUpdateImpl implements _AuthorUpdate {
  const _AuthorUpdateImpl(this.collection);

  final IsarCollection<String, Author> collection;

  @override
  bool call({
    required String auhor,
    Object? authorsAliases = ignore,
  }) {
    return collection.updateProperties([
          auhor
        ], {
          if (authorsAliases != ignore) 2: authorsAliases as String?,
        }) >
        0;
  }
}

sealed class _AuthorUpdateAll {
  int call({
    required List<String> auhor,
    String? authorsAliases,
  });
}

class _AuthorUpdateAllImpl implements _AuthorUpdateAll {
  const _AuthorUpdateAllImpl(this.collection);

  final IsarCollection<String, Author> collection;

  @override
  int call({
    required List<String> auhor,
    Object? authorsAliases = ignore,
  }) {
    return collection.updateProperties(auhor, {
      if (authorsAliases != ignore) 2: authorsAliases as String?,
    });
  }
}

extension AuthorUpdate on IsarCollection<String, Author> {
  _AuthorUpdate get update => _AuthorUpdateImpl(this);

  _AuthorUpdateAll get updateAll => _AuthorUpdateAllImpl(this);
}

sealed class _AuthorQueryUpdate {
  int call({
    String? authorsAliases,
  });
}

class _AuthorQueryUpdateImpl implements _AuthorQueryUpdate {
  const _AuthorQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<Author> query;
  final int? limit;

  @override
  int call({
    Object? authorsAliases = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (authorsAliases != ignore) 2: authorsAliases as String?,
    });
  }
}

extension AuthorQueryUpdate on IsarQuery<Author> {
  _AuthorQueryUpdate get updateFirst => _AuthorQueryUpdateImpl(this, limit: 1);

  _AuthorQueryUpdate get updateAll => _AuthorQueryUpdateImpl(this);
}

class _AuthorQueryBuilderUpdateImpl implements _AuthorQueryUpdate {
  const _AuthorQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<Author, Author, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? authorsAliases = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (authorsAliases != ignore) 2: authorsAliases as String?,
      });
    } finally {
      q.close();
    }
  }
}

extension AuthorQueryBuilderUpdate
    on QueryBuilder<Author, Author, QOperations> {
  _AuthorQueryUpdate get updateFirst =>
      _AuthorQueryBuilderUpdateImpl(this, limit: 1);

  _AuthorQueryUpdate get updateAll => _AuthorQueryBuilderUpdateImpl(this);
}

extension AuthorQueryFilter on QueryBuilder<Author, Author, QFilterCondition> {
  QueryBuilder<Author, Author, QAfterFilterCondition> auhorEqualTo(
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

  QueryBuilder<Author, Author, QAfterFilterCondition> auhorGreaterThan(
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

  QueryBuilder<Author, Author, QAfterFilterCondition> auhorGreaterThanOrEqualTo(
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

  QueryBuilder<Author, Author, QAfterFilterCondition> auhorLessThan(
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

  QueryBuilder<Author, Author, QAfterFilterCondition> auhorLessThanOrEqualTo(
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

  QueryBuilder<Author, Author, QAfterFilterCondition> auhorBetween(
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

  QueryBuilder<Author, Author, QAfterFilterCondition> auhorStartsWith(
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

  QueryBuilder<Author, Author, QAfterFilterCondition> auhorEndsWith(
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

  QueryBuilder<Author, Author, QAfterFilterCondition> auhorContains(
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

  QueryBuilder<Author, Author, QAfterFilterCondition> auhorMatches(
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

  QueryBuilder<Author, Author, QAfterFilterCondition> auhorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<Author, Author, QAfterFilterCondition> auhorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<Author, Author, QAfterFilterCondition> authorsAliasesEqualTo(
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

  QueryBuilder<Author, Author, QAfterFilterCondition> authorsAliasesGreaterThan(
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

  QueryBuilder<Author, Author, QAfterFilterCondition>
      authorsAliasesGreaterThanOrEqualTo(
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

  QueryBuilder<Author, Author, QAfterFilterCondition> authorsAliasesLessThan(
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

  QueryBuilder<Author, Author, QAfterFilterCondition>
      authorsAliasesLessThanOrEqualTo(
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

  QueryBuilder<Author, Author, QAfterFilterCondition> authorsAliasesBetween(
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

  QueryBuilder<Author, Author, QAfterFilterCondition> authorsAliasesStartsWith(
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

  QueryBuilder<Author, Author, QAfterFilterCondition> authorsAliasesEndsWith(
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

  QueryBuilder<Author, Author, QAfterFilterCondition> authorsAliasesContains(
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

  QueryBuilder<Author, Author, QAfterFilterCondition> authorsAliasesMatches(
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

  QueryBuilder<Author, Author, QAfterFilterCondition> authorsAliasesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<Author, Author, QAfterFilterCondition>
      authorsAliasesIsNotEmpty() {
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

extension AuthorQueryObject on QueryBuilder<Author, Author, QFilterCondition> {}

extension AuthorQuerySortBy on QueryBuilder<Author, Author, QSortBy> {
  QueryBuilder<Author, Author, QAfterSortBy> sortByAuhor(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<Author, Author, QAfterSortBy> sortByAuhorDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<Author, Author, QAfterSortBy> sortByAuthorsAliases(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<Author, Author, QAfterSortBy> sortByAuthorsAliasesDesc(
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

extension AuthorQuerySortThenBy on QueryBuilder<Author, Author, QSortThenBy> {
  QueryBuilder<Author, Author, QAfterSortBy> thenByAuhor(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Author, Author, QAfterSortBy> thenByAuhorDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Author, Author, QAfterSortBy> thenByAuthorsAliases(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Author, Author, QAfterSortBy> thenByAuthorsAliasesDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }
}

extension AuthorQueryWhereDistinct on QueryBuilder<Author, Author, QDistinct> {
  QueryBuilder<Author, Author, QAfterDistinct> distinctByAuthorsAliases(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }
}

extension AuthorQueryProperty1 on QueryBuilder<Author, Author, QProperty> {
  QueryBuilder<Author, String, QAfterProperty> auhorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<Author, String, QAfterProperty> authorsAliasesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }
}

extension AuthorQueryProperty2<R> on QueryBuilder<Author, R, QAfterProperty> {
  QueryBuilder<Author, (R, String), QAfterProperty> auhorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<Author, (R, String), QAfterProperty> authorsAliasesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }
}

extension AuthorQueryProperty3<R1, R2>
    on QueryBuilder<Author, (R1, R2), QAfterProperty> {
  QueryBuilder<Author, (R1, R2, String), QOperations> auhorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<Author, (R1, R2, String), QOperations> authorsAliasesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }
}
