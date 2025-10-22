from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.conf import settings
import json
import pymongo
from datetime import datetime

# connect to MongoDB
client = pymongo.MongoClient(settings.MONGO_URI)
db = client[settings.MONGO_DB_NAME]
collection = db["podcasts"]  # MongoDB collection name

@csrf_exempt
def add_podcast(request):
    if request.method == "POST":
        try:
            data = json.loads(request.body)
            email = data.get("email")
            title = data.get("title")
            link = data.get("link")

            if not email or not title or not link:
                return JsonResponse({"status": "error", "message": "Missing fields"}, status=400)

            collection.insert_one({
                "email": email,
                "title": title,
                "link": link,
                "created_at": datetime.utcnow()
            })

            return JsonResponse({"status": "success", "message": "Podcast added successfully!"})

        except Exception as e:
            return JsonResponse({"status": "error", "message": str(e)}, status=500)

    return JsonResponse({"status": "error", "message": "Invalid method"}, status=405)


def get_podcasts(request, email):
    if request.method == "GET":
        try:
            records = list(collection.find({"email": email}, {"_id": 0}))
            return JsonResponse({"status": "success", "data": records}, safe=False)
        except Exception as e:
            return JsonResponse({"status": "error", "message": str(e)}, status=500)

@csrf_exempt
def delete_podcast(request):
    if request.method == "POST":
        try:
            data = json.loads(request.body)
            email = data.get("email")
            title = data.get("title")

            if not email or not title:
                return JsonResponse({"status": "error", "message": "Missing fields"}, status=400)

            result = collection.delete_one({"email": email, "title": title})
            if result.deleted_count == 0:
                return JsonResponse({"status": "error", "message": "Podcast not found"}, status=404)

            return JsonResponse({"status": "success", "message": "Podcast deleted"})

        except Exception as e:
            return JsonResponse({"status": "error", "message": str(e)}, status=500)

    return JsonResponse({"status": "error", "message": "Invalid method"}, status=405)
