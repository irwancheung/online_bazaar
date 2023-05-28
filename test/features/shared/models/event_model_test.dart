import 'package:flutter_test/flutter_test.dart';
import 'package:online_bazaar/features/shared/data/models/event_model.dart';
import 'package:online_bazaar/features/shared/domain/entities/event.dart';

void main() {
  group('EventModel', () {
    test('should be a subclass of Event entity.', () {
      // Arrange
      final tEventModel = EventModel(
        id: 'id',
        title: 'title',
        pickupNote: 'pickupNote',
        startAt: DateTime.utc(0),
        endAt: DateTime.utc(0),
      );

      // assert
      expect(tEventModel, isA<Event>());
    });
  });
}
