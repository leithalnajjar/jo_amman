enum OtpTypeEnum {
  signIn(1),
  register(2),
  forgetPassword(3);

  final int value;

  const OtpTypeEnum(this.value);
}
