from rest_framework.response import Response

from pruebaback.utils import partial_search_vector


def paginated_list(self, request, *args, **kwargs):
    serializer_class = self.get_serializer_class()
    queryset = self.filter_queryset(self.get_queryset())
    search_fields = getattr(self, 'search_fields', [])
    is_distinct = getattr(self, 'is_distinct', False)
    not_paginated = request.GET.get('notPaginated', None)

    # Searching
    search_value = request.GET.get('searchValue', None)
    if search_value:
        queryset = partial_search_vector(
            queryset, search_fields, search_value, is_distinct)

    # Sorting
    order = request.GET.get('order', None)
    order_by = request.GET.get('orderBy', None)
    if order and order_by:
        if order == 'desc':
            order_by = '-{}'.format(order_by)
        queryset = queryset.order_by(order_by)

    # Pagination
    page = self.paginate_queryset(queryset)
    if page is not None and not not_paginated:
        serializer = serializer_class(page, many=True)
        return self.get_paginated_response(serializer.data)

    serializer = serializer_class(queryset, many=True)
    return Response(serializer.data)
