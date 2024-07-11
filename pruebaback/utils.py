from typing import List

from django.db.models import Q, QuerySet


def partial_search_vector(
        queryset: QuerySet, search_vector_list: List[str],
        search_value: str, is_distinct: bool) -> QuerySet:
    q_objects = Q()
    if is_distinct:
        queryset = queryset.distinct()
    model = queryset.model
    for search_item in search_vector_list:
        if '__' in search_item:
            field_list = search_item.split("__")
            main = field_list[0]
            related_fields = field_list[1:]
            field_model = model._meta.get_field(main)
            for related in related_fields:
                field_model = field_model.remote_field.model._meta.get_field(
                    related)
            field_type = field_model.get_internal_type()
        else:
            field_type = queryset.model._meta.get_field(
                search_item).get_internal_type()

        partial_filter = f"{search_item}__unaccent__icontains"
        if field_type != 'CharField':
            partial_filter = f"{search_item}__icontains"
        q_objects |= Q(**{partial_filter: str(search_value)})

    return queryset.filter(q_objects)
