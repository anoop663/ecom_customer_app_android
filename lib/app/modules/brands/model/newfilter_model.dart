class Filters {
    List<Filter1> filters;

    Filters({
        required this.filters,
    });

}

class Filter1 {
    String type;
    List<String> values;

    Filter1({
        required this.type,
        required this.values,
    });

}
