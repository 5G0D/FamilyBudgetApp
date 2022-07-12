class OperationResponse {
  final int id;
  final int? categoryId;
  final int date;
  final String description;
  final num value;

  const OperationResponse({
    required this.id,
    required this.date,
    required this.description,
    required this.value,
    this.categoryId,
  });

  factory OperationResponse.fromJson(Map<String, dynamic> json) {
    return OperationResponse(
      id: json['id'],
      date: json['date'],
      description: json['description'],
      value: json['value'].toDouble(),
      categoryId: json['categoryId'],
    );
  }
}