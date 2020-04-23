from django.urls import path, include
from . import views
from rest_framework.authtoken import views as aview

urlpatterns = [
    
    path('api-token-auth/', aview.obtain_auth_token),
    path('user/<username>/<email>/<password>/',views.createUser, name ='create'),
    path('forgot/<email>',views.forgotUser, name ='forgot'),
    path('create/',views.createUser, name ='createUser'),
    path('crearProducto/',views.crearProducto, name ='crearProducto'),
    path('obtenerProductos/',views.obtenerProductos, name ='obtenerProductos'),
    path('actualizarProducto/<int:id>/',views.actualizarProducto, name ='actualizarProducto'),
    path('crearProveedor/',views.crearProveedor, name ='crearProveedor'),
    path('obtenerProveedores/',views.obtenerProveedores, name ='obtenerProveedores'),
    path('actualizarProveedor/<int:id>/',views.actualizarProveedor, name ='actualizarProveedor'),
    path('obtenerTiposProductos/',views.obtenerTiposProductos, name ='obtenerTiposProductos'),
]