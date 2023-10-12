import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:iot_dashboard/resources/repo/DataRepo.dart';
import 'package:mqtt5_client/mqtt5_client.dart';
import 'package:mqtt5_client/mqtt5_browser_client.dart';

import '../model/DHT11Data.dart';

class MQTT {
  static const ledTopic = 'iot/led';
  static const fanTopic = 'iot/fan';
  static const dht11Topic = 'iot/dht';
  final client = MqttBrowserClient('ws://test.mosquitto.org', '');
  static MQTT? _instance;

  static MQTT get instance => _instance ??= MQTT._init();

  MQTT._init() {
    /// Set logging on if needed, defaults to off
    client.logging(on: false);

    /// If you intend to use a keep alive value in your connect message that is not the default(60s)
    /// you must set it here
    client.keepAlivePeriod = 20;

    /// The ws port for Mosquitto is 8080, for wss it is 8081
    client.port = 8080;

    /// Add the unsolicited disconnection callback
    client.onDisconnected = onDisconnected;

    /// Add the successful connection callback
    client.onConnected = onConnected;

    /// Add a subscribed callback, there is also an unsubscribed callback if you need it.
    /// You can add these before connection or change them dynamically after connection if
    /// you wish. There is also an onSubscribeFail callback for failed subscriptions, these
    /// can fail either because you have tried to subscribe to an invalid topic or the broker
    /// rejects the subscribe request.
    client.onSubscribed = onSubscribed;

    /// Set a ping received callback if needed, called whenever a ping response(pong) is received
    /// from the broker.
    client.pongCallback = pong;

    /// Create a connection message to use or use the default one. The default one sets the
    /// client identifier, any supplied username/password, the default keepalive interval(60s)
    /// and clean session, an example of a specific one below.
    final connMess = MqttConnectMessage()
        .withClientIdentifier('Mqtt_MyClientUniqueId')
        .startClean(); // Non persistent session for testing
    print('EXAMPLE::Mosquitto client connecting....');
    client.connectionMessage = connMess;

    /// Connect the client, any errors here are communicated by raising of the appropriate exception. Note
    /// in some circumstances the broker will just disconnect us, see the spec about this, we however will
    /// never send malformed messages.
    connect();
  }

  // init MQTT
  Future<void> connect() async {
    try {
      await client.connect();
      client.subscribe(dht11Topic, MqttQos.atLeastOnce);

      /// The client has a change notifier object(see the Observable class) which we then listen to to get
      /// notifications of published updates to each subscribed topic.
      client.updates.listen((List<MqttReceivedMessage<MqttMessage>> c) {
        final recMess = c[0].payload as MqttPublishMessage;
        final pt =
            MqttUtilities.bytesToStringAsString(recMess.payload.message!);

        /// The above may seem a little convoluted for users only interested in the
        /// payload, some users however may be interested in the received publish message,
        /// lets not constrain ourselves yet until the package has been in the wild
        /// for a while.
        /// The payload is a byte buffer, this will be specific to the topic
        print(
            'EXAMPLE::Change notification:: topic is <${c[0].topic}>, payload is <-- $pt -->');

        /// Indicate the notification is correct
        if (c[0].topic == dht11Topic) {
          print(pt);
          // json {"humid":null,"temp":null,"lux":1.137934968e-9,"seconds":1696539944}
          DataRepo.instance.setDHT11Data(DHT11Data.fromJson(jsonDecode(pt)));
        }
      });
    } on Exception catch (e) {
      print('EXAMPLE::client exception - $e');
      client.disconnect();
    }
  }

  bool get isConnected =>
      client.connectionStatus!.state == MqttConnectionState.connected;

  /// The subscribed callback
  void onSubscribed(MqttSubscription subscription) {
    print(
        'EXAMPLE::Subscription confirmed for topic ${subscription.topic.rawTopic}');
  }

  /// The unsolicited disconnect callback
  void onDisconnected() {
    print('EXAMPLE::OnDisconnected client callback - Client disconnection');
    if (client.connectionStatus!.disconnectionOrigin ==
        MqttDisconnectionOrigin.solicited) {
      print('EXAMPLE::OnDisconnected callback is solicited, this is correct');
    }
  }

  /// The successful connect callback
  void onConnected() {
    print(
        'EXAMPLE::OnConnected client callback - Client connection was sucessful');
  }

  /// Pong callback
  void pong() {
    print('EXAMPLE::Ping response client callback invoked');
  }

  void setLed(String message) {
    if (!isConnected) {
      // Show error message
      return;
    }
    final builder = MqttPayloadBuilder();
    builder.addString(message);
    client.publishMessage(ledTopic, MqttQos.exactlyOnce, builder.payload!);
  }

  void setFan(String message) {
    if (!isConnected) {
      // Show error message
      return;
    }
    final builder = MqttPayloadBuilder();
    builder.addString(message);
    client.publishMessage(fanTopic, MqttQos.exactlyOnce, builder.payload!);
  }
}
