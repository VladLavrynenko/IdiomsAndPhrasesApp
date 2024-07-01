enum ScreensModes {
  TOP10('Top-10 Idioms'),
  OTHERS('Other Idioms'),
  FAV('Your favourite Idioms'),
  ALL('All Idioms');

  final String title;
  const ScreensModes(this.title);
}

//visible: 100%, 60%, 30% of the content
enum LearnModes {
  VISIBLE(1),
  VISIBLE60(0.6),
  VISIBLE30(0.3);

  final double coefficient;
  const LearnModes(this.coefficient);
}