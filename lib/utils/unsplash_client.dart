import 'package:unsplash_client/unsplash_client.dart';

class Unsplash {

  static final Unsplash _unsplash = Unsplash._internal();

  factory Unsplash() {
    return _unsplash;
  }

  Unsplash._internal();

  final unsplashClient = UnsplashClient(
    settings: const ClientSettings(
        credentials: AppCredentials(
      accessKey: String.fromEnvironment("access-key"),
      secretKey: String.fromEnvironment("secret-key"),
    )),
  );

  searchImage(String query,int page) async {
    Response<SearchResults<Photo>> results = await unsplashClient.search.photos(query, page: page,perPage: 5).go();

  }
}
