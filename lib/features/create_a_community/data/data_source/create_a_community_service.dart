import 'package:equatable/equatable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'create_a_community_service.g.dart';

@RestApi(baseUrl: "http://10.0.2.2:3001/M7MDREFAAT550/Spreadit/2.0.0")
abstract class RestClient {
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  @POST("/communities/create")
  Future<HttpResponse> createCommunity(@Body() Community community);
}

class Community extends Equatable {
  final String communityName;

  Community(this.communityName);

  @override
  List<Object> get props => [communityName];

  Map<String, dynamic> toJson() {
    return {
      'name': communityName,
    };
  }
}
