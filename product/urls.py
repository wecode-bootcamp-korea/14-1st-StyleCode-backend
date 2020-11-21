from django.urls import path
from .views      import CategoryView


urlpatterns= [
    path('/category', CategoryView.as_view()),
#    path('/secondcategory/<int:second_category_id>' , SecondCategoryView.as_view()),
#    path('/thirdcategory/<int:third_category_id>'   , ThirdCategoryView.as_view())

]

