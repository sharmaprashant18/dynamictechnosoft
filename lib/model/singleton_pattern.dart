//Singleton class has only one instance and provides global point of access to it
//it saves memory because another instance is not needed

class SingleTonExample {
  static final SingleTonExample _instance = SingleTonExample._internal();
  factory SingleTonExample() {
    return _instance;
  }
  SingleTonExample._internal(); //private constructor

  final List<Map<String, String>> books = [
    {
      'imageUrl': 'assets/cheena.png',
      'name': 'Cheena Harayako Manchhe',
      'genre': 'Autobiography',
      'summary':
          'The storyline of Cheena Harayako Manchhe, is about a simple, god-fearing man who happens to lose his "China" or "Cheena" (horoscope). The autobiography depicts the author\'s childhood memories, fantasies and the struggles he had to face during his adolescent years. “The book is the tribute to my late wife Meera and proceeds from the book will go to a trust of her name,” said the author at a press meet',
      'rating': '⭐⭐⭐',
    },
    {
      'imageUrl': 'assets/summer.png',
      'name': 'Summer Love',
      'genre': 'Love Story',
      'summary':
          'Writer is on a cruise ship where he meets another Nepali person, Atit. As writer introduces himself, Atit asks the writer if he is willing to write Atit\'s love story. Reluctantly, the writer agrees to listen to his story. Atit is curious to find out the entrance topper Saaya, who also has the same way back to home as Atit has.',
      'rating': '⭐⭐⭐⭐',
    },
    {
      'imageUrl': 'assets/saaya.png',
      'name': 'Saaya',
      'genre': 'Romance',
      'summary':
          'It is the sequel of Summer Love. It is based on point of view of narrator, Atit, Saaya and Susmita. According to the story, narrator takes the responsibility to mend the things between Atit and Saaya. Two years after the book about Atit\'s love story is published, the writer comes in contact with Saaya to know her story.',
      'rating': '⭐⭐⭐',
    },
    {
      'imageUrl': 'assets/seto.png',
      'name': 'Seto Dharti',
      'genre': 'Fiction',
      'summary':
          'The story is based on the life of a girl named Tara. She is a simple girl living in her village spending her time playing with other children of same village. While the story goes on, she gets married at the age of seven, the very age at which she does not even understand the meaning of marriage. The story in the novel is of the time period 1850–1950',
      'rating': '⭐⭐⭐⭐⭐',
    },
  ];
}
