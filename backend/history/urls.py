from django.urls import path
from . import views

urlpatterns = [
    path('<str:email>/', views.get_user_history, name='get_user_history'),
    path('pdf/<str:email>/', views.history_pdf, name='history_pdf'),
]
