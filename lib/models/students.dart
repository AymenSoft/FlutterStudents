
class Student {
  int _id;
  String _name;
  String _description;
  String _status;

  Student.set(this._id, this._name, this._description, this._status);

  Student();

  int get getId => _id;

  set id(int value) {
    _id = value;
  }

  String get getName => _name;

  set setName(String value) {
    _name = value;
  }

  String get getDescription => _description;

  set setDescription(String value) {
    _description = value;
  }

  String get getStatus => _status;

  set setStatus(String value) {
    _status = value;
  }

  Map<String, dynamic> toMap(){
    var map = Map<String, dynamic>();
    map["id"] = this._id;
    map["name"] = this._name;
    map["description"] = this._description;
    map["status"]  = this._status;
    return map;
  }

  Student.getMap(Map<String, dynamic>map){
    this._id = map["id"];
    this._name = map["name"];
    this._description = map["description"];
    this._status = map["status"];
  }

  @override
  String toString() {
    return 'Student{_id: $_id, _name: $_name, _description: $_description, _status: $_status}';
  }
}