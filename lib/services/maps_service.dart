import 'package:dio/dio.dart';
import 'package:latlong2/latlong.dart' as latLng;

class MapService {
  static Future<String> fetchAddressFromPoint(latLng.LatLng point) async {
    String address = "";
    try {
      Dio dio = Dio();
      String url =
          "https://maps.googleapis.com/maps/api/geocode/json?latlng=${point.latitude},${point.longitude}&key=AIzaSyApm82MFXMcROWrHaGTj-auUcyOYQwBwsE";
      Response response = await dio.get(url);
      if (response.statusCode == 200) {
        Map data = response.data;
        if (data["status"] == "OK") {
          if (data["results"].length > 0) {
            String addressFromApi;
            Map firstResult = data["results"][0];
            addressFromApi = firstResult["formatted_address"];
            address = addressFromApi
                .split(",")
                .map((x) => x.trim())
                .where((element) => element.isNotEmpty)
                .toList()[0];
          }
        } else {
          return data["error_message"];
        }
      } else {
        return "error while fetching geo coding data";
      }
      return address;
    } on Exception {
      rethrow;
    }
  }
}
