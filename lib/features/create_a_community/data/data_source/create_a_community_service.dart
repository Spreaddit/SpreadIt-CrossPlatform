/// This file contains the RestClient class and the Community class.
///
/// The RestClient class is an abstract class that defines the API calls related to communities.
/// The Community class represents a community object with a name.

import 'package:equatable/equatable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:spreadit_crossplatform/api.dart';

part 'create_a_community_service.g.dart';

/// RestClient is an abstract class that defines the API calls related to communities.
/// It uses the Retrofit package for making HTTP requests.
@RestApi(baseUrl: apiUrl)
abstract class RestClient {
  /// Creates a RestClient instance.
  factory RestClient(Dio dio, {String baseUrl}) = _RestClient;

  /// Sends a POST request to the "/communities/create" endpoint to create a new community.
  ///
  /// The [community] parameter is the community to be created.
  @POST("/community/create")
  Future<HttpResponse> createCommunity(
    @Body() Community community,
    @Header("Authorization") String token,
  );
}

/// Community is a class that represents a community with a name.
///
/// It extends the Equatable class to make it easy to compare instances of Community.
class Community extends Equatable {
  /// The name of the community.
  final String communityName;
  final bool is18Plus;
  final String communityType;

  /// Creates a Community instance.
  Community(this.communityName, this.is18Plus, this.communityType);

  @override

  /// Returns a list of properties to be used for equality checks.
  List<Object> get props => [communityName];

  /// Converts the Community instance into a JSON format.
  Map<String, dynamic> toJson() {
    return {
      'name': communityName,
      'is18plus': is18Plus,
      'communityType': communityType,
    };
  }
}
