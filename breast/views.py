from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.conf import settings
import json
import pymongo
from datetime import datetime

# ✅ Connect to MongoDB
client = pymongo.MongoClient(settings.MONGO_URI)
db = client[settings.MONGO_DB_NAME]  # Use database name from settings
collection = db["breast"]   # Collection name

@csrf_exempt
def record_progress(request):
    """
    Save or update user's breast self-check step progress
    """
    if request.method == "POST":
        try:
            data = json.loads(request.body)
            email = data.get("email")
            step_number = data.get("step_number")
            completed_items = data.get("completed_items", [])

            if not email or not step_number:
                return JsonResponse({"status": "error", "message": "Missing required fields"}, status=400)

            # ✅ Save progress in MongoDB
            collection.update_one(
                {"email": email, "step_number": step_number},
                {
                    "$set": {
                        "completed_items": completed_items,
                        "timestamp": datetime.utcnow()
                    }
                },
                upsert=True
            )

            return JsonResponse({"status": "success", "message": "Progress saved successfully!"})

        except Exception as e:
            return JsonResponse({"status": "error", "message": str(e)}, status=500)

    return JsonResponse({"status": "error", "message": "Invalid request method"}, status=405)


def get_progress_history(request, email):
    """
    Fetch all saved progress for a specific user
    """
    if request.method == "GET":
        try:
            # ✅ Fetch user progress
            records = list(collection.find({"email": email}, {"_id": 0}))
            return JsonResponse({"status": "success", "data": records}, safe=False)

        except Exception as e:
            return JsonResponse({"status": "error", "message": str(e)}, status=500)

    return JsonResponse({"status": "error", "message": "Invalid request method"}, status=405)
