from django.db import models

class Tag(models.Model):
    tag_name = models.CharField(max_length=10)

    class Meta:
        db_table = 'tags'

class OotdTag(models.Model):
    ootd = models.ForeignKey('Ootd', on_delete=models.CASCADE)
    tag  = models.ForeignKey('Tag', on_delete=models.CASCADE)

    class Meta:
        db_table = 'ootds_tags'

class Ootd(models.Model):
    description = models.TextField()
    created_at  = models.DateTimeField(auto_now_add=True)
    updated_at  = models.DateTimeField(auto_now=True, null=True)
    user        = models.ForeignKey('user.User', on_delete=models.CASCADE)
    tag         = models.ManyToManyField('Tag', through='OotdTag')

    class Meta:
        db_table = 'ootds'

class OotdImageUrl(models.Model):
    image_url = models.URLField(max_length=200)
    ootd      = models.ForeignKey('Ootd', on_delete=models.CASCADE)

    class Meta:
        db_table = 'ootd_image_urls'

class Like(models.Model):
    ootd = models.ForeignKey('Ootd', on_delete=models.CASCADE)
    user = models.ForeignKey('user.User', on_delete=models.CASCADE)

    class Meta:
        db_table = 'likes'

class Comment(models.Model):
    content    = models.CharField(max_length=100)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True, null=True)
    user       = models.ForeignKey('user.User', on_delete=models.CASCADE)
    ootd       = models.ForeignKey('Ootd', on_delete=models.CASCADE)
    parent     = models.ForeignKey('self', on_delete=models.CASCADE, null=True, related_name='child')

    class Meta:
        db_table = 'comments'

class Follow(models.Model):
    follower  = models.ForeignKey('user.User', on_delete=models.CASCADE, related_name='from_user')
    followee = models.ForeignKey('user.User', on_delete=models.CASCADE, related_name='to_user')
    
    class Meta:
        db_table = 'follows'

