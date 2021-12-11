
class Benevole {

	int _id;
	String _name;
	String _number;
	String _email;
	String _adresse;
  String _profession;
  String _availability;

	Benevole(this._name, this._number, this._email, this._adresse, this._profession, this._availability);

	Benevole.withId(this._id, this._name, this._number, this._email, this._adresse, this._profession, this._availability);

	int get id => _id;

	String get name => _name;

	String get adresse => _adresse;

	String get email => _email;

	String get number => _number;

  String get profession => _profession;

  String get availability => _availability;

	set name(String newName) {
			this._name = newName;
	}

	set number(String newNumber) {
			this._adresse = newNumber;
	}

	set email(String newEmail) {
			this._email = newEmail;
	}

	set adresse(String newAdresse) {
		this._number = newAdresse;
	}

  set profession(String newProfession) {
		this._profession = newProfession;
	}

  set availability(String newAvailability) {
		this._availability = newAvailability;
	}

	// Convert a Note object into a Map object
	Map<String, dynamic> toMap() {

		var map = Map<String, dynamic>();
		if (id != null) {
			map['id'] = _id;
		}
		map['name'] = _name;
		map['adresse'] = _adresse;
		map['email'] = _email;
		map['number'] = _number;
    map['profession'] = _profession;
    map['availability'] =_availability;

		return map;
	}

	// Extract a Note object from a Map object
	Benevole.fromMapObject(Map<String, dynamic> map) {
		this._id = map['id'];
		this._name = map['name'];
		this._adresse = map['adresse'];
		this._email = map['email'];
		this._number = map['number'];
    this._profession = map['profession'];
    this._availability = map['availability'];
	}
}









