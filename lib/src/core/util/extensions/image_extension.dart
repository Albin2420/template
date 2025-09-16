extension ImagePath on String {
  String get toPng => "assets/images/$this.png";
  String get toJpg => "assets/images/$this.jpg";
  String get toSvg => "assets/images/$this.svg";
  String get toJpeg => "assets/images/$this.jpeg";
}
