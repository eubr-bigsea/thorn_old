from django.urls import path, include

from .views import ListUsersView, LoginView

urlpatterns = [
    path('users/', ListUsersView.as_view(), name="users-all"),
    path('auth/login/', LoginView.as_view(), name="auth-login")
]
