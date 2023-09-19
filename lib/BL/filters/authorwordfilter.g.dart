// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../authors/authorwordfilter.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetAuthorWordFilterCollection on Isar {
  IsarCollection<String, AuthorWordFilter> get authorWordFilters =>
      this.collection();
}

const AuthorWordFilterSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'AuthorWordFilter',
    idName: 'authorWordKey',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'authorWordKey',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'author',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'word',
        type: IsarType.string,
      ),
      IsarPropertySchema(
        name: 'sheetRownoKeys',
        type: IsarType.stringList,
      ),
    ],
    indexes: [],
  ),
  converter: IsarObjectConverter<String, AuthorWordFilter>(
    serialize: serializeAuthorWordFilter,
    deserialize: deserializeAuthorWordFilter,
    deserializeProperty: deserializeAuthorWordFilterProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeAuthorWordFilter(IsarWriter writer, AuthorWordFilter object) {
  IsarCore.writeString(writer, 1, object.authorWordKey);
  IsarCore.writeString(writer, 2, object.author);
  IsarCore.writeString(writer, 3, object.word);
  {
    final list = object.sheetRownoKeys;
    final listWriter = IsarCore.beginList(writer, 4, list.length);
    for (var i = 0; i < list.length; i++) {
      IsarCore.writeString(listWriter, i, list[i]);
    }
    IsarCore.endList(writer, listWriter);
  }
  return Isar.fastHash(object.authorWordKey);
}

@isarProtected
AuthorWordFilter deserializeAuthorWordFilter(IsarReader reader) {
  final object = AuthorWordFilter();
  object.authorWordKey = IsarCore.readString(reader, 1) ?? '';
  object.author = IsarCore.readString(reader, 2) ?? '';
  object.word = IsarCore.readString(reader, 3) ?? '';
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
dynamic deserializeAuthorWordFilterProp(IsarReader reader, int property) {
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

sealed class _AuthorWordFilterUpdate {
  bool call({
    required String authorWordKey,
    String? author,
    String? word,
  });
}

class _AuthorWordFilterUpdateImpl implements _AuthorWordFilterUpdate {
  const _AuthorWordFilterUpdateImpl(this.collection);

  final IsarCollection<String, AuthorWordFilter> collection;

  @override
  bool call({
    required String authorWordKey,
    Object? author = ignore,
    Object? word = ignore,
  }) {
    return collection.updateProperties([
          authorWordKey
        ], {
          if (author != ignore) 2: author as String?,
          if (word != ignore) 3: word as String?,
        }) >
        0;
  }
}

sealed class _AuthorWordFilterUpdateAll {
  int call({
    required List<String> authorWordKey,
    String? author,
    String? word,
  });
}

class _AuthorWordFilterUpdateAllImpl implements _AuthorWordFilterUpdateAll {
  const _AuthorWordFilterUpdateAllImpl(this.collection);

  final IsarCollection<String, AuthorWordFilter> collection;

  @override
  int call({
    required List<String> authorWordKey,
    Object? author = ignore,
    Object? word = ignore,
  }) {
    return collection.updateProperties(authorWordKey, {
      if (author != ignore) 2: author as String?,
      if (word != ignore) 3: word as String?,
    });
  }
}

extension AuthorWordFilterUpdate on IsarCollection<String, AuthorWordFilter> {
  _AuthorWordFilterUpdate get update => _AuthorWordFilterUpdateImpl(this);

  _AuthorWordFilterUpdateAll get updateAll =>
      _AuthorWordFilterUpdateAllImpl(this);
}

sealed class _AuthorWordFilterQueryUpdate {
  int call({
    String? author,
    String? word,
  });
}

class _AuthorWordFilterQueryUpdateImpl implements _AuthorWordFilterQueryUpdate {
  const _AuthorWordFilterQueryUpdateImpl(this.query, {this.limit});

  final IsarQuery<AuthorWordFilter> query;
  final int? limit;

  @override
  int call({
    Object? author = ignore,
    Object? word = ignore,
  }) {
    return query.updateProperties(limit: limit, {
      if (author != ignore) 2: author as String?,
      if (word != ignore) 3: word as String?,
    });
  }
}

extension AuthorWordFilterQueryUpdate on IsarQuery<AuthorWordFilter> {
  _AuthorWordFilterQueryUpdate get updateFirst =>
      _AuthorWordFilterQueryUpdateImpl(this, limit: 1);

  _AuthorWordFilterQueryUpdate get updateAll =>
      _AuthorWordFilterQueryUpdateImpl(this);
}

class _AuthorWordFilterQueryBuilderUpdateImpl
    implements _AuthorWordFilterQueryUpdate {
  const _AuthorWordFilterQueryBuilderUpdateImpl(this.query, {this.limit});

  final QueryBuilder<AuthorWordFilter, AuthorWordFilter, QOperations> query;
  final int? limit;

  @override
  int call({
    Object? author = ignore,
    Object? word = ignore,
  }) {
    final q = query.build();
    try {
      return q.updateProperties(limit: limit, {
        if (author != ignore) 2: author as String?,
        if (word != ignore) 3: word as String?,
      });
    } finally {
      q.close();
    }
  }
}

extension AuthorWordFilterQueryBuilderUpdate
    on QueryBuilder<AuthorWordFilter, AuthorWordFilter, QOperations> {
  _AuthorWordFilterQueryUpdate get updateFirst =>
      _AuthorWordFilterQueryBuilderUpdateImpl(this, limit: 1);

  _AuthorWordFilterQueryUpdate get updateAll =>
      _AuthorWordFilterQueryBuilderUpdateImpl(this);
}

extension AuthorWordFilterQueryFilter
    on QueryBuilder<AuthorWordFilter, AuthorWordFilter, QFilterCondition> {
  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
      authorWordKeyEqualTo(
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

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
      authorWordKeyGreaterThan(
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

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
      authorWordKeyGreaterThanOrEqualTo(
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

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
      authorWordKeyLessThan(
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

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
      authorWordKeyLessThanOrEqualTo(
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

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
      authorWordKeyBetween(
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

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
      authorWordKeyStartsWith(
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

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
      authorWordKeyEndsWith(
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

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
      authorWordKeyContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
      authorWordKeyMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
      authorWordKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
      authorWordKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
      authorEqualTo(
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

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
      authorGreaterThan(
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

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
      authorGreaterThanOrEqualTo(
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

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
      authorLessThan(
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

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
      authorLessThanOrEqualTo(
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

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
      authorBetween(
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

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
      authorStartsWith(
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

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
      authorEndsWith(
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

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
      authorContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
      authorMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
      authorIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
      authorIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 2,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
      wordEqualTo(
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

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
      wordGreaterThan(
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

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
      wordGreaterThanOrEqualTo(
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

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
      wordLessThan(
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

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
      wordLessThanOrEqualTo(
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

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
      wordBetween(
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

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
      wordStartsWith(
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

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
      wordEndsWith(
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

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
      wordContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
      wordMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
      wordIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
      wordIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 3,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
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

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
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

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
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

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
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

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
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

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
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

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
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

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
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

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
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

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
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

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
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

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
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

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
      sheetRownoKeysIsEmpty() {
    return not().sheetRownoKeysIsNotEmpty();
  }

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterFilterCondition>
      sheetRownoKeysIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 4, value: null),
      );
    });
  }
}

extension AuthorWordFilterQueryObject
    on QueryBuilder<AuthorWordFilter, AuthorWordFilter, QFilterCondition> {}

extension AuthorWordFilterQuerySortBy
    on QueryBuilder<AuthorWordFilter, AuthorWordFilter, QSortBy> {
  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterSortBy>
      sortByAuthorWordKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterSortBy>
      sortByAuthorWordKeyDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterSortBy> sortByAuthor(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterSortBy>
      sortByAuthorDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        2,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterSortBy> sortByWord(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        3,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterSortBy> sortByWordDesc(
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

extension AuthorWordFilterQuerySortThenBy
    on QueryBuilder<AuthorWordFilter, AuthorWordFilter, QSortThenBy> {
  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterSortBy>
      thenByAuthorWordKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterSortBy>
      thenByAuthorWordKeyDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterSortBy> thenByAuthor(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterSortBy>
      thenByAuthorDesc({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterSortBy> thenByWord(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterSortBy> thenByWordDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(3, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }
}

extension AuthorWordFilterQueryWhereDistinct
    on QueryBuilder<AuthorWordFilter, AuthorWordFilter, QDistinct> {
  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterDistinct>
      distinctByAuthor({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterDistinct>
      distinctByWord({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(3, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AuthorWordFilter, AuthorWordFilter, QAfterDistinct>
      distinctBySheetRownoKeys() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(4);
    });
  }
}

extension AuthorWordFilterQueryProperty1
    on QueryBuilder<AuthorWordFilter, AuthorWordFilter, QProperty> {
  QueryBuilder<AuthorWordFilter, String, QAfterProperty>
      authorWordKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<AuthorWordFilter, String, QAfterProperty> authorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<AuthorWordFilter, String, QAfterProperty> wordProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<AuthorWordFilter, List<String>, QAfterProperty>
      sheetRownoKeysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }
}

extension AuthorWordFilterQueryProperty2<R>
    on QueryBuilder<AuthorWordFilter, R, QAfterProperty> {
  QueryBuilder<AuthorWordFilter, (R, String), QAfterProperty>
      authorWordKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<AuthorWordFilter, (R, String), QAfterProperty> authorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<AuthorWordFilter, (R, String), QAfterProperty> wordProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<AuthorWordFilter, (R, List<String>), QAfterProperty>
      sheetRownoKeysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }
}

extension AuthorWordFilterQueryProperty3<R1, R2>
    on QueryBuilder<AuthorWordFilter, (R1, R2), QAfterProperty> {
  QueryBuilder<AuthorWordFilter, (R1, R2, String), QOperations>
      authorWordKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<AuthorWordFilter, (R1, R2, String), QOperations>
      authorProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }

  QueryBuilder<AuthorWordFilter, (R1, R2, String), QOperations> wordProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(3);
    });
  }

  QueryBuilder<AuthorWordFilter, (R1, R2, List<String>), QOperations>
      sheetRownoKeysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(4);
    });
  }
}
