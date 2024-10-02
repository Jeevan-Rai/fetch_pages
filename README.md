# fetch_pages

A Flutter package that leverages `json_dynamic_widget` to dynamically render pages from JSON data. This package fetches pages from a server, caches them using `SharedPreferences`, and includes a versioning mechanism to optimize the fetching process by avoiding unnecessary requests when the local data is up-to-date.

## Features

- Fetch and cache pages from a server for offline use.
- Dynamically render pages using `json_dynamic_widget`.
- Versioning system to check and fetch updated pages only when necessary.
- Simple API to retrieve specific pages by name.
- Loading indicator while page data is being fetched.
- Offline support using cached data from `SharedPreferences`.

## Getting Started

### Prerequisites

- Flutter SDK
- Required packages: `http`, `logger`, `shared_preferences`, `json_dynamic_widget`

Add the following dependencies to your `pubspec.yaml`:

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

The versioning API should return the following JSON:

```json
{
  "version": "1.0"
}
```

## Usage

### Fetching Pages with Versioning

To fetch pages from the API and store them locally, taking advantage of the versioning system:

```dart
import 'package:fetch_pages/fetch_pages.dart';

void main() async {
  String apiUrl = 'https://your-api-url.com/pages/MyBT';
  String versionCheckUrl = 'https://your-api-url.com/version-config';
  
  await FetchPages.fetchPagesFromAPI(apiUrl, versionCheckUrl);
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

To render a page using the `RenderPage` widget, ensure your page data is formatted correctly:

```dart
import 'package:fetch_pages/fetch_pages.dart';
import 'package:flutter/material.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FetchPages.fetchPagesFromAPI("https://your-api-url.com/pages/MyBT", "https://your-api-url.com/version-config");
  JsonWidgetRegistry registry = JsonWidgetRegistry.instance;
  registry.navigatorKey = navigatorKey;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Render Page",
      initialRoute: '/home',
      routes: {
        '/home': (context) => const RenderPage(pageData: {"pageName": "homePage.json"}, registry),
      },
      navigatorKey: navigatorKey,
    );
  }
}
```

### Versioning

When the package is initialized, it will check if a `versionConfig.json` file exists in `SharedPreferences`. If found, it will compare the local version with the version from the server:

- If the local version is outdated, the package fetches all pages and updates the local cache.
- If the versions match, it skips fetching the pages and uses the cached data.

### JSON Format for `json_dynamic_widget`

For detailed examples and documentation on the JSON format supported by `json_dynamic_widget`, refer to the [json_dynamic_widget documentation](https://pub.dev/packages/json_dynamic_widget).

## Additional Information

For contributions, suggestions, or issues, feel free to open an issue or create a pull request on the [GitHub repository](https://github.com/Jeevan-Rai/fetch_pages/issues).