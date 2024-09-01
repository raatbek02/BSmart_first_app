import 'package:bsmart_first_app/core/api/api_client.dart';
import 'package:bsmart_first_app/features/arrival/data/models/arrival_detail_model.dart';
import 'package:bsmart_first_app/features/arrival/data/models/arrival_model.dart';
import 'package:bsmart_first_app/features/arrival/domain/entities/arrival_detail_entity.dart';
import 'package:bsmart_first_app/features/arrival/domain/entities/arrival_entitity.dart';
import 'package:dio/dio.dart';

abstract class ArrivalRemoteDataSource {
  Future<ArrivalEntity> listArrival(String organizationId,
      {required int page, required int size});

  Future<ArrivalDetailEntity> getArrivalDetail(String organizationId, String id);
}

class ArrivalRemoteDataSourceImpl implements ArrivalRemoteDataSource {
  final ApiClient apiClient;

  ArrivalRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<ArrivalEntity> listArrival(String organizationId,
      {int page = 0, int size = 10}) async {
    try {
      final response = await apiClient.postData(
          '/api/products/purchases/$organizationId/search?page=$page&size=$size',
          {"provider": null, "documentNumber": null, "type": null});

      if (response.statusCode == 200) {
        if (response.data is Map<String, dynamic>) {
          final arrivalModel =
              ArrivalModel.fromJson(response.data as Map<String, dynamic>);
          return arrivalModel;
        } else {
          throw Exception('Unexpected response format');
        }
      } else {
        throw Exception(
            'Failed to load arrival list : ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to load arrival list: ${e.message}');
    } catch (e) {
      throw Exception('Failed to load arrival list: $e');
    }
  }
  
  @override
  Future<ArrivalDetailEntity> getArrivalDetail(String organizationId, String id)async {

    try {
      final response = await apiClient.getData(
          '/api/products/purchases/$organizationId/$id');

      if (response.statusCode == 200) {
        if (response.data is Map<String, dynamic>) {
          final arrivalDetailModel =
              ArrivalDetailModel.fromJson(response.data as Map<String, dynamic>);
          return arrivalDetailModel;
        } else {
          throw Exception('Unexpected response format');
        }
      } else {
        throw Exception(
            'Failed to load arrival detail : ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to load arrival detail: ${e.message}');
    } catch (e) {
      throw Exception('Failed to load arrival detail: $e');
    }
   
  }
}

// Arrival detail FAAAILED: Exception: Failed to load arrival detail: type 'int' is not a subtype of type 'double'