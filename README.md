# E-Commerce Shop App

A Flutter e-commerce application that fetches product data from the Fake Store API and displays it in a clean, modern UI.

## Features

- **UI Implementation**:
  - Recreated the provided e-commerce home page UI design
  - Header with app logo/title and search bar
  - Product grid with images, titles, and prices
  - Promotional banner
  - Popular Products section

- **API Integration**:
  - Fetch data from https://fakestoreapi.com/products
  - Filter products by name using search functionality

- **Skeleton Screen**:
  - Implemented skeleton loading screen for product grid
  - Smooth transition between loading and loaded states

- **Additional Features**:
  - Pull-to-refresh functionality
  - Error handling with retry option
  - Infinite scroll pagination
  - Responsive design for various device sizes

## Architecture

This project is built using Clean Architecture principles with BLoC pattern for state management:

- **Domain Layer**: Contains business logic with entities, repositories, and use cases
- **Data Layer**: Implements repositories, data sources, and models
- **Presentation Layer**: Contains UI components, screens, and BLoC state management

## Setup and Installation

1. **Clone the repository**:
   ```
   git clone [repository-url]
   ```

2. **Navigate to the project directory**:
   ```
   cd ecommerce_shop_app
   ```

3. **Install dependencies**:
   ```
   flutter pub get
   ```

4. **Run the app**:
   ```
   flutter run
   ```

## Dependencies

- **http**: For API calls
- **flutter_bloc**: For state management
- **equatable**: For value equality comparison
- **dartz**: For functional programming and Either type
- **shimmer**: For skeleton loading animation
