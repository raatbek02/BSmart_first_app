import 'package:bsmart_first_app/core/api/api_client.dart';
import 'package:bsmart_first_app/features/arrival/data/models/arrival_detail_model.dart';
import 'package:bsmart_first_app/features/arrival/data/models/arrival_model.dart';
import 'package:bsmart_first_app/features/arrival/data/models/product_model.dart';
import 'package:bsmart_first_app/features/arrival/data/models/providers_model.dart';
import 'package:bsmart_first_app/features/arrival/domain/entities/arrival_detail_entity.dart';
import 'package:bsmart_first_app/features/arrival/domain/entities/arrival_entitity.dart';
import 'package:bsmart_first_app/features/arrival/domain/entities/create_arrival_entity.dart';
import 'package:bsmart_first_app/features/arrival/domain/entities/product_entity.dart';
import 'package:bsmart_first_app/features/arrival/domain/entities/providers_entity.dart';
import 'package:dio/dio.dart';

abstract class ArrivalRemoteDataSource {
  Future<ArrivalEntity> listArrival(String organizationId,
      {required int page, required int size});

  Future<ArrivalDetailEntity> getArrivalDetail(
      String organizationId, String id);

  Future<ProductEntity> getProductList(String organizationId,
      {required int page, required int size});

  Future<String> createArrival(
      String organizationId, CreateArrivalEntity arrival);

Future<List<ProvidersEntity>> getProviders(String organizationId);
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
  Future<ArrivalDetailEntity> getArrivalDetail(
      String organizationId, String id) async {
    try {
      final response = await apiClient
          .getData('/api/products/purchases/$organizationId/$id');

      if (response.statusCode == 200) {
        if (response.data is Map<String, dynamic>) {
          final arrivalDetailModel = ArrivalDetailModel.fromJson(
              response.data as Map<String, dynamic>);
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

  @override
  Future<ProductEntity> getProductList(String organizationId,
      {required int page, required int size}) async {
    try {
      final response = await apiClient.postData(
        '/api/products/stock/$organizationId/search?page=$page&size=$size',
        {},
      );

      if (response.statusCode == 200) {
        if (response.data is Map<String, dynamic>) {
          final productModel =
              ProductModel.fromJson(response.data as Map<String, dynamic>);
          return productModel;
        } else {
          throw Exception('Unexpected response format');
        }
      } else {
        throw Exception(
            'Failed to load product list : ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to load product list: ${e.message}');
    } catch (e) {
      throw Exception('Failed to load product list: $e');
    }
  }

  @override
  Future<String> createArrival(
      String organizationId, CreateArrivalEntity arrival) async {
    try {
      final response = await apiClient.postData(
        '/api/products/purchases/$organizationId',
        arrival.toJson(),
      );

      if (response.statusCode == 201) {
        if (response.data is String) {
          return response.data as String;
        } else {
          throw Exception('Unexpected response format');
        }
      } else {
        throw Exception('Failed to create arrival: ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to create arrival: ${e.message}');
    } catch (e) {
      throw Exception('Failed to create arrival: $e');
    }
  }
  
@override
  Future<List<ProvidersEntity>> getProviders(String organizationId) async {
    try {
      final response =
          await apiClient.getData('/api/products/dictionaries/$organizationId/providers');
      if (response.statusCode == 200) {
        if (response.data is List) {
          return (response.data as List)
              .map((provider) =>
                  ProvidersModel.fromJson(provider as Map<String, dynamic>))
              .toList();
        } else {
          throw Exception('Unexpected response format');
        }
      } else {
        throw Exception(
            'Failed to load providers list : ${response.statusMessage}');
      }
    } on DioException catch (e) {
      throw Exception('Failed to load providers list: ${e.message}');
    } catch (e) {
      throw Exception('Failed to load providers list: $e');
    }
  }
}

// Arrival detail FAAAILED: Exception: Failed to load arrival detail: type 'int' is not a subtype of type 'double'