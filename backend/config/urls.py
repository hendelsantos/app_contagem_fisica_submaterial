from django.contrib import admin
from django.contrib.auth import views as auth_views
from django.urls import path

from contagens import views

urlpatterns = [
    path("admin/", admin.site.urls),
    path("login/", auth_views.LoginView.as_view(template_name="contagens/login.html"), name="login"),
    path("logout/", auth_views.LogoutView.as_view(), name="logout"),
    path("", views.dashboard, name="dashboard"),
    path("contagens/<int:pk>/", views.detalhe_contagem, name="detalhe_contagem"),
    path("api/health/", views.health, name="health"),
    path("api/contagens/", views.api_contagens, name="api_contagens"),
    path("api/contagens/<int:pk>/", views.api_contagem_detalhe, name="api_contagem_detalhe"),
    path("api/public/contagens/", views.api_public_contagens, name="api_public_contagens"),
]
