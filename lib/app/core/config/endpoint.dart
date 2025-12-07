final class ApiPaths {
  ApiPaths._();
  static const String auth = '/auth/login';
  static const String me = '/auth/me';
  static const String refresh = '/auth/refresh';
  static const String products = '/products';
  static const String productCategories = '/products/category-list';
  static const String carts = '/carts';
  static const String users = '/users';
  static String singleProduct(int id) => '/products/$id';
  static String userCarts(int userId) => '/carts/user/$userId';
}