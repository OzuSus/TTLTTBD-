class Status {
  final int id;
  final String name;

  Status({
    required this.id,
    required this.name,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}