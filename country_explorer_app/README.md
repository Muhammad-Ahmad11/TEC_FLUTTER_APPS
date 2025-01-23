# Country Explorer App (Flutter)

This Flutter app allows users to explore countries, search and filter through them, and compare countries side-by-side. It uses GetX for state management, Google Maps Flutter for map integration, and local persistence with Hive or SQLite for storing favorite countries.

## Features:

### 1. **Main Screen**
- **Fetch Country Data:** Retrieves country information using the `http` package from the [RestCountries API](https://restcountries.com/).
- **Search & Filter:** Allows users to filter and search countries based on various parameters.
- **Save Favorite Countries:** Users can save their favorite countries locally using Hive or SQLite for persistence.

### 2. **Details Screen**
- **Google Maps Integration:** Displays a map showing the selected country using `Google Maps Flutter`.
- **Country Comparison:** Compares countries side-by-side with an advanced UI, showcasing details such as population, area, and other stats.

## Topics Covered:
- **Google Maps:** Integration of maps to display country locations.
- **GetX:** Efficient state management for UI updates and API calls.
- **Advanced Filtering:** Advanced search and filtering functionality to sort countries by different criteria.
- **Local Persistence:** Storing favorite countries with Hive or SQLite.
