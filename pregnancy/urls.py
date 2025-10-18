from django.urls import path
from . import views

urlpatterns = [
    path('record-progress/', views.record_pregnancy_progress, name='record_pregnancy_progress'),
    path('progress/<str:email>/', views.get_pregnancy_progress, name='get_pregnancy_progress'),
]
