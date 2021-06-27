// stringutil_test.dart
// MoneyCurrency Copyright © 2021; Electric Bolt Limited.

import 'package:test/test.dart';
import 'package:moneycurrency/src/stringutil.dart';

void main() {
  test('prefix', ()
  {
    expect('hello'.removePrefix('hello'), equals(''));
    expect('hello'.removePrefix(''), equals('hello'));
    expect(''.removePrefix('he'), equals(''));
    expect('hello'.removePrefix('he'), equals('llo'));
  });

  test('suffix', ()
  {
    expect('hello'.removeSuffix('hello'), equals(''));
    expect('hello'.removeSuffix(''), equals('hello'));
    expect(''.removeSuffix('lo'), equals(''));
    expect('hello'.removeSuffix('lo'), equals('hel'));
  });

  test('insert', ()
  {
    expect('hello'.insert('world', 5), equals('helloworld'));
    expect('hello'.insert('world', 6), equals('helloworld'));
    expect('hello'.insert('world', 7), equals('helloworld'));
    expect(''.insert('world', 0), equals('world'));
    expect('hello'.insert('world', 0), equals('worldhello'));
    expect('hello'.insert('world', 1), equals('hworldello'));
    expect('hello'.insert('world', 3), equals('helworldlo'));
    expect('hello'.insert('world', 4), equals('hellworldo'));
  });

  test('reverse', ()
  {
    expect('hello'.reverse(), equals('olleh'));
    expect('he'.reverse(), equals('eh'));
    expect('h'.reverse(), equals('h'));
    expect(''.reverse(), equals(''));
  });
}