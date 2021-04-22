class Book {
  String bookId;
  String isbn;
  String bookName;
  String bookPrice;
  String author;
  String bookPub;
  String bookPubdate;
  String shifoujiechu;
  String counter;

  Book(this.bookId, this.isbn, this.bookName, this.bookPrice, this.author,
      this.bookPub, this.bookPubdate, this.shifoujiechu, this.counter);

  getName() {
    return this.bookName;
  }
}
