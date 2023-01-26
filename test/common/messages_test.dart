library kafka.common.messages.test;

import 'package:test/test.dart';
import 'package:kafka/common.dart';

void main() {
  group('Messages:', () {
    test(
        'compression can not be set on individual messages in produce envelope',
        () {
      expect(() {
        ProduceEnvelope('test', 0, [
          Message([1], attributes: MessageAttributes(KafkaCompression.gzip))
        ]);
      }, throwsStateError);
    });
  });

  group('MessageAttributes:', () {
    test('get compression from int', () {
      expect(KafkaCompression.none, MessageAttributes.getCompression(0));
      expect(KafkaCompression.gzip, MessageAttributes.getCompression(1));
      expect(KafkaCompression.snappy, MessageAttributes.getCompression(2));
    });

    test('convert to int', () {
      expect(MessageAttributes(KafkaCompression.none).toInt(), equals(0));
      expect(MessageAttributes(KafkaCompression.gzip).toInt(), equals(1));
      expect(MessageAttributes(KafkaCompression.snappy).toInt(), equals(2));
    });
  });
}
