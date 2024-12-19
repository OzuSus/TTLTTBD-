class ApiUrl {
  //USER
  static const getAllUsers = 'http://localhost:8080/api/users';
  static const logIn = 'http://localhost:8080/api/users/login?username=user1&password=password1';
  static const register = 'http://localhost:8080/api/users/register';
  static const getUserById = 'http://localhost:8080/api/users/id?id=2';
  static const updateUserInfoAccount = 'http://localhost:8080/api/users/updateInfoAccount';
  static const updateUserAvata = 'http://localhost:8080/api/users/updateAvata';

  //CATEGORY
  static const getAllCategories = 'http://localhost:8080/api/categories';
  static const getCategoryById = 'http://localhost:8080/api/categories/id?id=4';

  //PRODUCT
  static const getAllProducts = 'http://localhost:8080/api/products';
  static const getProductById = 'http://localhost:8080/api/products/id?id=10';
  static const getAllProductInFavoriteListByUserId = 'http://localhost:8080/api/favorites/user/2';

  //FAVORITE
  static const addFavoriteProduct = 'http://localhost:8080/api/favorites/add?userId=3&productId=8';
  static const deleteFavoriteProduct = 'http://localhost:8080/api/favorites/delete?userId=3&productId=8';

  //FILEUPLOAD
  static const getFileUpload = 'http://localhost:8080/uploads/21360cd9-4941-47ef-a57b-8cf7d75cfda8_godzulaThum.jpg';




}