

class UserApiService {
    static final UserApiService _userApiService = UserApiService._internal();
  UserApiService._internal();

  factory UserApiService() {
    return _userApiService;
  }

    Future<User> updateUserName(String? name) async {
        String endpoint = ApiPath().getUserPath();

        Object params = {'name': name};

        final httpResponse = await ApiSerivce().patch(endpoint, params);

        User user = User.fromObject(httpResponse);

        return user;
    }


  Future<User?> uploadProfileImage(File file) async {
    String endpoint = ApiPath().getUpdateProfileImagePath();

    final httpResponse = await ApiSerivce().upload(endpoint, file);

    User user = User.fromObject(httpResponse);
    
    return user;
  }

}