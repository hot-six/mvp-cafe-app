class PaginatedResponse<T> {
  int totalPages;
  int totalElements;
  int size;
  List<T> contents;
  int numberOfElements;
  ResponsePageable pageable;
  int number;
  bool first;
  bool last;
  bool empty;

  PaginatedResponse({
    required this.totalPages,
    required this.totalElements,
    required this.size,
    required this.contents,
    required this.numberOfElements,
    required this.pageable,
    required this.number,
    required this.first,
    required this.last,
    required this.empty,
  });

  PaginatedResponse.parse(
      {required this.contents, required Map<String, dynamic> json})
      : this.totalPages = json['totalPages'],
        this.totalElements = json['totalElements'],
        this.size = json['size'],
        this.number = json['number'],
        this.numberOfElements = json['numberOfElements'],
        this.pageable = ResponsePageable.fromJson(json['pageable']),
        this.first = json['first'],
        this.last = json['last'],
        this.empty = json['empty'];

  PaginatedResponse.empty()
      : this.totalPages = 0,
        this.totalElements = 0,
        this.size = 0,
        this.number = 0,
        this.contents = [],
        this.numberOfElements = 0,
        this.pageable = ResponsePageable.empty(),
        this.first = true,
        this.last = true,
        this.empty = true;

  int? get next {
    if (last == false && pageable.pageNumber < totalPages)
      return pageable.pageNumber + 1;
    return null;
  }
}

class ResponsePageable {
  int offset;
  ResponseSort sort;
  bool paged;
  int pageNumber;
  int pageSize;
  bool unPaged;

  ResponsePageable({
    required this.offset,
    required this.sort,
    required this.paged,
    required this.pageNumber,
    required this.pageSize,
    required this.unPaged,
  });

  ResponsePageable.empty()
      : this.offset = 0,
        this.sort = ResponseSort.empty(),
        this.paged = false,
        this.pageNumber = 1,
        this.pageSize = 0,
        this.unPaged = true;

  ResponsePageable.fromJson(Map<String, dynamic> json)
      : this.offset = json['offset'],
        this.sort = ResponseSort.fromJson(json['sort']),
        this.paged = json['paged'],
        this.pageNumber = json['pageNumber'],
        this.pageSize = json['pageSize'],
        this.unPaged = json['unpaged'];
}

class ResponseSort {
  bool empty;
  bool sorted;
  bool unsorted;

  ResponseSort({
    required this.empty,
    required this.sorted,
    required this.unsorted,
  });

  ResponseSort.empty()
      : this.empty = true,
        this.sorted = false,
        this.unsorted = true;

  ResponseSort.fromJson(Map<String, dynamic> json)
      : this.empty = json['empty'],
        this.sorted = json['sorted'],
        this.unsorted = json['unsorted'];

  Map<String, dynamic> toJson() => {
        'empty': this.empty,
        'sorted': this.sorted,
        'unsorted': this.unsorted,
      };
}
