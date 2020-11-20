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


    def get(self, request, ootd_id):
        try:
            posts = Ootd.objects.select_related('user').prefetch_related(
                'like_set',
                'ootdimageurl_set',
                'comment_set',
                'product_set',
            )

            post = posts.get(id = ootd_id)
            ootd_post = [
                    {
                    'contentImg'        : [image.image_url for image in post.ootdimageurl_set.all()],
                    'productImg'        : [product_image.main_image_url for product_image in post.product_set.all()],
                    'productName'       : [product_name.title for product_name in post.product_set.all()],
                    'price'             : [product_price.price for product_price in post.product_set.all()],
                    'sale'              : [product_sales.sales for product_sales in post.product_set.all()],
                    'authorImg'         : post.user.profile_image_url,
                    'author'            : post.user.nickname,
                    'tagsName'          : [tag_name.tag.tag_name for tag_name in post.ootdtag_set.all()],
                    'datetime'          : str(post.created_at)[:19],
                    'description'       : post.description,
                    'follower'          : post.like_set.count(),
                    'commentNum'        : post.comment_set.count(),
                    'comments'          : [
                            {
                                'commentAuthor'    : comment.user.nickname,
                                'commentAuthorImg' : comment.user.profile_image_url,
                                'comment'          : comment.content,
                                'parent_id'        : comment.parent_id
                            } for comment in post.comment_set.all()[:2]
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
                'product_set',
                'tag'
            )

            ootd_list = [
                {
                    'contentImg'        : [image.image_url for image in post.ootdimageurl_set.all()],
                    'productImg'        : [product_image.main_image_url for product_image in post.product_set.all()],
                    'productName'       : [product_name.title for product_name in post.product_set.all()],
                    'price'             : [product_price.price for product_price in post.product_set.all()],
                    'sale'              : [product_sales.sales for product_sales in post.product_set.all()],
                    'authorImg'         : post.user.profile_image_url,
                    'author'            : post.user.nickname,
                    'tagsName'          : [tag_name.tag_name for tag_name in post.tag.all()],
                    'datetime'          : str(post.created_at)[:19],
                    'description'       : post.description,
                    'follower'          : post.like_set.count(),
                    'commentNum'        : post.comment_set.count(),
                    'comments'          : [
                            {
                                'commentAuthor'    : comment.user.nickname,
                                'commentAuthorImg' : comment.user.profile_image_url,
                                'comment'          : comment.content,
                                'parent_id'        : comment.parent_id
                            } for comment in post.comment_set.all()[:2]
                        ]
                    } for post in posts
            ]

            return JsonResponse({'ootd_list' : ootd_list}, status = 200)
        
        except Ootd.DoesNotExist:
            return JsonResponse({"MESSAGE" : "DOES_NOT_EXIST"}, status = 400)   

class CommentView(View):
    def post(self, request):
        data = json.loads(request.body)

        try:
            user = User.objects.get(id = data['user_id'])
            post = Ootd.objects.get(id = data['ootd_id'])

            Comment.objects.create(
                content = data['content'],
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

            comment.content = data['content']

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
