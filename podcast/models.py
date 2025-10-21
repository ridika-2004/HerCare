from django.db import models

class Podcast(models.Model):
    email = models.EmailField()
    title = models.CharField(max_length=255)
    link = models.URLField()
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.title} ({self.email})"
