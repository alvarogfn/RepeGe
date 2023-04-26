T? ifProp<T>(bool prop, T toRender) {
  if (prop) {
    return toRender;
  } else {
    return null;
  }
}

T? ifPropElse<T>(bool prop, T toRender, T toRenderElse) {
  if (prop) {
    return toRender;
  } else {
    return toRenderElse;
  }
}
