// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catscrud.dart';

// **************************************************************************
// _IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// ignore_for_file: type=lint

extension GetCatCollection on Isar {
  IsarCollection<String, Cat> get cats => this.collection();
}

const CatSchema = IsarGeneratedSchema(
  schema: IsarSchema(
    name: 'Cat',
    idName: 'catpath',
    embedded: false,
    properties: [
      IsarPropertySchema(
        name: 'catpath',
        type: IsarType.string,
      ),
    ],
    indexes: [],
  ),
  converter: IsarObjectConverter<String, Cat>(
    serialize: serializeCat,
    deserialize: deserializeCat,
    deserializeProperty: deserializeCatProp,
  ),
  embeddedSchemas: [],
);

@isarProtected
int serializeCat(IsarWriter writer, Cat object) {
  IsarCore.writeString(writer, 1, object.catpath);
  return Isar.fastHash(object.catpath);
}

@isarProtected
Cat deserializeCat(IsarReader reader) {
  final object = Cat();
  object.catpath = IsarCore.readString(reader, 1) ?? '';
  return object;
}

@isarProtected
dynamic deserializeCatProp(IsarReader reader, int property) {
  switch (property) {
    case 1:
      return IsarCore.readString(reader, 1) ?? '';
    default:
      throw ArgumentError('Unknown property: $property');
  }
}

extension CatQueryFilter on QueryBuilder<Cat, Cat, QFilterCondition> {
  QueryBuilder<Cat, Cat, QAfterFilterCondition> catpathEqualTo(
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

  QueryBuilder<Cat, Cat, QAfterFilterCondition> catpathGreaterThan(
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

  QueryBuilder<Cat, Cat, QAfterFilterCondition> catpathGreaterThanOrEqualTo(
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

  QueryBuilder<Cat, Cat, QAfterFilterCondition> catpathLessThan(
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

  QueryBuilder<Cat, Cat, QAfterFilterCondition> catpathLessThanOrEqualTo(
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

  QueryBuilder<Cat, Cat, QAfterFilterCondition> catpathBetween(
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

  QueryBuilder<Cat, Cat, QAfterFilterCondition> catpathStartsWith(
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

  QueryBuilder<Cat, Cat, QAfterFilterCondition> catpathEndsWith(
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

  QueryBuilder<Cat, Cat, QAfterFilterCondition> catpathContains(String value,
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

  QueryBuilder<Cat, Cat, QAfterFilterCondition> catpathMatches(String pattern,
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

  QueryBuilder<Cat, Cat, QAfterFilterCondition> catpathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const EqualCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }

  QueryBuilder<Cat, Cat, QAfterFilterCondition> catpathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 1,
          value: '',
        ),
      );
    });
  }
}

extension CatQueryObject on QueryBuilder<Cat, Cat, QFilterCondition> {}

extension CatQuerySortBy on QueryBuilder<Cat, Cat, QSortBy> {
  QueryBuilder<Cat, Cat, QAfterSortBy> sortByCatpath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(
        1,
        caseSensitive: caseSensitive,
      );
    });
  }

  QueryBuilder<Cat, Cat, QAfterSortBy> sortByCatpathDesc(
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

extension CatQuerySortThenBy on QueryBuilder<Cat, Cat, QSortThenBy> {
  QueryBuilder<Cat, Cat, QAfterSortBy> thenByCatpath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Cat, Cat, QAfterSortBy> thenByCatpathDesc(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
    });
  }
}

extension CatQueryWhereDistinct on QueryBuilder<Cat, Cat, QDistinct> {}

extension CatQueryProperty1 on QueryBuilder<Cat, Cat, QProperty> {
  QueryBuilder<Cat, String, QAfterProperty> catpathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }
}

extension CatQueryProperty2<R> on QueryBuilder<Cat, R, QAfterProperty> {
  QueryBuilder<Cat, (R, String), QAfterProperty> catpathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }
}

extension CatQueryProperty3<R1, R2>
    on QueryBuilder<Cat, (R1, R2), QAfterProperty> {
  QueryBuilder<Cat, (R1, R2, String), QOperations> catpathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(1);
    });
  }
}
