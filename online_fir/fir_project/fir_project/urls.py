"""fir_project URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/2.0/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  path('', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  path('', Home.as_view(), name='home')
Including another URLconf
    1. Import the include() function: from django.urls import include, path
    2. Add a URL to urlpatterns:  path('blog/', include('blog.urls'))
"""
from django.contrib import admin
from django.urls import path
from my_app import views
from . import settings
from django.conf.urls.static import static

urlpatterns = [
    path('admin/', admin.site.urls),
    path('', views.home, name="home"),
    path('register/', views.registerr, name="register"),
    path('loginn/', views.loginn, name="loginn"),
    path('logoutt/', views.logoutt, name="logoutt"),
    path('profile/', views.profile, name="profile"),
    path('update/<int:id>/', views.update, name="update"),
    #space for the forget pass url
    path('policeregister/', views.policeRegister, name="policeregister"),
    path('policedashboard/', views.policeDashboard, name="policedashboard"),
    path('filefir/', views.fileFir, name="filefir"),
    path('trackfirlist/', views.trackFirList, name="trackfirlist"),
    path('trackfir/<int:id>/', views.trackFir, name="trackfir"),
    path('policelogout/', views.policeLogout, name="policelogout"),
    path('detailedfir/<int:id>/', views.detailed_fir, name="detailedfir"),
    path('assign/<int:id>/', views.assign_fir, name="assign"),
    path('updatefir/<int:id>/', views.update_fir, name="updatefir"),
    path('approvefir/<int:id>/', views.approve_fir, name="approvefir"),
    path('closefir/<int:id>/', views.close_fir, name="closefir"),
    path('send-sos/', views.send_sos, name="send-sos"),
    path('sos-list/', views.sos_list, name="sos_list"),
    path('update-sos/<int:id>/', views.update_status_sos, name="update_sos"),
    path('updated-sos/<int:id>/', views.updated_sos, name="updated_sos"),
    path('delete_sos/<int:id>/', views.delete_sos, name="delete_sos"),
    path('donate/',views.donation_page,name="donation"),
    path('success/',views.payment_success,name="success"),
    path('admin_dashboard/', views.admin_dashboard, name="admin_dashboard"),
    path('approve_police/<int:id>/', views.approve_police, name="approve_police"),
    path('reject_police/<int:id>/', views.reject_police, name="reject_police"),
    path('admin-fir/<int:id>/', views.admin_detailed_fir, name="admin_detailed_fir"),
    path('admin_approve_fir/<int:id>', views.admin_approve_fir, name="admin_approve_fir"),
    path('admin_close_fir/<int:id>/', views.admin_close_fir, name="admin_close_fir"),
]+static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
