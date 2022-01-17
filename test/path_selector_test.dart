import 'dart:convert';

import 'package:path_selector/path_selector.dart';
import 'package:test/test.dart';

void main() {
  group('Basic path_selector test cases', () {
    final Map<String, dynamic> map = jsonDecode('''
    {
      "name": "Some Name",
      "age": 28,
      "some.dot-key.included": "Works!",
      "skills": [
        {
          "name": "PHP",
          "rating": 0.9
        },
        {
          "name": "Golang",
          "rating": 0.9
        },
        {
          "name": "Python",
          "rating": 0.9
        }
      ]
    }
    ''');

    final List<dynamic> list = jsonDecode('["A", "B", {"key": "value"}]');

    test('Can select from a Map?', () {
      expect(map.select<String>("name"), "Some Name");
    });
    test('Can nest-select from a Map?', () {
      expect(map.select<String>("skills.#0.name"), "PHP");
    });
    test('Can select from a List?', () {
      expect(list.select<String>("#0"), "A");
    });
    test('Can nest-select from a List?', () {
      expect(list.select<String>("#2.key"), "value");
    });
    test('Can select dotted key?', () {
      expect(map.select<String>("some\\.dot-key\\.included"), "Works!");
    });
  });
}
