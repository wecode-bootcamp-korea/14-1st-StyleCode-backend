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
            return JsonResponse({"MESSAGE" : "OOTD_DOES_NOT_EXIST"}, status = 400)

class OotdlView(View):
    def post(self, request):
        data = json.loads(request.body)
        try:
            user = User.objects.get(id = data['user_id'])
            post = Ootd.objects.create(
                description = data['description'],
                user = user
            )
            # 태그 로직 (# 기준으로 split하여서 태그인 값만 걸러 태그 테이블에 추가)
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

            if str(type(data['image_list'])) != "<class 'list'>":
                return JsonResponse({'message' : 'TYPE_ERROR'}, status=400)

            for image in data['image_list']:
                OotdImageUrl.objects.create(ootd=post, image_url=image)

            return JsonResponse({'message' : 'SUCCESS'}, status = 200)
        
        except KeyError:
            return JsonResponse({'message' : 'KEY_ERROR'}, status = 400)
        
        except User.DoesNotExist:
            return JsonResponse({'message' : 'USER_DOES_NOT_EXIST'}, status = 400)
        
        except Ootd.DoesNotExist:
            return JsonResponse({'message' : 'OOTD_DOES_NOT_EXIST'}, status = 400)

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
            return JsonResponse({"MESSAGE" : "OOTD_DOES_NOT_EXIST"}, status = 400)   

class OotdCommentView(View):
    def post(self, request, ootd_id):
        data = json.loads(request.body)

        try:
            user = User.objects.get(id = data['user_id'])
            post = Ootd.objects.get(id = ootd_id)

            Comment.objects.create(
                content = data['content'],
                user = user,
                ootd = post
                )

            return JsonResponse({'message' : 'SUCCESS'}, status = 200)
        
        except KeyError:
            return JsonResponse({'message' : 'KEY_ERROR'}, status = 400)

        except  Ootd.DoesNotExist:
            return JsonResponse({'message' : 'OOTD_DOES_NOT_EXIST'}, status = 400)
        
class CommentView(View):
    def post(self, request, comment_id):
        data   = json.loads(request.body)
        try:
            user    = User.objects.get(id = data['user_id'])
            comment = Comment.objects.get(id = comment_id)

            Comment.objects.create(user = user, content = data['content'], ootd=comment.ootd, parent = comment)

            return JsonResponse({"message" : "SUCCESS"},status = 200)

        except KeyError:
            return JsonResponse({"message" : "KEY_ERROR"}, status = 400)

        except Comment.DoesNotExist:
            return JsonResponse({"message" : "COMMENT_DOES_NOT_EXIST"}, status = 400)

    def put(self, request, comment_id):
        data = json.loads(request.body)

        try:
            user = User.objects.get(id = data['user_id'])
            comment = Comment.objects.get(user=user, id = comment_id)

            comment.content = data['content']

            comment.save()

            return JsonResponse({'message' : 'SUCCESS'}, status = 200)
        
        except Comment.DoesNotExist:
            return JsonResponse({ 'message' : 'COMMENT_DOES_NOT_EXIST'}, status = 400) 

    def delete(self, request, comment_id):
        data = json.loads(request.body)

        try:
            user = User.objects.get(id = data['user_id'])
            comment = Comment.objects.get(user = user, id = comment_id).delete()
            return JsonResponse({'message' : 'SUCCESS'}, status = 200)

        except  Comment.DoesNotExist:
            return JsonResponse({ 'message' : 'COMMENT_DOES_NOT_EXIST'}, status = 400)

class ReCommentView(View):
    def put(self, request, reply_id):
        data = json.loads(request.body)
        try:
            user    = User.objects.get(id = data['user_id'])
            comment = Comment.objects.get(id= reply_id, user=user)
            
            comment.content = data['content']
            comment.save()

            return JsonResponse({"message" : "SUCCESS"}, status = 200)
        
        except KeyError:
            return JsonResponse({"message" : "KEY_ERROR"}, status = 400)

        except Comment.DoesNotExist:
            return JsonResponse({"message" : "COMMENT_DOES_NOT_EXIST"}, status = 400)

    def delete(self, request, reply_id):
        data = json.loads(request.body)
        try:
            user    = User.objects.get(id = data['user_id'])
            comment = Comment.objects.get(id = reply_id, user = user)

            comment.delete()

            return JsonResponse({"message" : "SUCCESS"}, status = 200)

        except KeyError:
            return JsonResponse({"message" : "KEY_ERROR"}, status = 400)
        
        except Comment.DoesNotExist:
            return JsonResponse({"message" : "COMMENT_DOES_NOT_EXIST"}, status = 400)


class LikeView(View):
    def post(self, request, ootd_id):
        data = json.loads(request.body)

        if Like.objects.filter(user = data['user_id'], ootd = ootd_id):
            return JsonResponse({"message" : "OVERLAP_ERROR"}, status = 400)

        try:
            user = User.objects.get(id = data['user_id'])
            post = Ootd.objects.get(id = ootd_id)

            Like.objects.create(
                user = user,
                ootd = post
            )

            return JsonResponse({'message' : 'SUCCESS'}, status = 200)

        except KeyError:
            return JsonResponse({'message' : 'KEY_ERROR'}, status = 400)

        except User.DoesNotExist:
            return JsonResponse({'message' : 'USER_DOES_NOT_EXIST'}, status = 400)

        except Ootd.DoesNotExist:
            return JsonResponse({'message' : 'OOTD_DOES_NOT_EXIST'}, status = 400)

    def delete(self, request, ootd_id):
        data = json.loads(request.body)

        try:
            user = User.objects.get(id = data['user_id'])
            post = Ootd.objects.get(id = ootd_id)

            Like.objects.get(user = user, ootd = post).delete()

            return JsonResponse({"message" : "SUCCESS"}, status = 200)

        except KeyError:
            return JsonResponse({'message' : 'KEY_ERROR'}, status = 400)

        except Ootd.DoesNotExist:
            return JsonResponse({'message' : 'OOTD_DOES_NOT_EXIST'}, status = 400)

        except Like.DoesNotExist:
            return JsonResponse({"message" : "DOES_NOT_EXIST"})   

class FollowView(View):
    def post(self, request, followee_id):
        data = json.loads(request.body)

        if Follow.objects.filter(followee = followee_id, follower = data['follower_id']):
            return JsonResponse({"message" : "OVERLAP_ERROR"}, status = 400)

        try:
            followee = User.objects.get(id = followee_id)
            follower = User.objects.get(id = data['follower_id'])

            Follow.objects.create(followee = followee, follower = follower)

            return JsonResponse({"message" : "SUCCESS"}, status = 200)

        except KeyError:
            return JsonResponse({'message' : 'KEY_ERROR'}, status = 400)

    def delete(self, request, followee_id):
        data = json.loads(request.body)

        try:
            followee = User.objects.get(id = followee_id)
            follower = User.objects.get(id = data['follower_id'])

            Follow.objects.get(followee = followee, follower = follower).delete()

            return JsonResponse({"message" : "SUCCESS"}, status = 200)
        
        except KeyError:
            return JsonResponse({'message' : 'KEY_ERROR'}, status = 400)

        except User.DoesNotExist:
            return JsonResponse({'message' : 'USER_DOES_NOT_EXIST'}, status = 400)
