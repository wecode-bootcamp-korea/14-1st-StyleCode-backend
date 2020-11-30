from django.urls import path

from .views      import (OotdDetailView,
                         OotdView,
                         OotdCommentView,
                         LikeView,
                         FollowView,
                         ReCommentView,
                         CommentView)

urlpatterns=[
    path('/<int:ootd_id>', OotdDetailView.as_view()),
    path('', OotdView.as_view()),
    path('/<int:ootd_id>/comments', OotdCommentView.as_view()),
    path('/comment/<int:comment_id>',CommentView.as_view()),
    path('/<int:ootd_id>/like', LikeView.as_view()),
    path('/follow/<int:followee_id>', FollowView.as_view()),
    path('/reply/<int:reply_id>', ReCommentView.as_view())
]
