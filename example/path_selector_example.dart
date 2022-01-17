import 'dart:convert';

import 'package:path_selector/path_selector.dart';

void main() {
  final Map<String, dynamic> map = jsonDecode('''
    {
      "name": "Mohamed Al Ashaal",
      "age": 28,
      "contacts": {
        "email": "m7medalash3al@gmail.com",
        "facebook": "https://fb.me/alash3al",
        "github": "https://github.com/alash3al"
      },
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

  // will print: Mohamed Al Ashaal
  print(map.select("name"));

  // will print: 20
  print(map.select("age"));

  // will print: m7medalash3al@gmail.com
  print(map.select("contacts.email"));

  // will print: [{name: PHP, rating: 0.9}, {name: Golang, rating: 0.9}, {name: Python, rating: 0.9}]
  print(map.select("skills"));

  // will print {name: PHP, rating: 0.9}
  print(map.select("skills.#0"));

  // will print: PHP
  print(map.select("skills.#0.name"));

  // will print: null
  print(map.select("skills2.unknown_key.value"));

  // will print: Works!
  print(map.select("some\\.dot-key\\.included"));
}
