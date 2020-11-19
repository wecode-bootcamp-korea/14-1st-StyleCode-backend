# Python
import json

# Django
from django.views import View
from django.http  import JsonResponse,request

# Models
from user.models  import User
from .models      import (
        OotdImageUrl, Tag,
        OotdTag,
        Ootd,
        Like,
        Comment,
        Follow
    )

class OotdDetailView(View):
    def post(self, request):
        data = json.loads(request.body)
        try:
            user = User.objects.get(id = data['user_id'])
            post = Ootd.objects.create(
                description = data['description'],
                user = user
            )
            for image in data['image_list']:
                OotdImageUrl.objects.create(ootd=post, image_url=image)

            return JsonResponse({'message' : 'SUCCESS'}, status = 200)
        
        except KeyError:
            return JsonResponse({'message' : 'KEY_ERROR'}, status = 400)
        
        except User.DoesNotExist:
            return JsonResponse({'message' : 'DOES_NOT_EXIST'}, status = 400)
        
        except Ootd.DoesNotExist:
            return JsonResponse({'message' : 'DOES_NOT_EXIST'}, status = 400)


    def get(self, request):
        data = json.loads(request.body)
        try:
            posts = Ootd.objects.select_related('user').prefetch_related(
                'like_set',
                'ootdimageurl_set',
                'comment_set'
            )

            post = posts.get(id = data['ootd_id'])
            ootd_post = [
                {
                    'ootd_image_urls'        : [image.image_url for image in post.ootdimageurl_set.all()],
                    'ootd_profile_image_url' : post.user.profile_image_url,
                    'nickname'               : post.user.nickname,
                    'description'            : post.description,
                    'like_count'             : post.like_set.count(),
                    'comments'               : [
                            {
                                'comment_user_nickname'          : comment.nickname,
                                'comment_user_profile_image_url' : comment.profile_image_url,
                                'comment_comment'                : comment.comment,
                                'comment_create_at'              : str(comment.created_at),
                                'parent_id'                      : comment.parent_id
                            } for comment in post.comment_set.all()
                        ]
                    }
                ]
            return JsonResponse({"ootd_detail" : ootd_post}, status = 200)
        
        except Ootd.DoesNotExist:
            return JsonResponse({"MESSAGE" : "DOES_NOT_EXIST"}, status = 400)

class OotdListlView(View):
    def get(self, request):
        try:
            posts = Ootd.objects.select_related('user').prefetch_related(
                'like_set',
                'ootdimageurl_set',
                'comment_set',
            )

            ootd_list = [
                {
                    'ootd_image_urls'        : [image.image_url for image in post.ootdimageurl_set.all()],
                    'ootd_profile_image_url' : post.user.profile_image_url,
                    'nickname'               : post.user.nickname,
                    'description'            : post.description,
                    'like_count'             : post.like_set.count(),
                    'comment_count'          : post.comment_set.count(),
                    'comments'               : [
                            {
                                'comment_user_nickname'          : comment.nickname,
                                'comment_user_profile_image_url' : comment.profile_image_url,
                                'comment_comment'                : comment.comment[:2],
                                'comment_create_at'              : str(comment.created_at),
                            } for comment in post.comment_set.all()
                        ]
                    } for post in posts
            ]

            return JsonResponse({'ootd_list' : list(ootd_list)}, status = 200)
        
        except Ootd.DoesNotExist:
            return JsonResponse({"MESSAGE" : "DOES_NOT_EXIST"}, status = 400)   

class CommentView(View):
    def post(self, request):
        data = json.loads(request.body)

        try:
            user = User.objects.get(id = data['user_id'])
            post = Ootd.objects.get(id = data['ootd_id'])

            Comment.objects.create(
                comment = data['comment'],
                user = user,
                ootd = post,
            )

            return JsonResponse({'message' : 'SUCCESS'}, status = 200)
        
        except KeyError:
            return JsonResponse({'message' : 'KEY_ERROR'}, status = 400)
        
        except  User.DoesNotExist:
            return JsonResponse({'message' : 'DOES_NOT_EXIST'}, status = 400)

        except  Ootd.DoesNotExist:
            return JsonResponse({'message' : 'DOES_NOT_EXIST'}, status = 400)
        

    def put(self, request):
        data = json.loads(request.body)

        try:
            user = User.objects.get(id = data['user_id'])
            comment = Comment.objects.get(user=user, id = data['comment_id'])

            comment.comment = data['comment']

            comment.save()

            return JsonResponse({'message' : 'SUCCESS'}, status = 200)

        except User.DoesNotExist:
            return JsonResponse({'message' : 'INVALID_USER'}, status = 400)
        
        except Comment.DoesNotExist:
            return JsonResponse({ 'message' : 'INVALID_COMMENT'}, status = 400) 

    def delete(self, request):
        data = json.loads(request.body)

        try:
            user = User.objects.get(id = data['user_id'])
            comment = Comment.objects.get(user = user, id = data['comment_id'])

            comment.delete()

            return JsonResponse({'message' : 'SUCCESS'}, status = 200)

        except User.DoesNotExist:
            return JsonResponse({'message' : 'INVALID_USER'}, status = 400)

        except  Comment.DoesNotExist:
            return JsonResponse({ 'message' : 'INVALID_COMMENT'}, status = 400)

class LikeView(View):
    def post(self, request):
        data = json.loads(request.body)

        try:
            user = User.objects.get(id = data['user_id'])
            post = Ootd.objects.get(id = data['ootd_id'])

            Like.objects.create(
                user = user,
                ootd = post
            )

            return JsonResponse({'message' : 'SUCCESS'}, status = 200)

        except KeyError:
            return JsonResponse({'message' : 'KEY_ERROR'}, status = 400)

        except User.DoesNotExist:
            return JsonResponse({'message' : 'DOES_NOT_EXIST'}, status = 400)

        except Ootd.DoesNotExist:
            return JsonResponse({'message' : 'DOES_NOT_EXIST'}, status = 400)

    def delete(self, request):
        data = json.loads(request.body)

        try:
            user = User.objects.get(id = data['user_id'])
            post = Ootd.objects.get(id = data['post_id'])

            Like(user = user, ootd = post).delete()

        except KeyError:
            return JsonResponse({'message' : 'KEY_ERROR'}, status = 400)

        except User.DoesNotExist:
            return JsonResponse({'message' : 'DOES_NOT_EXIST'}, status = 400)

        except Ootd.DoesNotExist:
            return JsonResponse({'message' : 'DOES_NOT_EXIST'}, status = 400)   

class FollowView(View):
    def post(self, request):
        data = json.loads(request.body)

        try:
            followee = Follow.objects.get(id = data['followee_id'])
            follower = Follow.objects.get(id = data['follower_id'])

            Follow.objects.create(followee = followee, follower = follower)

        except KeyError:
            return JsonResponse({'message' : 'KEY_ERROR'}, status = 400)

        except User.DoesNotExist:
            return JsonResponse({'message' : 'DOES_NOT_EXIST'}, status = 400)

    def delete(self, request):
        data = json.loads(request.body)

        try:
            followee = Follow.objects.get(id = data['followee_id'])
            follower = Follow.objects.get(id = data['follower_id'])

            Follow(followee = followee, follower = follower).delete()
        
        except KeyError:
            return JsonResponse({'message' : 'KEY_ERROR'}, status = 400)

        except User.DoesNotExist:
            return JsonResponse({'message' : 'DOES_NOT_EXIST'}, status = 400)
