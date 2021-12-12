type validationFunction = (A: string) => boolean | string;

export function isEmpty(
  message = "Pole nie może być puste."
): validationFunction {
  return (value) => !!value.length || message;
}

export function isEmail(
  message = "Pole musi zawierać poporawny email"
): validationFunction {
  const mailFormat = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

  return (value) => mailFormat.test(value) || message;
}

export function isValidPassword(
  value: string,
  message = "Hasło musi składać się z conajmniej 6 znaków."
): validationFunction {
  return (value) => value.length >= 6 || message;
}

export function isSame(
  compareValue: string,
  message = "Wartoście w obu polach muszą być równe"
): validationFunction {
  return (value) => value === compareValue || message;
}
