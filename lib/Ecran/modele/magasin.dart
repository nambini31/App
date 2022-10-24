class Item {
  int id = 0;
  String nom = "";

  Item();

  fromMap(Map<String, dynamic> map) {
    if (map["id"] != null) {
      id = map["id"];
    }
    nom = map["nom"];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {"nom": nom};
    return map;
  }
}
