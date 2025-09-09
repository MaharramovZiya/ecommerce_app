import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:injectable/injectable.dart';
import '../../core/error/exceptions.dart';
import '../../core/utils/logger.dart';
import '../models/product_model.dart';

abstract class ProductDataSource {
  Future<List<ProductModel>> getProducts({
    int page = 1,
    int limit = 20,
    String? category,
    String? search,
    String? sortBy,
    bool? isFeatured,
    bool? isOnSale,
  });
  Future<ProductModel> getProductById(String id);
  Future<List<ProductModel>> getFeaturedProducts();
  Future<List<ProductModel>> getNewProducts();
  Future<List<ProductModel>> getOnSaleProducts();
  Future<List<String>> getCategories();
  Future<List<ProductModel>> searchProducts(String query);
}

@injectable
class ProductDataSourceImpl implements ProductDataSource {
  final SupabaseClient _supabaseClient;

  ProductDataSourceImpl({required SupabaseClient supabaseClient})
      : _supabaseClient = supabaseClient;

  @override
  Future<List<ProductModel>> getProducts({
    int page = 1,
    int limit = 20,
    String? category,
    String? search,
    String? sortBy,
    bool? isFeatured,
    bool? isOnSale,
  }) async {
    try {
      AppLogger.info('Fetching products - page: $page, limit: $limit, category: $category');
      
      dynamic query = _supabaseClient
          .from('products')
          .select('*');

      // Apply filters
      if (category != null && category.isNotEmpty) {
        query = query.eq('category', category);
      }

      if (search != null && search.isNotEmpty) {
        query = query.or('name.ilike.%$search%,description.ilike.%$search%');
      }

      if (isFeatured != null) {
        query = query.eq('isFeatured', isFeatured);
      }

      if (isOnSale != null) {
        query = query.eq('isOnSale', isOnSale);
      }

      // Apply sorting
      if (sortBy != null) {
        switch (sortBy) {
          case 'price_asc':
            query = query.order('price', ascending: true);
            break;
          case 'price_desc':
            query = query.order('price', ascending: false);
            break;
          case 'name_asc':
            query = query.order('name', ascending: true);
            break;
          case 'name_desc':
            query = query.order('name', ascending: false);
            break;
          case 'rating_desc':
            query = query.order('rating', ascending: false);
            break;
          case 'newest':
            query = query.order('createdAt', ascending: false);
            break;
          default:
            query = query.order('createdAt', ascending: false);
        }
      } else {
        query = query.order('createdAt', ascending: false);
      }

      // Apply pagination after filters and sorting
      query = query.range((page - 1) * limit, page * limit - 1);

      final response = await query;
      final products = (response as List)
          .map((json) => ProductModel.fromJson(json))
          .toList();

      AppLogger.info('Fetched ${products.length} products');
      return products;
    } catch (e) {
      AppLogger.error('Get products error: $e');
      throw ServerException(message: 'Failed to fetch products: ${e.toString()}');
    }
  }

  @override
  Future<ProductModel> getProductById(String id) async {
    try {
      AppLogger.info('Fetching product by id: $id');
      
      final response = await _supabaseClient
          .from('products')
          .select('*')
          .eq('id', id)
          .single();

      final product = ProductModel.fromJson(response);
      AppLogger.info('Product fetched successfully: ${product.name}');
      
      return product;
    } catch (e) {
      AppLogger.error('Get product by id error: $e');
      throw DataNotFoundException(message: 'Product not found: ${e.toString()}');
    }
  }

  @override
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      AppLogger.info('Fetching featured products');
      
      final response = await _supabaseClient
          .from('products')
          .select('*')
          .eq('isFeatured', true)
          .order('createdAt', ascending: false)
          .limit(10);

      final products = (response as List)
          .map((json) => ProductModel.fromJson(json))
          .toList();

      AppLogger.info('Fetched ${products.length} featured products');
      return products;
    } catch (e) {
      AppLogger.error('Get featured products error: $e');
      throw ServerException(message: 'Failed to fetch featured products: ${e.toString()}');
    }
  }

  @override
  Future<List<ProductModel>> getNewProducts() async {
    try {
      AppLogger.info('Fetching new products');
      
      final response = await _supabaseClient
          .from('products')
          .select('*')
          .eq('isNew', true)
          .order('createdAt', ascending: false)
          .limit(10);

      final products = (response as List)
          .map((json) => ProductModel.fromJson(json))
          .toList();

      AppLogger.info('Fetched ${products.length} new products');
      return products;
    } catch (e) {
      AppLogger.error('Get new products error: $e');
      throw ServerException(message: 'Failed to fetch new products: ${e.toString()}');
    }
  }

  @override
  Future<List<ProductModel>> getOnSaleProducts() async {
    try {
      AppLogger.info('Fetching on sale products');
      
      final response = await _supabaseClient
          .from('products')
          .select('*')
          .eq('isOnSale', true)
          .order('createdAt', ascending: false)
          .limit(10);

      final products = (response as List)
          .map((json) => ProductModel.fromJson(json))
          .toList();

      AppLogger.info('Fetched ${products.length} on sale products');
      return products;
    } catch (e) {
      AppLogger.error('Get on sale products error: $e');
      throw ServerException(message: 'Failed to fetch on sale products: ${e.toString()}');
    }
  }

  @override
  Future<List<String>> getCategories() async {
    try {
      AppLogger.info('Fetching categories');
      
      final response = await _supabaseClient
          .from('products')
          .select('category')
          .order('category');

      final categories = (response as List)
          .map((json) => json['category'] as String)
          .toSet()
          .toList();

      AppLogger.info('Fetched ${categories.length} categories');
      return categories;
    } catch (e) {
      AppLogger.error('Get categories error: $e');
      throw ServerException(message: 'Failed to fetch categories: ${e.toString()}');
    }
  }

  @override
  Future<List<ProductModel>> searchProducts(String query) async {
    try {
      AppLogger.info('Searching products with query: $query');
      
      final response = await _supabaseClient
          .from('products')
          .select('*')
          .or('name.ilike.%$query%,description.ilike.%$query%,brand.ilike.%$query%')
          .order('createdAt', ascending: false)
          .limit(20);

      final products = (response as List)
          .map((json) => ProductModel.fromJson(json))
          .toList();

      AppLogger.info('Found ${products.length} products for query: $query');
      return products;
    } catch (e) {
      AppLogger.error('Search products error: $e');
      throw ServerException(message: 'Failed to search products: ${e.toString()}');
    }
  }
}
