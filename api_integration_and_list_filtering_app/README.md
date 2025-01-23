# API Integration and List Filtering (Flutter)

This Flutter app demonstrates how to integrate an API to fetch user data, display it with pagination and search functionality, and manage UI updates using GetX. It also includes error handling and retry functionality for failed API calls.

## Features:

### 1. **Main Screen**
- **Fetch User Data:** Uses `Dio` to make API calls and fetch a list of user data.
- **Display List:** Shows user data with avatars and includes a search functionality to filter the list.
- **Pagination:** Implements pagination for better performance when dealing with large datasets.
- **Loading, Success, and Error States:** Displays appropriate UI states (loading, success, error) based on the API call's result using GetX.

### 2. **Error Handling**
- **Retry Button:** If an API call fails, a retry button is displayed to attempt the request again.

## Topics Covered:
- **Dio:** A powerful HTTP client for making API calls and handling responses.
- **GetX:** A state management solution to update the UI reactively and manage API call states.
- **Pagination:** Efficiently load and display large sets of data in chunks.
- **Error Handling:** Gracefully handle API errors with retry functionality.