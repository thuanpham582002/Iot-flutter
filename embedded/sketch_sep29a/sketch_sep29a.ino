#include <DHT.h>
#include <PubSubClient.h>
#include <ArduinoJson.h>
#include <ESP8266WiFi.h>
#include <NTPClient.h>
#include <WiFiUdp.h>


#define LED 4     //D2
#define FAN 5     //D1
#define DUS 14    //D5
#define DHTPIN 2  //D4
#define DHTTYPE DHT11
#define lightPort A0  // 32

DHT dht(DHTPIN, DHTTYPE);

// WiFi
//  const char *wifi_username = "Loc Phat";        // Enter your WiFi name
//  const char *wifi_password = "tailocphat2589";  // Enter WiFi password

const char *wifi_username = "iPhone15prm";       // Enter your WiFi name
const char *wifi_password = "01062002";  // Enter WiFi password
// MQTT Broker
const char *mqtt_broker = "test.mosquitto.org";
const int mqtt_port = 1883;

const char *topicLed = "iot/led";
const char *topicFan = "iot/fan";
const char *topicDus = "iot/dust";
const char *topicDht11 = "iot/dht";
WiFiClient espClient;
PubSubClient client(espClient);

bool isDusWarningEnable = false;
bool previousLedStatus = false;
bool previousFanStatus = false;
int dust = 0;
// Define NTP Client to get time
WiFiUDP ntpUDP;
NTPClient timeClient(ntpUDP, "pool.ntp.org");

// Variable to save current epoch time
unsigned long epochTime;

// Function that gets current epoch time
unsigned long getTime() {
    timeClient.update();
    unsigned long now = timeClient.getEpochTime();
    return now;
}

void connectWifi() {
    WiFi.begin(wifi_username, wifi_password);
    while (WiFi.status() != WL_CONNECTED) {
        delay(100);
        Serial.print(".");
    }
    Serial.println();
    Serial.print("Wifi Connected! as ");
    Serial.println(WiFi.localIP().toString());
}

void setLed(bool status) {
    if (status == true) {
        digitalWrite(LED, HIGH);  // Turn on the LED
        Serial.println("Turn on the led");
    } else {
        digitalWrite(LED, LOW);  // Turn off the LED
        Serial.println("Turn off the led");
    }
}


void setFan(bool status) {
    if (status == true) {
        digitalWrite(FAN, HIGH);  // Turn on the FAN
        Serial.println("Turn on the fan");
    } else {
        digitalWrite(FAN, LOW);  // Turn off the FAN
        Serial.println("Turn off the fan");
    }
}

void setDus(bool status) {
    if (status == true) {
        isDusWarningEnable = true;
        Serial.println("Turn on the dus");
    } else if (status == false) {
        isDusWarningEnable = false;
        setLed(previousLedStatus);
        setFan(previousFanStatus);
        Serial.println("Turn off the dus");
    }
}

void callback(char *topic, byte *payload, unsigned int length) {
    Serial.print("Message arrived in topic: ");
    Serial.println(topic);

    String message;
    for (int i = 0; i < length; i++) {
        message += (char) payload[i];
    }
    Serial.printf("Message: %s\n", message.c_str());

    if (strcmp(topic, topicLed) == 0) {
        previousLedStatus = message.equals("true");
        if (isDusWarningEnable != true)
            setLed(message.equals("true"));
    }
    if (strcmp(topic, topicFan) == 0) {
        previousFanStatus = message.equals("true");
        if (isDusWarningEnable != true)
            setFan(message.equals("true"));
    }

    if (strcmp(topic, topicDus) == 0) {
        setDus(message.equals("true"));
    }

    Serial.println("-----------------------");
}

void connectMqtt() {
    //connecting to a mqtt broker
    client.setServer(mqtt_broker, mqtt_port);
    client.setCallback(callback);

    while (!client.connected()) {
        String client_id = "esp8266-client-";
        client_id += String(WiFi.macAddress());

        Serial.printf("The client %s connects to mosquitto mqtt broker\n", client_id.c_str());

        if (client.connect(client_id.c_str())) {
            Serial.println("Public emqx mqtt broker connected");
        } else {
            Serial.print("failed with state ");
            Serial.print(client.state());
            delay(2000);
        }
    }
}

void registerTopicMqtt() {
    client.subscribe(topicLed);
    client.subscribe(topicFan);
    client.subscribe(topicDus);
}

char *jsonify(float humid, float temp, float lux) {
    DynamicJsonDocument doc(1024);
    doc["humidity"] = humid;
    doc["temperature"] = temp;
    doc["lux"] = lux;
    dust = random(101);
    if (isDusWarningEnable == true) {
        if (dust > 50) {
            digitalWrite(DUS, HIGH);  // Turn off the FAN
            setLed(true);
            setFan(true);
        } else {
            setLed(previousLedStatus);
            setFan(previousFanStatus);
            digitalWrite(DUS, LOW);  // Turn off the FAN
        }
    } else {
        digitalWrite(DUS, LOW);  //
    }

    doc["dust"] = dust;
    doc["time"] = getTime();

    char *json = new char[256];
    serializeJson(doc, json, 256);
    Serial.println(json);

    return json;
}


int lastMs = millis();

void readDht() {
    if (millis() - lastMs >= 1000) {
        lastMs = millis();
        float humidity = dht.readHumidity();
        float temperature = dht.readTemperature();
        float lux = analogRead(lightPort);
        client.publish(topicDht11, jsonify(humidity, temperature, lux));
    }
}

void setup() {
    Serial.begin(115200);
    connectWifi();
    timeClient.begin();
    pinMode(LED, OUTPUT);
    pinMode(FAN, OUTPUT);
    pinMode(DUS, OUTPUT);
    connectMqtt();
    registerTopicMqtt();

    randomSeed(getTime());
    // Khởi tạo cảm biến DHT11
    dht.begin();
}

void loop() {
    // wait server connected
    delay(1000);
    client.loop();
    readDht();
    delay(1000);
    if (isDusWarningEnable == true) {
        if (dust > 50) {
            digitalWrite(DUS, LOW);  // Turn off the FAN
            setLed(false);
            setFan(false);
        }
    }
}*