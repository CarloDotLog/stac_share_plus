# stac_share_plus
![Pub Version](https://img.shields.io/pub/v/stac_share_plus)
[![Pub Likes](https://img.shields.io/pub/likes/stac_share_plus)](https://pub.dev/packages/stac_share_plus)
[![GitHub Stars](https://img.shields.io/github/stars/CarloDotLog/stac_share_plus?color=green)](https://github.com/CarloDotLog/stac_share_plus)
![GitHub License](https://img.shields.io/github/license/CarloDotLog/stac_share_plus)

A [Stac](https://pub.dev/packages/stac) ActionParser to share content with the compatible apps on the device.
It uses the [share_plus](https://pub.dev/packages/share_plus) plugin.

## Getting started

Add this package to your yaml file

```yaml
stac_share_plus: 0.0.1
```

or exec this command:

```bash
flutter pub add stac_share_plus
```

## Usage

Import the package in your dart file:

```dart
import 'package:stac_share_plus/stac_share_plus.dart';
```

Register the Action Parser: 

```dart
void main() async {
  await Stac.initialize(
    actionParsers: const [
      ShareActionParser(),
    ],
  );
  runApp(const MyApp());
}
```

## Share Action JSON

```json
{
  "actionType": "share",
  "data": {
    "text": "Shared text",
    "title": "Shared title",
    "subject": "Shared subject"
  }
}
```

## Share Action Properties

| Property | Type     | Description                                                           |
|----------|----------|-----------------------------------------------------------------------|
| text     | `String` | The text to share                                                     |
| title    | `String` | Used as share sheet title where supported                             |
| subject  | `String` | Used as email subject where supported (e.g. EXTRA_SUBJECT on Android) |
| uri      | `String` | Share a URI.                                                          |
