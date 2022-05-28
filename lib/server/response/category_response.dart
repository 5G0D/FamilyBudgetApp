class CategoryResponse {
  final int id;
  final String name;
  final String iconCode;
  final String iconColor;
  final int blockLocation;
  final int positionLocation;
  final int moneyFlowType;

  const CategoryResponse({
    required this.id,
    required this.name,
    required this.iconCode,
    required this.iconColor,
    required this.blockLocation,
    required this.positionLocation,
    required this.moneyFlowType,
  });

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      id: json['id'],
      name: json['name'],
      iconCode: json['iconCode'],
      iconColor: json['iconColor'],
      blockLocation: json['blockLocation'],
      positionLocation: json['positionLocation'],
      moneyFlowType: json['moneyFlowType'],
    );
  }
}