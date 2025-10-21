from django.urls import path
from . import views

urlpatterns = [
    path("add/", views.add_podcast, name="add_podcast"),
    path("list/<str:email>/", views.get_podcasts, name="get_podcasts"),
    path("delete/", views.delete_podcast, name="delete_podcast"),

]

