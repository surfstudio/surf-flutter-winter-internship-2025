import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:surf_flutter_winter_internship_2025/data/datasources/remote/api_urls.dart';
import 'package:surf_flutter_winter_internship_2025/data/datasources/remote/dto/fruit_dto.dart';


part 'api_client.g.dart';

@RestApi(baseUrl: 'https://www.fruityvice.com/api')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET(ApiUrls.allFruits)
  Future<List<FruitDto>> getAllFruits();
}
