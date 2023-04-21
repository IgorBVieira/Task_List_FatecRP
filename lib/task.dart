class Task {
  String? id;
  String? name;
  String? priority;
  bool? finished;

  Task(this.id, this.name, {this.priority = 'low', this.finished = false});
}

//este arquivo serve apenas para instanciar tarefas offline
