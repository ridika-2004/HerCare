# history/views.py
from django.conf import settings
from django.http import JsonResponse
from django.views.decorators.csrf import csrf_exempt
from pymongo import MongoClient

client = MongoClient(settings.MONGO_URI)
db = client[settings.MONGO_DB_NAME]

# --- Helper function to convert ObjectId ---
def serialize_document(doc):
    doc["_id"] = str(doc["_id"])
    return doc

@csrf_exempt
def get_user_history(request, email):
    if not email:
        return JsonResponse({"success": False, "message": "Email is required"}, status=400)

    # Fetch history from each collection
    breast_history = list(db["breast"].find({"email": email}))
    pregnancy_history = list(db["pregnancy"].find({"email": email}))
    period_history = list(db["period"].find({"email": email}))

    # Serialize ObjectIds
    breast_history = [serialize_document(entry) for entry in breast_history]
    pregnancy_history = [serialize_document(entry) for entry in pregnancy_history]
    period_history = [serialize_document(entry) for entry in period_history]

    history_data = {
        "email": email,
        "breast_history": breast_history,
        "pregnancy_history": pregnancy_history,
        "period_history": period_history,
    }

    return JsonResponse({"success": True, "data": history_data})


# history/views.py
from django.http import HttpResponse
from django.conf import settings
from reportlab.pdfgen import canvas
from reportlab.lib.pagesizes import letter
from pymongo import MongoClient

client = MongoClient(settings.MONGO_URI)
db = client[settings.MONGO_DB_NAME]

def history_pdf(request, email):
    # Fetch history from MongoDB collections
    breast_history = list(db["breast"].find({"email": email}))
    pregnancy_history = list(db["pregnancy"].find({"email": email}))
    period_history = list(db["period"].find({"email": email}))

    # Create the HttpResponse object with PDF headers
    response = HttpResponse(content_type='application/pdf')
    response['Content-Disposition'] = f'attachment; filename="history_{email}.pdf"'

    pdf = canvas.Canvas(response, pagesize=letter)
    width, height = letter
    y = height - 50

    pdf.setFont("Helvetica-Bold", 16)
    pdf.drawString(50, y, f"{email}'s History Report")
    pdf.setFont("Helvetica", 12)
    y -= 40

    all_histories = [
        ("Breast", breast_history),
        ("Pregnancy", pregnancy_history),
        ("Period", period_history),
    ]

    idx = 1
    for category, entries in all_histories:
        for entry in entries:
            if y < 50:  # Start a new page if running out of space
                pdf.showPage()
                y = height - 50
            details = entry.get("details", "No details")  # Adjust field name
            timestamp = entry.get("created_at") or entry.get("timestamp", "")
            pdf.drawString(50, y, f"{idx}. [{category}] {details} at {timestamp}")
            y -= 20
            idx += 1

    pdf.showPage()
    pdf.save()
    return response

