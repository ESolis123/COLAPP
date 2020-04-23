from rest_framework import status
from rest_framework.decorators import api_view, authentication_classes, permission_classes
from rest_framework.response import Response
from rest_framework.authentication import SessionAuthentication, BasicAuthentication, TokenAuthentication
from rest_framework.permissions import IsAuthenticated, AllowAny
from django.contrib.auth.models import User
from .serializer import *
from .models import *

@api_view(('POST','GET'))
@permission_classes([AllowAny])
def createUser(request):
    username=request.data.get('username')
    email=request.data.get('email')
    password=request.data.get('password')
    user = User.objects.create_user(username, email, password)
    user.save()
    return Response(status=status.HTTP_201_CREATED)

@api_view(('POST','GET'))
@permission_classes([AllowAny])
def forgotUser(request,email):
    password='123456'
    u = User.objects.get(email= email)
    u.set_password(password)
    u.save()
    username= u.get_username()
    result=[username,password]
    #return Response(status=status.HTTP_200_OK)
    return Response(result)

@permission_classes([AllowAny])
def changePassword(request,username,password):
    u = User.objects.get(username= username)
    u.set_password('new password')
    u.save()

@api_view(['POST'])
@authentication_classes([SessionAuthentication, BasicAuthentication, TokenAuthentication])
@permission_classes([IsAuthenticated])
def crearProducto(request):
    """Crear un nuevo producto."""
    serializer = ProductoSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['GET'])
@authentication_classes([SessionAuthentication, BasicAuthentication, TokenAuthentication])
@permission_classes([IsAuthenticated])
def obtenerProductos(request):
    """Return the products"""
    if request.method == "GET":
        productos = Producto.objects.all().filter(status='Activo')
        serializer = ProductoSerializer(productos, many=True)
    return Response(serializer.data)

@api_view(['PUT'])
@authentication_classes([SessionAuthentication, BasicAuthentication, TokenAuthentication])
@permission_classes([IsAuthenticated])
def actualizarProducto(request, id):
    """Para desactivar un producto en especifico"""
    try:
        producto = Producto.objects.get(id=id)
        serializer = ProductoSerializer(producto, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    except:
        return Response(status=status.HTTP_404_NOT_FOUND)

@api_view(['POST'])
@authentication_classes([SessionAuthentication, BasicAuthentication, TokenAuthentication])
@permission_classes([IsAuthenticated])
def crearProveedor(request):
    """Crear un nuevo producto."""
    serializer = ProveedorSerializer(data=request.data)
    if serializer.is_valid():
        serializer.save()
        return Response(serializer.data, status=status.HTTP_201_CREATED)
    return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

@api_view(['GET'])
@authentication_classes([SessionAuthentication, BasicAuthentication, TokenAuthentication])
@permission_classes([IsAuthenticated])
def obtenerProveedores(request):
    """Return the products"""
    if request.method == "GET":
        proveedor = Proveedor.objects.all().filter(status='Activo')
        serializer = ProveedorSerializer(proveedor, many=True)
    return Response(serializer.data)

@api_view(['PUT'])
@authentication_classes([SessionAuthentication, BasicAuthentication, TokenAuthentication])
@permission_classes([IsAuthenticated])
def actualizarProveedor(request, id):
    """Para desactivar un producto en especifico"""
    try:
        proveedor = Proveedor.objects.get(id=id)
        serializer = ProveedorSerializer(proveedor, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    except:
        return Response(status=status.HTTP_404_NOT_FOUND)


@api_view(['GET'])
@authentication_classes([SessionAuthentication, BasicAuthentication, TokenAuthentication])
@permission_classes([IsAuthenticated])
def obtenerTiposProductos(request):
    """Return the products"""
    if request.method == "GET":
        tipos = Tipoproducto.objects.all()
        serializer = TipoproductoSerializer(tipos, many=True)
    return Response(serializer.data)

@api_view(['PUT'])
@authentication_classes([SessionAuthentication, BasicAuthentication, TokenAuthentication])
@permission_classes([IsAuthenticated])
def goal_detail_update(request, id_goal):
    """to update the details of the goal selected"""
    try:
        detail = GoalDetail.objects.get(goal_id_id=id_goal)
        serializer = GoalDetailSerializer(detail, data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    except:
        return Response(status=status.HTTP_404_NOT_FOUND)
