
import 'package:equatable/equatable.dart';

class ProvidersEntity extends Equatable {
  final String id;
  final String organizationId;
  final String name;
  final String inn;

  const ProvidersEntity({
    required this.id,
    required this.organizationId,
    required this.name,
    required this.inn,
  });

  @override
  List<Object?> get props => [id, organizationId, name, inn];
}
