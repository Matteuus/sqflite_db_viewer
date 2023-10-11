const String taskTable = "taskTable";
const String idColumn = "idColumn";
const String descColumn = "descColumn";
const String checkColumn = "checkColumn";

class Task {
  int? id;
  String? desc;
  bool? check;

  Task({this.id, this.desc = '', this.check = false});

  bollToInt(bool value) {
    return value == false ? 0 : 1;
  }

  Task.fromMap(Map<String, dynamic> map) {
    id = map[idColumn];
    desc = map[descColumn];
    check = map[checkColumn] == 1;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      descColumn: desc,
      checkColumn: check == true ? 1 : 0,
    };
    if (id != null) {
      map[idColumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Task(id: $id, name: $desc, , check: $check)";
  }
}
