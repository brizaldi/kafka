library kafka.common.errors.test;

import 'package:test/test.dart';
import 'package:kafka/common.dart';

void main() {
  group('KafkaServerError:', () {
    test('it handles error codes correctly', () {
      expect(KafkaServerError(0).isNoError, isTrue);
      expect(KafkaServerError(-1).isUnknown, isTrue);
      expect(KafkaServerError(-1).isError, isTrue);
      expect(KafkaServerError(1).isOffsetOutOfRange, isTrue);
      expect(KafkaServerError(2).isInvalidMessage, isTrue);
      expect(KafkaServerError(3).isUnknownTopicOrPartition, isTrue);
      expect(KafkaServerError(4).isInvalidMessageSize, isTrue);
      expect(KafkaServerError(5).isLeaderNotAvailable, isTrue);
      expect(KafkaServerError(6).isNotLeaderForPartition, isTrue);
      expect(KafkaServerError(7).isRequestTimedOut, isTrue);
      expect(KafkaServerError(8).isBrokerNotAvailable, isTrue);
      expect(KafkaServerError(9).isReplicaNotAvailable, isTrue);
      expect(KafkaServerError(10).isMessageSizeTooLarge, isTrue);
      expect(KafkaServerError(11).isStaleControllerEpoch, isTrue);
      expect(KafkaServerError(12).isOffsetMetadataTooLarge, isTrue);
      expect(KafkaServerError(14).isOffsetsLoadInProgress, isTrue);
      expect(KafkaServerError(15).isConsumerCoordinatorNotAvailable, isTrue);
      expect(KafkaServerError(16).isNotCoordinatorForConsumer, isTrue);
    });

    test('it can be converted to string', () {
      expect(KafkaServerError(0).toString(), 'KafkaServerError: NoError(0)');
    });

    test('it provides error message', () {
      expect(KafkaServerError(1).message, 'OffsetOutOfRange');
    });
  });
}
