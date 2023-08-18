String parceDateRange(String start, String end) {
  var startDate = DateTime.parse(start);
  var endDate = DateTime.parse(end);
  return '${startDate.month}/${startDate.year} - ${endDate.month}/${endDate.year}';
}
