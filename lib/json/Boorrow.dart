class Borrow {
  final String id;
  final String user;
  final String bookId;
  final String borrowedTime;
  final String returnTime;
  final String name;
  final String statue;
  String statusString;
  Borrow(
    this.user,
    this.bookId,
    this.borrowedTime,
    this.returnTime,
    this.statue,
    this.id,
    this.name,
  ) {
    DateTime date1 = DateTime.parse(this.borrowedTime);
    DateTime date2 = DateTime.parse(this.returnTime);
    if (this.statue == "0") {
      this.statusString = "审核中";
    } else if (this.statue == "1") {
      this.statusString = "审核通过，可以取书";
    } else if (this.statue == "2") {
      if (date1.isBefore(date2)) {
        this.statusString = "已取书，未归还";
      } else {
        this.statusString = "已取书，超时未归";
      }
    } else {
      this.statusString = "已归还";
    }
  }
}
