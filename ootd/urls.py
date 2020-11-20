from django.urls import path
from .views      import OotdDetailView, OotdListlView, CommentView, LikeView, FollowView

urlpatterns=[
    path('/<int:ootd_id>', OotdDetailView.as_view()),
    path('/list', OotdListlView.as_view()),
    path('/comment', CommentView.as_view()),
    path('/like', LikeView.as_view()),
    path('/follow', FollowView.as_view()),
]