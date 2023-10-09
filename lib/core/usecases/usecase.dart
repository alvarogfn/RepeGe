abstract class UsecaseWithParams<Type, Params> {
  const UsecaseWithParams();

  Type call(Params params);
}

abstract class UsecaseWithoutParams<Type> {
  const UsecaseWithoutParams();

  Type call();
}
