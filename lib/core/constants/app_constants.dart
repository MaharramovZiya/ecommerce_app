class AppConstants {
  // API
  static const String baseUrl = 'https://cdgvwiyofehmqywltery.supabase.co';
  static const String apiVersion = 'v1';
  static const Duration apiTimeout = Duration(seconds: 30);
  
  // Supabase
  static const String supabaseUrl = 'YOUR_SUPABASE_URL';
  static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';
  
  // Storage Keys
  static const String userTokenKey = 'user_token';
  static const String userDataKey = 'user_data';
  static const String themeKey = 'theme_mode';
  static const String languageKey = 'language';
  static const String cartKey = 'cart_items';
  
  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;
  
  // Validation
  static const int minPasswordLength = 6;
  static const int maxPasswordLength = 50;
  static const int maxNameLength = 50;
  static const int maxDescriptionLength = 500;
  
  // Image
  static const int maxImageSize = 5 * 1024 * 1024; // 5MB
  static const List<String> allowedImageTypes = ['jpg', 'jpeg', 'png', 'webp'];
  
  // Cache
  static const Duration cacheExpiration = Duration(hours: 24);
  static const Duration imageCacheExpiration = Duration(days: 7);
  
  // Animation Durations
  static const Duration shortAnimation = Duration(milliseconds: 200);
  static const Duration mediumAnimation = Duration(milliseconds: 300);
  static const Duration longAnimation = Duration(milliseconds: 500);
  
  // Debounce
  static const Duration searchDebounce = Duration(milliseconds: 500);
  static const Duration buttonDebounce = Duration(milliseconds: 300);
  
  // Retry
  static const int maxRetryAttempts = 3;
  static const Duration retryDelay = Duration(seconds: 2);
  
  // Product
  static const int maxQuantityPerItem = 99;
  static const int minQuantityPerItem = 1;
  
  // Order
  static const int maxOrderItems = 50;
  
  // Rating
  static const double minRating = 1.0;
  static const double maxRating = 5.0;
  
  // Currency
  static const String defaultCurrency = 'USD';
  static const String currencySymbol = '\$';
  
  // Date Format
  static const String dateFormat = 'yyyy-MM-dd';
  static const String dateTimeFormat = 'yyyy-MM-dd HH:mm:ss';
  static const String displayDateFormat = 'MMM dd, yyyy';
  static const String displayDateTimeFormat = 'MMM dd, yyyy HH:mm';
}
