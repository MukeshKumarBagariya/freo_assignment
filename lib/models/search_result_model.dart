import 'dart:convert';

SearchResultModel searchResultModelFromJson(String str) => SearchResultModel.fromJson(json.decode(str));

String searchResultModelToJson(SearchResultModel data) => json.encode(data.toJson());

class SearchResultModel {
  bool? batchcomplete;
  Continue searchResutModelContinue;
  Query query;

  SearchResultModel({
    required this.batchcomplete,
    required this.searchResutModelContinue,
    required this.query,
  });

  factory SearchResultModel.fromJson(Map<String, dynamic> json) => SearchResultModel(
    batchcomplete: json["batchcomplete"] ?? false,
    searchResutModelContinue: Continue.fromJson(json["continue"]),
    query: Query.fromJson(json["query"]),
  );

  Map<String, dynamic> toJson() => {
    "batchcomplete": batchcomplete,
    "continue": searchResutModelContinue.toJson(),
    "query": query.toJson(),
  };
}

class Query {
  var redirects;
  List<Page> pages;

  Query({
    required this.redirects,
    required this.pages,
  });

  factory Query.fromJson(Map<String, dynamic> json) => Query(
    redirects: json["redirects"],
    pages: List<Page>.from(json["pages"].map((x) => Page.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "redirects": redirects,
    "pages": List<dynamic>.from(pages.map((x) => x.toJson())),
  };
}

class Page {
  int pageid;
  int ns;
  String title;
  int index;
  Thumbnail? thumbnail;
  Terms? terms;

  Page({
    required this.pageid,
    required this.ns,
    required this.title,
    required this.index,
    this.thumbnail,
    this.terms,
  });

  factory Page.fromJson(Map<String, dynamic> json) => Page(
    pageid: json["pageid"],
    ns: json["ns"],
    title: json["title"],
    index: json["index"],
    thumbnail: json["thumbnail"] == null ? null : Thumbnail.fromJson(json["thumbnail"]),
    terms: json["terms"] == null ? null : Terms.fromJson(json["terms"]),
  );

  Map<String, dynamic> toJson() => {
    "pageid": pageid,
    "ns": ns,
    "title": title,
    "index": index,
    "thumbnail": thumbnail?.toJson(),
    "terms": terms?.toJson(),
  };
}

class Terms {
  List<String> description;

  Terms({
    required this.description,
  });

  factory Terms.fromJson(Map<String, dynamic> json) => Terms(
    description: List<String>.from(json["description"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "description": List<dynamic>.from(description.map((x) => x)),
  };
}

class Thumbnail {
  String source;
  int width;
  int height;

  Thumbnail({
    required this.source,
    required this.width,
    required this.height,
  });

  factory Thumbnail.fromJson(Map<String, dynamic> json) => Thumbnail(
    source: json["source"],
    width: json["width"],
    height: json["height"],
  );

  Map<String, dynamic> toJson() => {
    "source": source,
    "width": width,
    "height": height,
  };
}

class Redirect {
  int index;
  String from;
  String to;

  Redirect({
    required this.index,
    required this.from,
    required this.to,
  });

  factory Redirect.fromJson(Map<String, dynamic> json) => Redirect(
    index: json["index"],
    from: json["from"],
    to: json["to"],
  );

  Map<String, dynamic> toJson() => {
    "index": index,
    "from": from,
    "to": to,
  };
}

class Continue {
  int gpsoffset;
  String continueContinue;

  Continue({
    required this.gpsoffset,
    required this.continueContinue,
  });

  factory Continue.fromJson(Map<String, dynamic> json) => Continue(
    gpsoffset: json["gpsoffset"],
    continueContinue: json["continue"],
  );

  Map<String, dynamic> toJson() => {
    "gpsoffset": gpsoffset,
    "continue": continueContinue,
  };
}
