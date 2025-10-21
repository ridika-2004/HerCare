from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from django.conf import settings
import json
from datetime import datetime
import pymongo


# ✅ Connect to MongoDB
client = pymongo.MongoClient(settings.MONGO_URI)
db = client[settings.MONGO_DB_NAME]
period_collection = db["period"]


@csrf_exempt
def record_period(request):
    """
    Save a new period record (start_date, end_date) for a user.
    Calculates duration and cycle length automatically.
    """
    if request.method != "POST":
        return JsonResponse({"status": "error", "message": "Invalid request method"}, status=405)

    try:
        data = json.loads(request.body)
        email = data.get("email")
        start_date = data.get("start_date")  # e.g., "2025-10-15"
        end_date = data.get("end_date")      # e.g., "2025-10-18"

        if not email or not start_date or not end_date:
            return JsonResponse({"status": "error", "message": "Missing required fields"}, status=400)

        start_dt = datetime.strptime(start_date, "%Y-%m-%d")
        end_dt = datetime.strptime(end_date, "%Y-%m-%d")

        # Calculate period duration (in days)
        period_duration = (end_dt - start_dt).days + 1

        # Get last record to calculate cycle length
        last_record = period_collection.find_one({"email": email}, sort=[("start_date", -1)])

        if last_record:
            last_start = datetime.strptime(last_record["start_date"], "%Y-%m-%d")
            cycle_length = (start_dt - last_start).days
        else:
            cycle_length = 28  # default

        # Save new record
        period_collection.insert_one({
            "email": email,
            "start_date": start_date,
            "end_date": end_date,
            "period_duration": period_duration,
            "cycle_length": cycle_length,
            "created_at": datetime.utcnow().isoformat()
        })

        return JsonResponse({
            "status": "success",
            "message": "Period record saved successfully!",
            "data": {
                "email": email,
                "start_date": start_date,
                "end_date": end_date,
                "period_duration": period_duration,
                "cycle_length": cycle_length
            }
        })

    except Exception as e:
        return JsonResponse({"status": "error", "message": str(e)}, status=500)


def get_period_history(request, email):
    """
    Return all period records for the user (sorted by start_date)
    """
    if request.method != "GET":
        return JsonResponse({"status": "error", "message": "Invalid request method"}, status=405)

    try:
        records = list(period_collection.find({"email": email}, {"_id": 0}))
        records.sort(key=lambda x: x["start_date"])
        return JsonResponse({"status": "success", "data": records}, safe=False)

    except Exception as e:
        return JsonResponse({"status": "error", "message": str(e)}, status=500)
