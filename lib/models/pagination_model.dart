class PaginationModel {
  PaginationModel({
    required this.limit,
    required this.page,
    required this.sort,
    required this.order,
    required this.total,
    required this.totalPage,
  });
  late int limit;
  late int page;
  late String sort;
  late String order;
  late int total;
  late int totalPage;
  
  PaginationModel.fromJson(Map<String, dynamic> json){
    limit = json['limit'];
    page = json['page'];
    sort = json['sort'];
    order = json['order'];
    total = json['total'];
    totalPage = json['total_page'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['limit'] = limit;
    data['page'] = page;
    data['sort'] = sort;
    data['order'] = order;
    data['total'] = total;
    data['total_page'] = totalPage;
    return data;
  }
}