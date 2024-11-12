# fetch_pages

A Flutter package that dynamically renders pages from JSON data using `json_dynamic_widget`. It efficiently fetches pages from a server, caches them with `SharedPreferences`, and includes a versioning mechanism to update pages only when needed.

## Features

- **Fetch Pages**: Fetch and cache JSON-formatted pages from a server for offline use.
- **Dynamic Rendering**: Pages are dynamically rendered using `json_dynamic_widget`.
- **Versioning**: Compare local and server versions of page data and update only if necessary.
- **Simple API**: Retrieve specific pages by name.
- **Offline Support**: Use cached data in `SharedPreferences` when offline.
- **Loading Indicator**: Displays a loading indicator while data is being fetched.

## Getting Started

### Prerequisites

Ensure the following dependencies are included in your `pubspec.yaml`:

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

The server should provide the following JSON structure for pages:

```json
{
  "pageName1": { /* page_json */ },
  "pageName2": { /* page_json */ },
  // more pages...
}
```

The versioning API should return the following JSON structure:

```json
{
  "version": "1.0",
  "folderName": "v1"
}
```

## Usage

### Fetching Pages with Versioning

This package allows you to fetch pages dynamically from the server. It first checks if the local version is up to date with the server’s version. If it’s outdated or doesn’t exist locally, it fetches new pages and stores them.

Example usage:

```dart
import 'package:fetch_pages/fetch_pages.dart';

void main() async {
  String apiUrl = 'https://your-api-url.com';
  String appVersion = '1.0'; // Version of the app, required to get the right folder

  await FetchPages.fetchPagesFromAPI(apiUrl, appVersion);
}
```

### Getting a Page by Name

Once the pages are fetched and stored, you can easily retrieve a specific page using its name:

```dart
String? pageJson = await FetchPages.getPageByName('homePage');
if (pageJson != null) {
  // Use the pageJson to render the page using json_dynamic_widget
}
```

### Rendering a Page

You can use the `RenderPage` widget to display pages dynamically. It fetches JSON data and renders the widget accordingly:

```dart
import 'package:fetch_pages/fetch_pages.dart';
import 'package:flutter/material.dart';
import 'package:json_dynamic_widget/json_dynamic_widget.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FetchPages.fetchPagesFromAPI("https://your-api-url.com", "1.0");
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
        '/home': (context) => const RenderPage(pageData: {"pageName": "homePage"}, registry),
      },
      navigatorKey: navigatorKey,
    );
  }
}
```

### Versioning System

When the package is initialized, it checks if `versionConfig.json` exists in `SharedPreferences`. If present, it compares the local version with the server version:

- **If outdated**: Pages are fetched from the server and the local cache is updated.
- **If up-to-date**: The cached data is used, skipping network requests.

### JSON Format for `json_dynamic_widget`

The JSON format should be compatible with the `json_dynamic_widget` package. For detailed documentation on the supported JSON structure, refer to the [json_dynamic_widget documentation](https://pub.dev/packages/json_dynamic_widget).

### Example Folder Structure for API

- **Version Mapping**: `https://your-api-url.com/version-mapping/1.0` (returns the version info and folder name)
- **Pages**: `https://your-api-url.com/pages/v1` (returns the JSON data for the pages based on folder name)

## Additional Information

For contributions, suggestions, or issues, feel free to open an issue or create a pull request on the [GitHub repository](https://github.com/Jeevan-Rai/fetch_pages/issues).