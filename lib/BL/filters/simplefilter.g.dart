// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simplefilter.dart';

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
    idName: 'wordKey',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'wordKey',
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
  IsarCore.writeString(writer, 1, object.wordKey);
  {
    final list = object.sheetRownoKeys;
    final listWriter = IsarCore.beginList(writer, 2, list.length);
    for (var i = 0; i < list.length; i++) {
      IsarCore.writeString(listWriter, i, list[i]);
    }
    IsarCore.endList(writer, listWriter);
  }
  return Isar.fastHash(object.wordKey);
}

@isarProtected
SimpleFilter deserializeSimpleFilter(IsarReader reader) {
  final object = SimpleFilter();
  object.wordKey = IsarCore.readString(reader, 1) ?? '';
  {
    final length = IsarCore.readList(reader, 2, IsarCore.readerPtrPtr);
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
      {
        final length = IsarCore.readList(reader, 2, IsarCore.readerPtrPtr);
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

extension SimpleFilterQueryFilter
    on QueryBuilder<SimpleFilter, SimpleFilter, QFilterCondition> {
  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      wordKeyEqualTo(
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
      wordKeyGreaterThan(
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
      wordKeyGreaterThanOrEqualTo(
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
      wordKeyLessThan(
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
      wordKeyLessThanOrEqualTo(
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
      wordKeyBetween(
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
      wordKeyStartsWith(
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
      wordKeyEndsWith(
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
      wordKeyContains(String value, {bool caseSensitive = true}) {
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
      wordKeyMatches(String pattern, {bool caseSensitive = true}) {
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
      wordKeyIsEmpty() {
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
      wordKeyIsNotEmpty() {
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
      sheetRownoKeysElementEqualTo(
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
      sheetRownoKeysElementGreaterThan(
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
      sheetRownoKeysElementGreaterThanOrEqualTo(
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
      sheetRownoKeysElementLessThan(
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
      sheetRownoKeysElementLessThanOrEqualTo(
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
      sheetRownoKeysElementBetween(
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
      sheetRownoKeysElementStartsWith(
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
      sheetRownoKeysElementEndsWith(
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
      sheetRownoKeysElementContains(String value, {bool caseSensitive = true}) {
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
      sheetRownoKeysElementMatches(String pattern,
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

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      sheetRownoKeysElementIsEmpty() {
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
      sheetRownoKeysElementIsNotEmpty() {
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
      sheetRownoKeysIsEmpty() {
    return not().sheetRownoKeysIsNotEmpty();
  }

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterFilterCondition>
      sheetRownoKeysIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterOrEqualCondition(property: 2, value: null),
      );
    });
  }
}

extension SimpleFilterQueryObject
    on QueryBuilder<SimpleFilter, SimpleFilter, QFilterCondition> {}

extension SimpleFilterQuerySortBy
    on QueryBuilder<SimpleFilter, SimpleFilter, QSortBy> {
  QueryBuilder<SimpleFilter, SimpleFilter, QAfterSortBy> sortByWordKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterSortBy> sortByWordKeyDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        sort: Sort.desc,
        caseSensitive: caseSensitive,
      );
    });
  }
}

extension SimpleFilterQuerySortThenBy
    on QueryBuilder<SimpleFilter, SimpleFilter, QSortThenBy> {
  QueryBuilder<SimpleFilter, SimpleFilter, QAfterSortBy> thenByWordKey(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<SimpleFilter, SimpleFilter, QAfterSortBy> thenByWordKeyDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }
}

extension SimpleFilterQueryWhereDistinct
    on QueryBuilder<SimpleFilter, SimpleFilter, QDistinct> {
  QueryBuilder<SimpleFilter, SimpleFilter, QAfterDistinct>
      distinctBySheetRownoKeys() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2);
    });
  }
}

extension SimpleFilterQueryProperty1
    on QueryBuilder<SimpleFilter, SimpleFilter, QProperty> {
  QueryBuilder<SimpleFilter, String, QAfterProperty> wordKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<SimpleFilter, List<String>, QAfterProperty>
      sheetRownoKeysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }
}

extension SimpleFilterQueryProperty2<R>
    on QueryBuilder<SimpleFilter, R, QAfterProperty> {
  QueryBuilder<SimpleFilter, (R, String), QAfterProperty> wordKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<SimpleFilter, (R, List<String>), QAfterProperty>
      sheetRownoKeysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }
}

extension SimpleFilterQueryProperty3<R1, R2>
    on QueryBuilder<SimpleFilter, (R1, R2), QAfterProperty> {
  QueryBuilder<SimpleFilter, (R1, R2, String), QOperations> wordKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }

  QueryBuilder<SimpleFilter, (R1, R2, List<String>), QOperations>
      sheetRownoKeysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }
}
