library kafka.test.api.produce;

import 'package:test/test.dart';
import 'package:kafka/kafka.dart';
import '../setup.dart';

String _topicName = 'dartKafkaTest';
KafkaClient _client;
ProduceRequest _request;

void main() {
  setUp(() async {
    var ip = await getDefaultHost();
    var host = new KafkaHost(ip, 9092);
    _client = new KafkaClient([host]);
    var metadata = await _client.getMetadata();
    var leaderId = metadata.getTopicMetadata(_topicName).getPartition(0).leader;
    var broker = metadata.brokers.firstWhere((b) => b.nodeId == leaderId);
    var leaderHost = new KafkaHost(broker.host, broker.port);
    _request = new ProduceRequest(_client, leaderHost, 1, 1000);
  });

  test('it publishes messages to Kafka topic', () async {
    _request.addMessages(_topicName, 0, ['hello world']);
    var response = await _request.send();
    expect(response.topics, hasLength(1));
    expect(response.topics.first.topicName, equals(_topicName));
    expect(response.topics.first.partitions.first.errorCode, equals(0));
    expect(
        response.topics.first.partitions.first.offset, greaterThanOrEqualTo(0));
  });
}
