class Contacts {
  final String? displayName;
  final List<Item>? phones;

  Contacts({
    this.displayName,
    this.phones,
  });

  factory Contacts.fromMap(Map<String, dynamic> map) {
    return Contacts(
      displayName: map['displayName'],
      phones: (map['phones'] as List<dynamic>?)
          ?.map((item) => Item.fromMap(item))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'displayName': displayName,
      'phones': phones?.map((item) => item.toMap()).toList(),
    };
  }
}

class Item {
  final String? value;

  Item({
    this.value,
  });

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      value: map['value'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'value': value,
    };
  }
}
