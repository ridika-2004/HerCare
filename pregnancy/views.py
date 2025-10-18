from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.conf import settings
import json
import pymongo
from datetime import datetime

client = pymongo.MongoClient(settings.MONGO_URI)
db = client[settings.MONGO_DB_NAME]  # Use database name from settings
collection = db["pregnancy"]   # Collection name


@csrf_exempt
def record_pregnancy_progress(request):
    """
    Save or update pregnancy month checklist progress
    """
    if request.method == "POST":
        try:
            data = json.loads(request.body)
            email = data.get("email")
            month = data.get("month")  # 1 to 9
            completed_items = data.get("completed_items", [])

            if not email or not month:
                return JsonResponse({"status": "error", "message": "Missing required fields"}, status=400)

            # Upsert progress record
            collection.update_one(
                {"email": email, "month": month},
                {
                    "$set": {
                        "completed_items": completed_items,
                        "updated_at": datetime.utcnow()
                    }
                },
                upsert=True
            )

            return JsonResponse({"status": "success", "message": "Pregnancy progress saved!"})

        except Exception as e:
            return JsonResponse({"status": "error", "message": str(e)}, status=500)

    return JsonResponse({"status": "error", "message": "Invalid request method"}, status=405)


def get_pregnancy_progress(request, email):
    """
    Fetch pregnancy progress for a specific user
    """
    if request.method == "GET":
        try:

            records = list(collection.find({"email": email}, {"_id": 0}))

            return JsonResponse({"status": "success", "data": records}, safe=False)

        except Exception as e:
            return JsonResponse({"status": "error", "message": str(e)}, status=500)

    return JsonResponse({"status": "error", "message": "Invalid request method"}, status=405)
