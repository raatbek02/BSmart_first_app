
import 'package:bsmart_first_app/features/arrival/domain/entities/providers_entity.dart';

class ProvidersModel extends ProvidersEntity {
  const ProvidersModel({
    required super.id,
    required super.organizationId,
    required super.name,
    required super.inn,
  });

  factory ProvidersModel.fromJson(Map<String, dynamic> json) {
    return ProvidersModel(
      id: json['id'] ?? '',
      organizationId: json['organizationId'] ?? '',
      name: json['name'] ?? '',
      inn: json['inn'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'organizationId': organizationId,
      'name': name,
      'inn': inn,
    };
  }
}
