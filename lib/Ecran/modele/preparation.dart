class Preparation {
  int _id_prep = 0;
  int _id_enseigne = 0;
  String _libelle_prep = "";
  String _description = "";
  String _date_prep = "";
  String _design_magasin = "";

  get design_magasin => this._design_magasin;

  set design_magasin(value) => this._design_magasin = value;

  Preparation();

  Preparation.id(this._id_prep, this._libelle_prep, this._description, this._date_prep, this._id_enseigne);

  get id_prep => this._id_prep;

  set id_prep(value) => this._id_prep = value;

  get id_enseigne => this._id_enseigne;

  set id_enseigne(value) => this._id_enseigne = value;

  get libelle_prep => this._libelle_prep;

  set libelle_prep(value) => this._libelle_prep = value;

  get description => this._description;

  set description(value) => this._description = value;

  get date_prep => this._date_prep;

  set date_prep(value) => this._date_prep = value;

  void fromMap(Map<String, dynamic> map) {
    id_prep = map["id_prep"];
    libelle_prep = map["libelle_prep"];
    description = map["description"];
    id_enseigne = map["id_enseigne"];
    date_prep = map["date_prep"];
    design_magasin = map["design_enseigne"];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};

    map["id_prep"] = _id_prep;
    map["libelle_prep"] = _libelle_prep;
    map["description"] = _description;
    map["id_enseigne"] = _id_enseigne;
    map["date_prep"] = _date_prep;

    return map;
  }
}
