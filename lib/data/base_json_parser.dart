abstract class BaseJsonParser<T> {
  const BaseJsonParser();

  T parseFromJson(String json);
}
