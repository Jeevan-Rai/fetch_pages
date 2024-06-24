# fetch_pages

A Flutter package that leverages `json_dynamic_widget` to dynamically render pages from JSON data. This package fetches all the pages from a server when the app launches and provides a function to get a specific page by its name. It also caches the fetched data using `SharedPreferences`.

## Features

- Fetch pages from a server and store them locally.
- Retrieve and render pages dynamically using `json_dynamic_widget`.
- Cache the fetched data for offline usage.
- Simple API to get a page by its name.
- Display a loading indicator while the page data is being fetched.
- Handle page-specific data via the `RenderPage` widget.

## Getting started

### Prerequisites

- Flutter SDK
- `http` package
- `logger` package
- `shared_preferences` package
- `json_dynamic_widget` package

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

### API Response Format

The API should return JSON in the following format:

```json
{
  "pageName1": { /* page_json */ },
  "pageName2": { /* page_json */ },
  // more pages...
}
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

### Rendering a Page

To render a page using the `RenderPage` widget, ensure your map format is as follows:

```json
{
  "pageName": "pagename",
  "data": {
    "key": "value",
    // more key-value pairs...
  }
}
```

Here's an example of how to use the `RenderPage` widget with your page data:

```dart
import 'package:fetch_pages/fetch_pages.dart';
import 'package:flutter/material.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FetchPages.fetchPagesFromAPI("http://your-api-url.com/pages");
  JsonWidgetRegistry registry = JsonWidgetRegistry.instance;
  registry.navigatorKey = navigatorKey;

  // you can define custom widgets and registry functions here.

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Render Page",
      initialRoute: '/home',
      routes: {
        '/home': (context) =>
            const RenderPage(pageData: {"pageName": "index.json"}, registry), 
            /* 
              you can also add page data that is to be added to registry, 
                example: 
                  {
                    "pageName": "index.json", 
                    "data": {
                      "title":"Hello there", 
                      ... 
                    }
                  }
            */
      },
      navigatorKey: navigatorKey,
    );
  }
}
```

### JSON Format for `json_dynamic_widget`

For detailed examples and documentation on the JSON format supported by `json_dynamic_widget`, refer to the [json_dynamic_widget repository](https://github.com/peiffer-innovations/json_dynamic_widget/tree/main/json_dynamic_widget).

## Additional information

For more information on how to use `json_dynamic_widget` to render the pages, refer to its [documentation](https://pub.dev/packages/json_dynamic_widget).

### Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, please open an issue or create a pull request.

### Issues

If you encounter any problems or have questions, please file an issue on the [GitHub repository](https://github.com/Jeevan-Rai/fetch_pages/issues).

---

This README provides a clear overview of the package, including its purpose, features, prerequisites, and usage. It also includes an example to help users get started quickly. The additional information about the API response format ensures that users know how the server should respond with page data.
```