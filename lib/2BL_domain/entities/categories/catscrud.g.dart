// // GENERATED CODE - DO NOT MODIFY BY HAND

// part of 'catscrud.dart';

// // **************************************************************************
// // _IsarCollectionGenerator
// // **************************************************************************

// // coverage:ignore-file
// // ignore_for_file: duplicate_ignore, invalid_use_of_protected_member, lines_longer_than_80_chars, constant_identifier_names, avoid_js_rounded_ints, no_leading_underscores_for_local_identifiers, require_trailing_commas, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_in_if_null_operators, library_private_types_in_public_api, prefer_const_constructors
// // ignore_for_file: type=lint

// extension GetCatCollection on Isar {
//   IsarCollection<String, Cat> get cats => this.collection();
// }

// const CatSchema = IsarGeneratedSchema(
//   schema: IsarSchema(
//     name: 'Cat',
//     idName: 'catpath',
//     embedded: false,
//     properties: [
//       IsarPropertySchema(
//         name: 'catpath',
//         type: IsarType.string,
//       ),
//       IsarPropertySchema(
//         name: 'catNeme',
//         type: IsarType.string,
//       ),
//     ],
//     indexes: [],
//   ),
//   converter: IsarObjectConverter<String, Cat>(
//     serialize: serializeCat,
//     deserialize: deserializeCat,
//     deserializeProperty: deserializeCatProp,
//   ),
//   embeddedSchemas: [],
// );

// @isarProtected
// int serializeCat(IsarWriter writer, Cat object) {
//   IsarCore.writeString(writer, 1, object.catpath);
//   IsarCore.writeString(writer, 2, object.catNeme);
//   return Isar.fastHash(object.catpath);
// }

// @isarProtected
// Cat deserializeCat(IsarReader reader) {
//   final object = Cat();
//   object.catpath = IsarCore.readString(reader, 1) ?? '';
//   object.catNeme = IsarCore.readString(reader, 2) ?? '';
//   return object;
// }

// @isarProtected
// dynamic deserializeCatProp(IsarReader reader, int property) {
//   switch (property) {
//     case 1:
//       return IsarCore.readString(reader, 1) ?? '';
//     case 2:
//       return IsarCore.readString(reader, 2) ?? '';
//     default:
//       throw ArgumentError('Unknown property: $property');
//   }
// }

// sealed class _CatUpdate {
//   bool call({
//     required String catpath,
//     String? catNeme,
//   });
// }

// class _CatUpdateImpl implements _CatUpdate {
//   const _CatUpdateImpl(this.collection);

//   final IsarCollection<String, Cat> collection;

//   @override
//   bool call({
//     required String catpath,
//     Object? catNeme = ignore,
//   }) {
//     return collection.updateProperties([
//           catpath
//         ], {
//           if (catNeme != ignore) 2: catNeme as String?,
//         }) >
//         0;
//   }
// }

// sealed class _CatUpdateAll {
//   int call({
//     required List<String> catpath,
//     String? catNeme,
//   });
// }

// class _CatUpdateAllImpl implements _CatUpdateAll {
//   const _CatUpdateAllImpl(this.collection);

//   final IsarCollection<String, Cat> collection;

//   @override
//   int call({
//     required List<String> catpath,
//     Object? catNeme = ignore,
//   }) {
//     return collection.updateProperties(catpath, {
//       if (catNeme != ignore) 2: catNeme as String?,
//     });
//   }
// }

// extension CatUpdate on IsarCollection<String, Cat> {
//   _CatUpdate get update => _CatUpdateImpl(this);

//   _CatUpdateAll get updateAll => _CatUpdateAllImpl(this);
// }

// sealed class _CatQueryUpdate {
//   int call({
//     String? catNeme,
//   });
// }

// class _CatQueryUpdateImpl implements _CatQueryUpdate {
//   const _CatQueryUpdateImpl(this.query, {this.limit});

//   final IsarQuery<Cat> query;
//   final int? limit;

//   @override
//   int call({
//     Object? catNeme = ignore,
//   }) {
//     return query.updateProperties(limit: limit, {
//       if (catNeme != ignore) 2: catNeme as String?,
//     });
//   }
// }

// extension CatQueryUpdate on IsarQuery<Cat> {
//   _CatQueryUpdate get updateFirst => _CatQueryUpdateImpl(this, limit: 1);

//   _CatQueryUpdate get updateAll => _CatQueryUpdateImpl(this);
// }

// class _CatQueryBuilderUpdateImpl implements _CatQueryUpdate {
//   const _CatQueryBuilderUpdateImpl(this.query, {this.limit});

//   final QueryBuilder<Cat, Cat, QOperations> query;
//   final int? limit;

//   @override
//   int call({
//     Object? catNeme = ignore,
//   }) {
//     final q = query.build();
//     try {
//       return q.updateProperties(limit: limit, {
//         if (catNeme != ignore) 2: catNeme as String?,
//       });
//     } finally {
//       q.close();
//     }
//   }
// }

// extension CatQueryBuilderUpdate on QueryBuilder<Cat, Cat, QOperations> {
//   _CatQueryUpdate get updateFirst => _CatQueryBuilderUpdateImpl(this, limit: 1);

//   _CatQueryUpdate get updateAll => _CatQueryBuilderUpdateImpl(this);
// }

// extension CatQueryFilter on QueryBuilder<Cat, Cat, QFilterCondition> {
//   QueryBuilder<Cat, Cat, QAfterFilterCondition> catpathEqualTo(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(
//         EqualCondition(
//           property: 1,
//           value: value,
//           caseSensitive: caseSensitive,
//         ),
//       );
//     });
//   }

//   QueryBuilder<Cat, Cat, QAfterFilterCondition> catpathGreaterThan(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(
//         GreaterCondition(
//           property: 1,
//           value: value,
//           caseSensitive: caseSensitive,
//         ),
//       );
//     });
//   }

//   QueryBuilder<Cat, Cat, QAfterFilterCondition> catpathGreaterThanOrEqualTo(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(
//         GreaterOrEqualCondition(
//           property: 1,
//           value: value,
//           caseSensitive: caseSensitive,
//         ),
//       );
//     });
//   }

//   QueryBuilder<Cat, Cat, QAfterFilterCondition> catpathLessThan(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(
//         LessCondition(
//           property: 1,
//           value: value,
//           caseSensitive: caseSensitive,
//         ),
//       );
//     });
//   }

//   QueryBuilder<Cat, Cat, QAfterFilterCondition> catpathLessThanOrEqualTo(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(
//         LessOrEqualCondition(
//           property: 1,
//           value: value,
//           caseSensitive: caseSensitive,
//         ),
//       );
//     });
//   }

//   QueryBuilder<Cat, Cat, QAfterFilterCondition> catpathBetween(
//     String lower,
//     String upper, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(
//         BetweenCondition(
//           property: 1,
//           lower: lower,
//           upper: upper,
//           caseSensitive: caseSensitive,
//         ),
//       );
//     });
//   }

//   QueryBuilder<Cat, Cat, QAfterFilterCondition> catpathStartsWith(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(
//         StartsWithCondition(
//           property: 1,
//           value: value,
//           caseSensitive: caseSensitive,
//         ),
//       );
//     });
//   }

//   QueryBuilder<Cat, Cat, QAfterFilterCondition> catpathEndsWith(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(
//         EndsWithCondition(
//           property: 1,
//           value: value,
//           caseSensitive: caseSensitive,
//         ),
//       );
//     });
//   }

//   QueryBuilder<Cat, Cat, QAfterFilterCondition> catpathContains(String value,
//       {bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(
//         ContainsCondition(
//           property: 1,
//           value: value,
//           caseSensitive: caseSensitive,
//         ),
//       );
//     });
//   }

//   QueryBuilder<Cat, Cat, QAfterFilterCondition> catpathMatches(String pattern,
//       {bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(
//         MatchesCondition(
//           property: 1,
//           wildcard: pattern,
//           caseSensitive: caseSensitive,
//         ),
//       );
//     });
//   }

//   QueryBuilder<Cat, Cat, QAfterFilterCondition> catpathIsEmpty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(
//         const EqualCondition(
//           property: 1,
//           value: '',
//         ),
//       );
//     });
//   }

//   QueryBuilder<Cat, Cat, QAfterFilterCondition> catpathIsNotEmpty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(
//         const GreaterCondition(
//           property: 1,
//           value: '',
//         ),
//       );
//     });
//   }

//   QueryBuilder<Cat, Cat, QAfterFilterCondition> catNemeEqualTo(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(
//         EqualCondition(
//           property: 2,
//           value: value,
//           caseSensitive: caseSensitive,
//         ),
//       );
//     });
//   }

//   QueryBuilder<Cat, Cat, QAfterFilterCondition> catNemeGreaterThan(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(
//         GreaterCondition(
//           property: 2,
//           value: value,
//           caseSensitive: caseSensitive,
//         ),
//       );
//     });
//   }

//   QueryBuilder<Cat, Cat, QAfterFilterCondition> catNemeGreaterThanOrEqualTo(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(
//         GreaterOrEqualCondition(
//           property: 2,
//           value: value,
//           caseSensitive: caseSensitive,
//         ),
//       );
//     });
//   }

//   QueryBuilder<Cat, Cat, QAfterFilterCondition> catNemeLessThan(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(
//         LessCondition(
//           property: 2,
//           value: value,
//           caseSensitive: caseSensitive,
//         ),
//       );
//     });
//   }

//   QueryBuilder<Cat, Cat, QAfterFilterCondition> catNemeLessThanOrEqualTo(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(
//         LessOrEqualCondition(
//           property: 2,
//           value: value,
//           caseSensitive: caseSensitive,
//         ),
//       );
//     });
//   }

//   QueryBuilder<Cat, Cat, QAfterFilterCondition> catNemeBetween(
//     String lower,
//     String upper, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(
//         BetweenCondition(
//           property: 2,
//           lower: lower,
//           upper: upper,
//           caseSensitive: caseSensitive,
//         ),
//       );
//     });
//   }

//   QueryBuilder<Cat, Cat, QAfterFilterCondition> catNemeStartsWith(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(
//         StartsWithCondition(
//           property: 2,
//           value: value,
//           caseSensitive: caseSensitive,
//         ),
//       );
//     });
//   }

//   QueryBuilder<Cat, Cat, QAfterFilterCondition> catNemeEndsWith(
//     String value, {
//     bool caseSensitive = true,
//   }) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(
//         EndsWithCondition(
//           property: 2,
//           value: value,
//           caseSensitive: caseSensitive,
//         ),
//       );
//     });
//   }

//   QueryBuilder<Cat, Cat, QAfterFilterCondition> catNemeContains(String value,
//       {bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(
//         ContainsCondition(
//           property: 2,
//           value: value,
//           caseSensitive: caseSensitive,
//         ),
//       );
//     });
//   }

//   QueryBuilder<Cat, Cat, QAfterFilterCondition> catNemeMatches(String pattern,
//       {bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(
//         MatchesCondition(
//           property: 2,
//           wildcard: pattern,
//           caseSensitive: caseSensitive,
//         ),
//       );
//     });
//   }

//   QueryBuilder<Cat, Cat, QAfterFilterCondition> catNemeIsEmpty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(
//         const EqualCondition(
//           property: 2,
//           value: '',
//         ),
//       );
//     });
//   }

//   QueryBuilder<Cat, Cat, QAfterFilterCondition> catNemeIsNotEmpty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addFilterCondition(
//         const GreaterCondition(
//           property: 2,
//           value: '',
//         ),
//       );
//     });
//   }
// }

// extension CatQueryObject on QueryBuilder<Cat, Cat, QFilterCondition> {}

// extension CatQuerySortBy on QueryBuilder<Cat, Cat, QSortBy> {
//   QueryBuilder<Cat, Cat, QAfterSortBy> sortByCatpath(
//       {bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(
//         1,
//         caseSensitive: caseSensitive,
//       );
//     });
//   }

//   QueryBuilder<Cat, Cat, QAfterSortBy> sortByCatpathDesc(
//       {bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(
//         1,
//         sort: Sort.desc,
//         caseSensitive: caseSensitive,
//       );
//     });
//   }

//   QueryBuilder<Cat, Cat, QAfterSortBy> sortByCatNeme(
//       {bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(
//         2,
//         caseSensitive: caseSensitive,
//       );
//     });
//   }

//   QueryBuilder<Cat, Cat, QAfterSortBy> sortByCatNemeDesc(
//       {bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(
//         2,
//         sort: Sort.desc,
//         caseSensitive: caseSensitive,
//       );
//     });
//   }
// }

// extension CatQuerySortThenBy on QueryBuilder<Cat, Cat, QSortThenBy> {
//   QueryBuilder<Cat, Cat, QAfterSortBy> thenByCatpath(
//       {bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(1, caseSensitive: caseSensitive);
//     });
//   }

//   QueryBuilder<Cat, Cat, QAfterSortBy> thenByCatpathDesc(
//       {bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(1, sort: Sort.desc, caseSensitive: caseSensitive);
//     });
//   }

//   QueryBuilder<Cat, Cat, QAfterSortBy> thenByCatNeme(
//       {bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(2, caseSensitive: caseSensitive);
//     });
//   }

//   QueryBuilder<Cat, Cat, QAfterSortBy> thenByCatNemeDesc(
//       {bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addSortBy(2, sort: Sort.desc, caseSensitive: caseSensitive);
//     });
//   }
// }

// extension CatQueryWhereDistinct on QueryBuilder<Cat, Cat, QDistinct> {
//   QueryBuilder<Cat, Cat, QAfterDistinct> distinctByCatNeme(
//       {bool caseSensitive = true}) {
//     return QueryBuilder.apply(this, (query) {
//       return query.addDistinctBy(2, caseSensitive: caseSensitive);
//     });
//   }
// }

// extension CatQueryProperty1 on QueryBuilder<Cat, Cat, QProperty> {
//   QueryBuilder<Cat, String, QAfterProperty> catpathProperty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addProperty(1);
//     });
//   }

//   QueryBuilder<Cat, String, QAfterProperty> catNemeProperty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addProperty(2);
//     });
//   }
// }

// extension CatQueryProperty2<R> on QueryBuilder<Cat, R, QAfterProperty> {
//   QueryBuilder<Cat, (R, String), QAfterProperty> catpathProperty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addProperty(1);
//     });
//   }

//   QueryBuilder<Cat, (R, String), QAfterProperty> catNemeProperty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addProperty(2);
//     });
//   }
// }

// extension CatQueryProperty3<R1, R2>
//     on QueryBuilder<Cat, (R1, R2), QAfterProperty> {
//   QueryBuilder<Cat, (R1, R2, String), QOperations> catpathProperty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addProperty(1);
//     });
//   }

//   QueryBuilder<Cat, (R1, R2, String), QOperations> catNemeProperty() {
//     return QueryBuilder.apply(this, (query) {
//       return query.addProperty(2);
//     });
//   }
// }
