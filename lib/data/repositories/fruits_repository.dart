import 'package:surf_flutter_winter_internship_2025/data/datasources/api_client.dart';
import 'package:surf_flutter_winter_internship_2025/data/dto/fruit_dto.dart';
import 'package:surf_flutter_winter_internship_2025/data/mappers/fruit_network_mapper.dart';
import 'package:surf_flutter_winter_internship_2025/domain/entities/fruit.dart';
import 'package:surf_flutter_winter_internship_2025/data/repositories/base_remote_repository.dart';
import 'package:surf_flutter_winter_internship_2025/domain/repositories/i_fruits_repository.dart';


final class FruitsRepository extends BaseRemoteRepository implements IFruitsRepository {
  final ApiClient _apiClient;
  final IFruitNetworkMapper _fruitMapper;

  FruitsRepository({required apiClient, required fruitMapper})
    : _apiClient = apiClient,
      _fruitMapper = fruitMapper;

  @override
  Future<List<Fruit>> getAllFruits() async {
    return await handleException(() async {
      final List<FruitDto> dtos = await _apiClient.getAllFruits();
      return _fruitMapper.toEntityList(dtos);
    });
  }
}
