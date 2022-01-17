/// extract the value at the specified path "dot-seprated string" from the specified data
T? selectFrom<T>(dynamic data, String path) {
  var parts = [];
  var currentKeyName = "";

  for (var i = 0; i < path.length; i++) {
    if (path[i] != "\\" && path[i] != ".") {
      currentKeyName += path[i];
      continue;
    }

    var hasAcharSkip = false;
    if (path[i] == "\\") {
      hasAcharSkip = true;
      i++;
    }

    if (path[i] == ".") {
      if (hasAcharSkip) {
        currentKeyName += path[i];
        continue;
      }

      parts.add(currentKeyName);
      currentKeyName = "";
      continue;
    }
  }

  if (currentKeyName != "") {
    parts.add(currentKeyName);
  }

  dynamic val = data;

  for (var i = 0; i < parts.length; i++) {
    if (parts[i].startsWith("#")) {
      int index = int.parse(parts[i].substring(1));
      val = (val as List<dynamic>)[index];
    } else {
      val = (val as Map<String, dynamic>)[parts[i]];
    }

    if (val == null) {
      return null;
    }
  }

  return val as T;
}

/// add a select method to any map
extension MapPathSelector<K, V> on Map<K, V> {
  T? select<T>(String path) {
    return selectFrom(this, path);
  }
}

/// add a select method to any list
extension ListPathSelector<V> on List<V> {
  T? select<T>(String path) {
    return selectFrom(this, path);
  }
}
