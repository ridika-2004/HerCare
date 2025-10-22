from django.urls import path
from . import views

urlpatterns = [
    path("record/", views.record_progress, name="record_progress"),
    path("history/<str:email>/", views.get_progress_history, name="get_progress_history"),
]
