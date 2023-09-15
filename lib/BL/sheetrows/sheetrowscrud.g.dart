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
  {
    final list = object.sheetRowArr;
    final listWriter = IsarCore.beginList(writer, 2, list.length);
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
  {
    final length = IsarCore.readList(reader, 2, IsarCore.readerPtrPtr);
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

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition>
      sheetRowArrElementEqualTo(
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
      sheetRowArrElementGreaterThan(
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
      sheetRowArrElementGreaterThanOrEqualTo(
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

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition>
      sheetRowArrElementLessThan(
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
      sheetRowArrElementLessThanOrEqualTo(
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

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition>
      sheetRowArrElementBetween(
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

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition>
      sheetRowArrElementStartsWith(
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

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition>
      sheetRowArrElementEndsWith(
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

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition>
      sheetRowArrElementContains(String value, {bool caseSensitive = true}) {
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

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition>
      sheetRowArrElementMatches(String pattern, {bool caseSensitive = true}) {
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

  QueryBuilder<SheetRow, SheetRow, QAfterFilterCondition>
      sheetRowArrElementIsEmpty() {
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
      sheetRowArrElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(
        const GreaterCondition(
          property: 2,
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
        const GreaterOrEqualCondition(property: 2, value: null),
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
}

extension SheetRowQueryWhereDistinct
    on QueryBuilder<SheetRow, SheetRow, QDistinct> {
  QueryBuilder<SheetRow, SheetRow, QAfterDistinct> distinctBySheetRowArr() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(2);
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

  QueryBuilder<SheetRow, List<String>, QAfterProperty> sheetRowArrProperty() {
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

  QueryBuilder<SheetRow, (R, List<String>), QAfterProperty>
      sheetRowArrProperty() {
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

  QueryBuilder<SheetRow, (R1, R2, List<String>), QOperations>
      sheetRowArrProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addProperty(2);
    });
  }
}
