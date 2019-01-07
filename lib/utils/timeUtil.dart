///create by elileo on 2018/12/18
String getTimestampString(timeStamp) {
  DateTime date = new DateTime.fromMillisecondsSinceEpoch(timeStamp);
  DateTime curDate = new DateTime.now();
  Duration diff = curDate.difference(date);
  if (diff.inDays > 0) {
    return diff.inDays.toString() + "天前";
  } else if (diff.inHours > 0) {
    return diff.inHours.toString() + "小时前";
  } else if (diff.inMinutes > 0) {
    return diff.inMinutes.toString() + "分钟前";
  } else if (diff.inSeconds > 0) {
    return "刚刚";
  }
  return date.toString();
}

String mateTimeStampFormat(startTime, endTime){
  DateTime startDate = new DateTime.fromMillisecondsSinceEpoch(startTime);
  DateTime endDate = new DateTime.fromMillisecondsSinceEpoch(endTime);
  StringBuffer sb = new StringBuffer();
  sb.write(startDate.year.toString());
  sb.write(".");
  sb.write(startDate.month.toString().padLeft(2,'0'));
  sb.write(".");
  sb.write(startDate.day.toString().padLeft(2,'0'));
  sb.write(" - ");
  sb.write(endDate.year.toString());
  sb.write(".");
  sb.write(endDate.month.toString().padLeft(2,'0'));
  sb.write(".");
  sb.write(endDate.day.toString().padLeft(2,'0'));
  return sb.toString();
}