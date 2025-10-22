
from django.contrib import admin
from django.urls import path, include

urlpatterns = [
    path('admin/', admin.site.urls),
    path('user/', include('users.urls')),
    path("breast/", include("breast.urls")),
    path('pregnancy/', include('pregnancy.urls')),
    path('period/', include('period.urls')),
    path("podcast/", include("podcast.urls")),
    path('history/', include('history.urls')),

]
