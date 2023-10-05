import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mqtt5_client/mqtt5_client.dart';
import 'package:mqtt5_client/mqtt5_browser_client.dart';

class MQTT {
  static const ledTopic = 'iot/led';
  static const fanTopic = 'iot/fan';
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
        'EXAMPLE::Subscription confirmed for topic ${subscription.topic
            .rawTopic}');
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
