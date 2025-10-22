from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
import json
from .utils import users_collection, hash_password, check_password

@csrf_exempt
def signup(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            name = data.get('name')
            email = data.get('email')
            password = data.get('password')
            confirm_password = data.get('confirm_password')

            if not name or not email or not password or not confirm_password:
                return JsonResponse({"status": "error", "message": "All fields are required"}, status=400)

            if password != confirm_password:
                return JsonResponse({"status": "error", "message": "Passwords do not match"}, status=400)

            if users_collection.find_one({"email": email}):
                return JsonResponse({"status": "error", "message": "Email already registered"}, status=400)

            hashed_pw = hash_password(password)
            users_collection.insert_one({
                "name": name,
                "email": email,
                "password": hashed_pw
            })

            return JsonResponse({"status": "success", "message": "User registered successfully"})
        except Exception as e:
            return JsonResponse({"status": "error", "message": str(e)}, status=500)
    return JsonResponse({"status": "error", "message": "Invalid request method"}, status=405)


@csrf_exempt
def login(request):
    if request.method == 'POST':
        try:
            data = json.loads(request.body)
            email = data.get('email')
            password = data.get('password')

            user = users_collection.find_one({"email": email})
            if not user:
                return JsonResponse({"status": "error", "message": "User not found"}, status=404)

            if check_password(password, user['password']):
                return JsonResponse({"status": "success", "message": "Login successful"})
            else:
                return JsonResponse({"status": "error", "message": "Incorrect password"}, status=401)
        except Exception as e:
            return JsonResponse({"status": "error", "message": str(e)}, status=500)
    return JsonResponse({"status": "error", "message": "Invalid request method"}, status=405)
