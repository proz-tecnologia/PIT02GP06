abstract class IHttpService {
  Future<dynamic> get({required String url});
  set({required String url, required dynamic data});
}
