class Todos {
  final String id;
  final String title;
  final bool done;

  const Todos({required this.id, required this.title, required this.done});

  factory Todos.fromJson(Map<String, dynamic> json) {
    return Todos(
      id: json['id'] as String,
      title: json['title'] as String,
      done: json['done'] as bool,
    );
  }
}
