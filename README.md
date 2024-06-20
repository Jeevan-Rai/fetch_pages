# fetch_pages

A Flutter package that leverages `json_dynamic_widget` to dynamically render pages from JSON data. This package fetches all the pages from a server when the app launches and provides a function to get a specific page by its name. It also caches the fetched data using `SharedPreferences`.

## Features

- Fetch pages from a server and store them locally.
- Retrieve and render pages dynamically using `json_dynamic_widget`.
- Cache the fetched data for offline usage.
- Simple API to get a page by its name.

## Getting started

### Prerequisites

- Flutter SDK
- `http` package
- `logger` package
- `shared_preferences` package

Add the following dependencies to your `pubspec.yaml` file:

```yaml
dependencies:
  flutter:
    sdk: flutter
  http: ^0.13.3
  logger: ^1.0.0
  shared_preferences: ^2.0.6
  json_dynamic_widget: ^4.0.0
```

## Usage

### Fetching Pages from API

To fetch pages from the API and store them locally:

```dart
import 'package:fetch_pages/fetch_pages.dart';

void main() async {
  String apiUrl = 'https://your-api-url.com/pages';
  await FetchPages.fetchPagesFromAPI(apiUrl);
}
```

### Getting a Page by Name

To get a specific page by its name:

```dart
String? pageJson = await FetchPages.getPageByName('page_name');
if (pageJson != null) {
  // Use the pageJson to render the page using json_dynamic_widget
}
```

## Example

```dart
import 'package:flutter/material.dart';
import 'package:fetch_pages/fetch_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  String apiUrl = 'https://your-api-url.com/pages';
  await FetchPages.fetchPagesFromAPI(apiUrl);
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fetch Pages Example')),
      body: FutureBuilder<String?>(
        future: FetchPages.getPageByName('home'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            // Here you would use json_dynamic_widget to render the page
            return Center(child: Text('Page data: ${snapshot.data}'));
          } else {
            return Center(child: Text('Page not found'));
          }
        },
      ),
    );
  }
}
```

## Additional information

For more information on how to use `json_dynamic_widget` to render the pages, refer to its [documentation](https://pub.dev/packages/json_dynamic_widget).

### Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or create a pull request.

### Issues

If you encounter any problems or have questions, please file an issue on the [GitHub repository](https://github.com/Jeevan-Rai/fetch_pages/issues).

---

This README provides a clear overview of the package, including its purpose, features, prerequisites, and usage. It also includes an example to help users get started quickly.
