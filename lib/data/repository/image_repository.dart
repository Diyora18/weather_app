

import '../../core/service/client.dart';
import '../../core/service/result.dart';

class CityImageRepository {
  final ApiClient _apiClient;
  static const _key = "Client-ID atcBcFzuvu-P9nt9ZLiyfHHcYsYOaszqdRWQj7xhfxw";

  CityImageRepository(this._apiClient);
  Future<Result<String>> getCityImage(String city) async {
    final res = await _fetch("$city skyline famous landmark", 1);

    return res.fold(
          (err) => Result.error(err),
          (urls) => urls.isEmpty
          ? Result.error(Exception("Malumot topilmadi"))
          : Result.ok(urls.first),
    );
  }


  Future<Result<List<String>>> getCityImages(String city, {int count = 5}) async {
    final res = await _fetch("$city city", count);
    return res.fold(
          (err) => Result.error(err),
          (urls) => urls.isEmpty
          ? Result.error(Exception("Rasmlar topilmadi"))
          : Result.ok(urls),
    );
  }

  Future<Result<List<String>>> _fetch(String query, int count) async {
    final res = await _apiClient.get<Map<String, dynamic>>(
      "https://api.unsplash.com/search/photos",
      queryParams: {
        "query": query,
        "per_page": "$count",
        "orientation": "landscape",
        "content_filter": "high",
      },
      headers: {"Authorization": _key},
    );

    return res.fold(
          (err) => Result.error(err),
          (data) {
        final photos = data["results"] as List?;
        if (photos == null || photos.isEmpty) {
          return Result.ok(<String>[]);
        }
        return Result.ok(
            photos.map((p) => p["urls"]["regular"] as String).toList()
        );
      },
    );
  }
}
