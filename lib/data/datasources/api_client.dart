import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

import '../dto/fruit_dto.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: 'https://www.fruityvice.com/api')
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  // TODO: Extract in const
  @GET("/fruit/all")
  Future<List<FruitDto>> getAllFruits();
}
