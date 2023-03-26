function tap<T>(x: T, fn: (x: T) => unknown = (x) => x): T {
  console.log(fn(x));
  return x;
}

tap("a") // a
tap("a", (x) => "console: " + x) // console: x