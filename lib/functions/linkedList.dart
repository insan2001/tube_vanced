// ignore_for_file: file_names

class Tuple<t1, t2> {
  final t1 item1;
  final t2 item2;
  Tuple(this.item1, this.item2);
}

// List<Tuple<DateTime, String>> linkList(
//     List<DateTime> list1, List<String> list2) {
//   List<Tuple<DateTime, String>> combined = [];
//   for (int i = 0; i < list1.length; i++) {
//     combined.add(Tuple(list1[i], list2[i]));
//   }
//   return combined;
// }

// List<Tuple<DateTime, String>> sortByDate(List<Tuple<DateTime, String>> list) {
//   list.sort(((a, b) => a.item1.compareTo(b.item1)));

//   return list.reversed.toList();
// }

// Tuple<List<DateTime>, List<String>> unLinkList(
//     List<Tuple<DateTime, String>> list) {
//   Tuple<DateTime, String> element;
//   List<DateTime> list1 = [];
//   List<String> list2 = [];
//   for (element in list) {
//     list1.add(element.item1);
//     list2.add(element.item2);
//   }
//   return Tuple(list1, list2);
// }

// Tuple<List<DateTime>, List<String>> doAll(
//     List<DateTime> list1, List<String> list2) {
//   List<Tuple<DateTime, String>> combined = linkList(list1, list2);
//   List<Tuple<DateTime, String>> sorted = sortByDate(combined);
//   return unLinkList(sorted);
// }
