### 0.0.1

* A Flutter package that leverages `json_dynamic_widget` to dynamically render pages from JSON data. This package fetches all the pages from a server when the app launches and provides a function to get a specific page by its name. It also caches the fetched data using `SharedPreferences`.

### 0.0.2

* Included required API response format.

### 0.1.0

* Added `RenderPage` widget to dynamically render JSON data with support for loading indicators and error handling.

### 0.1.2

* Bug fix - resolved conflicts by multiple registry creation.

### 1.0.0

* Introduced versioning system to minimize unnecessary API requests.
* Added version check before fetching pages, comparing local and server `versionConfig.json`.
* Updated Express API route for serving `versionConfig.json`.
* Optimized caching using `SharedPreferences` to store versioning data and page responses.