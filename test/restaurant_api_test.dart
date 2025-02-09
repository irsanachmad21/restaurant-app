import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_app_api/data/api/api_service.dart';
import 'package:restaurant_app_api/data/model/restaurant_list_model.dart';
import 'package:restaurant_app_api/data/model/restaurant_list_response.dart';
import 'package:restaurant_app_api/provider/home/restaurant_list_provider.dart';
import 'package:restaurant_app_api/static/restaurant_list_result_state.dart';

import 'restaurant_api_test.mocks.dart';

@GenerateMocks([ApiService])
void main() {
  group('Restaurant API Test', () {
    late RestaurantListProvider provider;
    late MockApiService mockApiService;

    setUp(() {
      mockApiService = MockApiService();
      provider = RestaurantListProvider(mockApiService);
    });

    test('1. Memastikan state awal provider harus didefinisikan', () {
      expect(provider.resultState, isA<RestaurantListNoneState>());
    });

    test(
        '2. Memastikan harus mengembalikan daftar restoran ketika pengambilan data API berhasil',
        () async {
      // Arrange
      final restaurantListResponse = RestaurantListResponse(
        error: false,
        message: '',
        count: 2,
        restaurants: [
          RestaurantListModel(
            id: 'rqdv5juczeskfw1e867',
            name: 'Melting Pot',
            description:
                'Lorem ipsum dolor sit amet, consectetuer adipiscing elit.',
            pictureId: '14',
            city: 'Medan',
            rating: 4.2,
          ),
          RestaurantListModel(
            id: 's1knt6za9kkfw1e867',
            name: 'Kafe Kita',
            description:
                'Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue.',
            pictureId: '25',
            city: 'Gorontalo',
            rating: 4.0,
          ),
        ],
      );

      when(mockApiService.getRestaurantList())
          .thenAnswer((_) async => restaurantListResponse);

      await provider.fetchRestaurantList();

      expect(provider.resultState, isA<RestaurantListLoadedState>());
      expect((provider.resultState as RestaurantListLoadedState).data,
          restaurantListResponse.restaurants);
    });

    test(
      '3. Memastikan harus mengembalikan kesalahan ketika pengambilan data API gagal',
      () async {
        when(mockApiService.getRestaurantList()).thenAnswer(
            (_) => Future.error(Exception('Failed to load restaurant list')));

        await provider.fetchRestaurantList();

        expect(provider.resultState, isA<RestaurantListErrorState>());
        expect((provider.resultState as RestaurantListErrorState).error,
            'Exception: Failed to load restaurant list');
      },
    );
  });
}
