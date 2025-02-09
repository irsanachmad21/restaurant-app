import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app_api/data/model/restaurant_detail_model.dart';
import 'package:restaurant_app_api/data/model/restaurant_list_model.dart';

void main() {
  group('Unit Testing', () {
    var testRestaurant = {
      "id": "rqdv5juczeskfw1e867",
      "name": "Melting Pot",
      "description":
          "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
      "pictureId": "14",
      "city": "Medan",
      "rating": 4.2,
    };

    test("1. Test Parsing RestaurantListModel dari JSON", () {
      var result = RestaurantListModel.fromJson(testRestaurant);
      expect(result.id, "rqdv5juczeskfw1e867");
      expect(result.name, "Melting Pot");
      expect(result.description,
          "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.");
      expect(result.pictureId, "14");
      expect(result.city, "Medan");
      expect(result.rating, 4.2);
    });

    test('2. Test Encoding RestaurantDetailModel ke JSON', () {
      final restaurant = RestaurantDetailModel(
        id: "vfsqv0t48jkfw1e867",
        name: "Gigitan Makro",
        description: "A test description",
        city: "Test City",
        address:
            "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
        pictureId: "04",
        categories: [Category(name: "Bali")],
        menus: Menu(
            foods: [Category(name: "Paket rosemary")],
            drinks: [Category(name: "Air")]),
        rating: 4.9,
        customerReviews: [
          CustomerReview(
              name: "Buchori",
              review: "Saya sangat suka menu malamnya!",
              date: "2019-07-01")
        ],
      );

      final jsonMap = restaurant.toJson();

      expect(jsonMap, {
        "id": "vfsqv0t48jkfw1e867",
        "name": "Gigitan Makro",
        "description": "A test description",
        "city": "Test City",
        "address":
            "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
        "pictureId": "04",
        "categories": [
          {"name": "Bali"}
        ],
        "menus": {
          "foods": [
            {"name": "Paket rosemary"}
          ],
          "drinks": [
            {"name": "Air"}
          ]
        },
        "rating": 4.9,
        "customerReviews": [
          {
            "name": "Buchori",
            "review": "Saya sangat suka menu malamnya!",
            "date": "2019-07-01"
          }
        ],
      });
    });
  });
}
