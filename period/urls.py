from django.urls import path
from . import views

urlpatterns = [
    path("record/", views.record_period, name="record_period"),
    path("history/<str:email>/", views.get_period_history, name="get_period_history"),
]
