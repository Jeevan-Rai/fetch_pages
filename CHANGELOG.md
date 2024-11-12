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

### 1.0.1

* Bug fix - resolved issue in getting page from cache.

### 1.0.2

* Bug fix - can use `x.x.x` versioning format in `versionConfig.json`.

### 1.1.0

* Added support for version-mapping based on appVersion.
* Enhanced versioning flow by using `version-mapping` endpoint to fetch version-specific folder names for page fetching.
* Updated API routes to fetch pages based on folder names tied to app versions.

### 1.1.1

* Bug fix - resolved issue in fetching version-mapping on some servers.

### 1.2.0

* Added support for folder-based page fetching using directory structure to improve scalability.
* Optimized JSON parsing and caching logic for large datasets.

### 1.2.1

* Bug fix - resolved issue in fetching pages while there is no local versioning