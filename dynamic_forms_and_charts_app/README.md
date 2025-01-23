# Dynamic Forms and Charts (Flutter)

This Flutter app demonstrates how to create dynamic forms with validation, save the data to SQLite, and visualize the data using charts. It uses the `Provider` package for state management and `fl_chart` for rendering bar and pie charts with real-time updates.

## Features:

### 1. **State Management**
- **Provider** is used to manage the state of dynamic forms and charts.

### 2. **Dynamic Fields Screen**
- Allows users to dynamically add form fields (up to 5 fields).
- **Validation:** Ensures that the input is valid before saving the data.
- **SQLite:** Saves the form data in an SQLite database for persistent storage.

### 3. **Chart Screen**
- **Data Visualization:** Displays the saved data from SQLite as **bar** and **pie** charts using the `fl_chart` package.
- **Real-Time Updates:** Charts update in real-time as the underlying data changes.

## Topics Covered:
- **Data Visualization:** Creating bar and pie charts to represent data.
- **SQLite:** Storing and retrieving data in a local SQLite database.
- **Provider:** Managing the state of dynamic form fields and charts.
