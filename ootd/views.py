# Python
import json

# Django
from django.views     import View
from django.http      import JsonResponse,request
from django.db.models import Q

# Models
from user.models  import User
from .models      import (
        OotdImageUrl,
        Tag,
        OotdTag,
        Ootd,
        Like,
        Comment,
        Follow
    )

class OotdDetailRegisterView(View):
    def post(self, request):
        data = json.loads(request.body)
        try:
            user = User.objects.get(id = data['user_id'])
            post = Ootd.objects.create(
                description = data['description'],
                user = user
            )

            description_list = data['description'].split('#')
            for string in description_list[1:]:
                if string[0] == ' ':
                    continue
                tag = string.split()[0]

                if not Tag.objects.filter(tag_name=str('#'+tag)).exists():
                    tag =Tag.objects.create(tag_name=str('#'+tag))
                    OotdTag.objects.create(ootd =post, tag = tag)
                
                exist_tag = Tag.objects.get(tag_name = str('#'+tag))
                OotdTag.objects.create(ootd =post, tag = exist_tag)

            print(type(data['image_list']))

            if str(type(data['image_list'])) != "<class 'list'>":
                return JsonResponse({'message' : 'TYPE_ERROR'}, status=400)

            for image in data['image_list']:
                OotdImageUrl.objects.create(ootd=post, image_url=image)

            return JsonResponse({'message' : 'SUCCESS'}, status = 200)
        
        except KeyError:
            return JsonResponse({'message' : 'KEY_ERROR'}, status = 400)
        
        except User.DoesNotExist:
            return JsonResponse({'message' : 'DOES_NOT_EXIST'}, status = 400)
        
        except Ootd.DoesNotExist:
            return JsonResponse({'message' : 'DOES_NOT_EXIST'}, status = 400)


class OotdDetailView(View):

    def get(self, request, ootd_id):
        try:
            posts = Ootd.objects.select_related('user').prefetch_related(
                'like_set',
                'ootdimageurl_set',
                'comment_set',
                'product_set',
                'tag',
            )

            post = posts.get(id = ootd_id)
            ootd_post = {
                    'contentImg'        : [image.image_url for image in post.ootdimageurl_set.all()],
                    'productImg'        : [product_image.main_image_url for product_image in post.product_set.all()],
                    'productName'       : [product_name.title for product_name in post.product_set.all()],
                    'price'             : [product_price.price for product_price in post.product_set.all()],
                    'sale'              : [product_sales.sales_product for product_sales in post.product_set.all()],
                    'authorImg'         : post.user.profile_image_url,
                    'author'            : post.user.nickname,
                    'introdution'       : post.user.description,
                    'tagsName'          : [tag_name.tag.tag_name for tag_name in post.ootdtag_set.all()],
                    'datetime'          : post.created_at.strftime("%Y-%m-%d %H:%M:%S") ,
                    'description'       : post.description,
                    'follower'          : post.like_set.count(),
                    'commentNum'        : post.comment_set.count(),
                    'comments'          : [
                            {
                                'commentAuthor'    : comment.user.nickname,
                                'commentAuthorImg' : comment.user.profile_image_url,
                                'comment'          : comment.content,
                                'parent_id'        : comment.parent_id 
                            } for comment in post.comment_set.all()
                                        ]
                        }
                
            return JsonResponse(ootd_post, status = 200)
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
                    'sale'              : [product_sales.discount_rate for product_sales in post.product_set.all()],
                    'authorImg'         : post.user.profile_image_url,
                    'author'            : post.user.nickname,
                    'tagsName'          : [tag_name.tag_name for tag_name in post.tag.all()],
                    'datetime'          : post.created_at.strftime("%Y-%m-%d %H:%M:%S"),
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
                ootd = post
                )

            return JsonResponse({'message' : 'SUCCESS'}, status = 200)
        
        except KeyError:
            return JsonResponse({'message' : 'KEY_ERROR'}, status = 400)

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
        
        except Comment.DoesNotExist:
            return JsonResponse({ 'message' : 'INVALID_COMMENT'}, status = 400) 

    def delete(self, request):
        data = json.loads(request.body)

        try:
            user = User.objects.get(id = data['user_id'])
            comment = Comment.objects.get(user = user, id = data['comment_id'])

            comment.delete()

            return JsonResponse({'message' : 'SUCCESS'}, status = 200)

        except  Comment.DoesNotExist:
            return JsonResponse({ 'message' : 'INVALID_COMMENT'}, status = 400)

class ReCommentView(View):
    def post(self, request):
        data   = json.loads(request.body)
        try:
            user    = User.objects.get(id = data['user_id'])
            comment = Comment.objects.get(id = data['comment_id'])

            Comment.objects.create(user = user, content = data['content'], ootd=comment.ootd, parent = comment)

            return JsonResponse({"message" : "SUCCESS"},status = 200)

        except KeyError:
            return JsonResponse({"message" : "KEY_ERROR"}, status = 400)

        except Comment.DoesNotExist:
            return JsonResponse({"message" : "INVALID_COMMENT"}, status = 400)

    def put(self, request):
        data = json.loads(request.body)
        try:
            user    = User.objects.get(id = data['user_id'])
            comment = Comment.objects.get(id= data['reply_id'], parent_id = data['parent_id'], user=user)
            
            comment.content = data['content']
            comment.save()

            return JsonResponse({"message" : "SUCCESS"}, status = 200)
        except KeyError:
            return JsonResponse({"message" : "KEY_ERROR"}, status = 400)

        except Comment.DoesNotExist:
            return JsonResponse({"message" : "INVALID_COMMENT"}, status = 400)

    def delete(self, request):
        data = json.loads(request.body)
        try:
            user    = User.objects.get(id = data['user_id'])
            comment = Comment.objects.get(id = data['reply_id'], user = user)

            comment.delete()

            return JsonResponse({"message" : "SUCCESS"}, status = 200)

        except KeyError:
            return JsonResponse({"message" : "KEY_ERROR"}, status = 400)
        
        except Comment.DoesNotExist:
            return JsonResponse({"message" : "INVALID_COMMENT"}, status = 400)


class LikeView(View):
    def post(self, request):
        data = json.loads(request.body)

        if Like.objects.filter(user = data['user_id'], ootd = data['ootd_id']):
            return JsonResponse({"message" : "OVERLAP_ERROR"}, status = 400)

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
            post = Ootd.objects.get(id = data['ootd_id'])

            Like.objects.get(user = user, ootd = post).delete()

            return JsonResponse({"message" : "SUCCESS"}, status = 200)

        except KeyError:
            return JsonResponse({'message' : 'KEY_ERROR'}, status = 400)

        except User.DoesNotExist:
            return JsonResponse({'message' : 'DOES_NOT_EXIST'}, status = 400)

        except Ootd.DoesNotExist:
            return JsonResponse({'message' : 'DOES_NOT_EXIST'}, status = 400)

        except Like.DoesNotExist:
            return JsonResponse({"message" : "DOES_NOT_EXIST"})   

class FollowView(View):
    def post(self, request):
        data = json.loads(request.body)

        if Follow.objects.filter(followee = data['followee_id'], follower = data['follower_id']):
            return JsonResponse({"message" : "OVERLAP_ERROR"}, status = 400)

        try:
            followee = User.objects.get(id = data['followee_id'])
            follower = User.objects.get(id = data['follower_id'])

            Follow.objects.create(followee = followee, follower = follower)

            return JsonResponse({"message" : "SUCCESS"}, status = 200)

        except KeyError:
            return JsonResponse({'message' : 'KEY_ERROR'}, status = 400)

        except User.DoesNotExist:
            return JsonResponse({'message' : 'DOES_NOT_EXIST'}, status = 400)

    def delete(self, request):
        data = json.loads(request.body)

        try:
            followee = User.objects.get(id = data['followee_id'])
            follower = User.objects.get(id = data['follower_id'])

            Follow.objects.get(followee = followee, follower = follower).delete()

            return JsonResponse({"message" : "SUCCESS"}, status = 200)
        
        except KeyError:
            return JsonResponse({'message' : 'KEY_ERROR'}, status = 400)

        except User.DoesNotExist:
            return JsonResponse({'message' : 'DOES_NOT_EXIST'}, status = 400)
