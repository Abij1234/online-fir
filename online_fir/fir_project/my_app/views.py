from django.shortcuts import render, redirect, get_object_or_404
from django.contrib import messages
from django.contrib.auth.models import User
from django.contrib.auth import authenticate,login,logout
from .models import *
from django.http import HttpResponse
from django.contrib.auth.decorators import login_required
from django.core.mail import send_mail
from django.conf import settings
import json
import razorpay
from django.views.decorators.csrf import csrf_exempt
from django.http import JsonResponse
from django.core.mail import EmailMultiAlternatives
from django.template.loader import render_to_string
from django.db.models import Sum
from datetime import date



# Create your views here.
def home(request):
    return render(request, "home.html")

from django.db.models import Sum
from datetime import date
from .models import Donation

def policeDashboard(request):

    police = Police.objects.filter(user=request.user).first()
    firs = FIR.objects.none()
    soss = sos.objects.none()

    # FIR Filtering
    if police.post == "Constable":
        firs = FIR.objects.filter(assigned_officer=police)

    elif police.post == "Head Constable":
        firs = FIR.objects.filter(assigned_officer=police)

    elif police.post in ["ASI","SI"]:
        firs = FIR.objects.filter(police_station=police.station)

    elif police.post in ["CI","DySP"]:
        firs = FIR.objects.filter(district=police.district)
        
    elif police.post == "SP":
        firs = FIR.objects.all()


    # Donation Data
    donations = Donation.objects.all().order_by('-id')[:10]

    total_donation = Donation.objects.aggregate(
        Sum('amount')
    )['amount__sum'] or 0

    total_donors = Donation.objects.count()

    today_donation = Donation.objects.filter(
        created_at__date=date.today()
    ).aggregate(Sum('amount'))['amount__sum'] or 0

    month_donation = Donation.objects.filter(
        created_at__month=date.today().month
    ).aggregate(Sum('amount'))['amount__sum'] or 0


    return render(request, 'policeDashboard.html', {
        'police': police,
        'fir': firs,
        'soss': soss,
        'donations': donations,
        'total_donation': total_donation,
        'total_donors': total_donors,
        'today_donation': today_donation,
        'month_donation': month_donation
    })


def loginn(request):
    if request.method == 'POST':
        email = request.POST.get('email')
        password = request.POST.get('password')
        
        usr = authenticate(request, username=email, password=password)

        if usr is not None:

            police = Police.objects.filter(user=usr).first()
            if police:
                if police.status == 'Approved':
                    login(request, usr)
                    messages.success(request, "login successfully..")
                    return redirect('policedashboard')

                elif police.status == 'Rejected':
                    messages.warning(request, "You are rejected..")
                    return redirect('loginn')

                else:
                    messages.warning(request, "Wait for admin approval..")
                    return redirect('loginn')


            if Register.objects.filter(user=usr).exists():
                login(request, usr)
                messages.success(request, "Login success..")
                return redirect('home')
            
            if usr.groups.filter(name='admin group').exists():
                login(request,usr)
                messages.success(request, 'admin login success')
                return redirect('admin_dashboard')

        else:
            messages.warning(request, "Check email or password")
            return redirect('loginn')

    else:
        return render(request, "login.html")


def registerr(request):
    if request.method == 'POST':
        name = request.POST.get('name')
        email = request.POST.get('email')
        phone = request.POST.get('phone')
        address = request.POST.get('address')
        city = request.POST.get('city')
        state = request.POST.get('state')
        password = request.POST.get('password')
        repass = request.POST.get('confirm_password')
        if User.objects.filter(username=email).exists():
            messages.warning(request, 'user already exists')
            return redirect('register')
        if password != repass:
            messages.warning(request, 'both password not match try again..')
            return redirect('register')
        usr = User.objects.create_user(username=email,first_name=name,password=password)
        usr.save()
        obj = Register.objects.create(user=usr,name=name,email=email,phone=phone,address=address,city=city,state=state,password=password)
        obj.save()
        return redirect('loginn')
    return render(request, "register.html")

def logoutt(requset):
    logout(requset)
    return redirect('loginn')

def policeLogout(request):
    logout(request)
    messages.success(request, "sucessfully logout")
    return redirect('loginn')

def profile(request):
    usr = Register.objects.get(user=request.user)
    return render(request, "profile.html", {'usr':usr})

def update(request,id):
    usr = Register.objects.get(id=id)
    usrr = request.user
    if request.method  == 'POST':
        name = request.POST.get('name')
        phone = request.POST.get('phone')
        address = request.POST.get('address')
        state = request.POST.get('state')
        city = request.POST.get('city')
        password = request.POST.get('password')
        usrr.first_name = name
        usrr.password=password
        usrr.save()
        usr.name = name
        usr.phone = phone
        usr.address = address
        usr.state = state
        usr.city = city
        usr.password = password
        usr.save()
        return redirect('profile')
    return redirect('profile')


def policeRegister(request):
    if request.method == 'POST':
        name = request.POST.get('name')
        email = request.POST.get('email')
        phone = request.POST.get('phone')
        station = request.POST.get('station')
        district = request.POST.get('district')
        password = request.POST.get('password')
        repass = request.POST.get('confirm_password')
        if User.objects.filter(username=email).exists():
            messages.warning(request, "user already exist..")
            return redirect('policeregister')
        if password != repass:
            messages.warning(request, "both the password not match..")
            return redirect('policeregister')
        usr = User.objects.create_user(username=email,first_name=name,password=password)
        usr.save()
        police = Police.objects.create(user=usr,name=name,email=email,phone=phone,station=station,district=district,password=password)
        police.save()
        return redirect('loginn')
    return render(request, "policeregister.html")

@login_required
def fileFir(request):
    autofills = Register.objects.get(user=request.user) # for autofilling some fields
    if request.method == 'POST':
        name = request.POST.get('name')
        phone = request.POST.get('phone')
        email = request.POST.get('email')
        district = request.POST.get('district')
        state = request.POST.get('state')
        pincode = request.POST.get('pincode')
        address = request.POST.get('address')

        crimetype = request.POST.get('crime_type')
        inci_date = request.POST.get('incident_date')
        inci_time = request.POST.get('incident_time')
        inci_place = request.POST.get('incident_place')
        policestation = request.POST.get('police_station')

        desc = request.POST.get('description')

        suspectname = request.POST.get('suspect_name')
        suspectdetails = request.POST.get('suspect_details')

        # saving fir
        fir = FIR.objects.create(user=request.user,name=name,phone=phone,email=email,address=address,district=district,state=state,pincode=pincode,crime_type=crimetype,incident_date=inci_date,incident_time=inci_time,incident_place=inci_place,police_station=policestation,description=desc,suspect_name=suspectname,suspect_details=suspectdetails)
        
        # for multiple evidence file upload
        evidence = request.FILES.getlist('evidence') # get the entered files as an list
        for f in evidence:
            Evidence.objects.create(
                fir = fir,
                file = f
            )

        return redirect('filefir')
    return render(request, "file_fir.html", {'fill':autofills})

@login_required
def trackFirList(request):
    firs = FIR.objects.filter(user=request.user)
    return render(request,"track_fir_list.html",{"firs":firs})

@login_required
def trackFir(request,id):
    fir = FIR.objects.get(id=id,user=request.user) # the user is given for geting the fir  submited by the current user only 
    return render(request, "track_fir.html", {'fir':fir})

def detailed_fir(request,id):
    police = Police.objects.get(user=request.user)
    fir = FIR.objects.get(id=id)
    evidences = Evidence.objects.filter(fir=fir)

    timeline = FIRTimeline.objects.filter(fir=fir).order_by('-created_at')

    return render(request, "detailed_fir.html", {'fir':fir, 'police':police, 'timeline':timeline, 'evidences':evidences})

def assign_fir(request,id):
    police = Police.objects.get(user=request.user)
    fir = FIR.objects.get(id=id)

    officers = Police.objects.filter(station=police.station, status='Approved') # to get the officers form the same station approved only 

    if request.method == 'POST':
        officer_id = request.POST.get('officer')
        officer = Police.objects.get(id=officer_id)
        fir.assigned_officer = officer
        fir.status = 'Assigned'
        fir.save()

        FIRTimeline.objects.create(
            fir=fir,
            status='Assigned',
            updated_by = police,
            note=f"Assigned to {officer.name}"
        )
        return redirect('policedashboard')
    return render(request, "assign_btn.html", {'fir':fir, 'officers':officers})


def update_fir(request,id):

    police = Police.objects.get(user=request.user)
    fir = FIR.objects.get(id=id)

    status_choices = [
        ('Pending','Pending'),
        ('Approved','Approved'),
        ('Rejected','Rejected'),
        ('Assigned','Assigned'),
        ('Under Investigation','Under Investigation'),
        ('Evidence Collected','Evidence Collected'),
        ('Suspect Identified','Suspect Identified'),
        ('Closed','Closed'),
    ]

    if request.method == "POST":

        status = request.POST.get('status')
        note = request.POST.get('note')

        valid_status = [i[0] for i in status_choices]

        if status in valid_status:

            FIRTimeline.objects.create(
                fir=fir,
                status=status,
                updated_by=police,
                note=note
            )
            return redirect('policedashboard')
        else:
            messages.warning(request, f"the valid statuses are :\n {status_choices}")
            return redirect('updatefir')

    return render(request,'update_fir.html',{
        'fir':fir,
        'status_choices':status_choices
    })

def approve_fir(request,id):
    police =  Police.objects.get(user=request.user)
    fir = FIR.objects.get(id=id)
    FIRTimeline.objects.create(
        fir=fir,
        status='Approved',
        updated_by=police,
        note="case approved"
    )
    messages.success(request, "sucessfully approved")
    return redirect('policedashboard')

def close_fir(request,id):
    police = Police.objects.get(user=request.user)
    fir = FIR.objects.get(id=id)

    FIRTimeline.objects.create(
        fir=fir,
        status="Closed",
        updated_by=police,
        note="Case Closed"
    )
    messages.success(request, "closed case sucessfully")
    return redirect('policedashboard')


def send_sos(request):
    if request.method == 'POST':
        data = json.loads(request.body)

        name = data.get("name")
        phone = data.get("phone")
        message = data.get("message")
        latitude = data.get("latitude")
        longitude = data.get("longitude")

        default_status = sos_status.objects.first()  # or filter(status="Pending")

        sos.objects.create(
            name=name,
            phone=phone,
            message=message,
            latitude=latitude,
            longitude=longitude,
            status=default_status
        )

        return JsonResponse({"status": "success"})

    return JsonResponse({"status": "error"})
    
def sos_list(request):
    soslist = sos.objects.all().order_by('-created_at')

    return render(request, 'sos_list.html', {'sos':soslist})

def update_status_sos(request, id):
    soss = get_object_or_404(sos, id=id)
    statuses = sos_status.objects.all()

    return render(request, "update_sos.html", {
        'soss': soss,
        'key': statuses
    })


def updated_sos(request, id):

    soss = get_object_or_404(sos, id=id)
    statuses = sos_status.objects.all()

    if request.method == "POST":

        status_id = request.POST.get('status')

        if status_id:
            status = sos_status.objects.get(id=status_id)
            soss.status = status
            soss.save()

        return redirect('sos_list')

    return render(request, "update_sos.html", {
        'soss': soss,
        'key': statuses
    })

def delete_sos(request,id):
    soss = sos.objects.get(id=id)
    soss.delete()
    messages.success(request, "deleted sucessfully")
    return redirect('sos_list')


def donation_page(request):

    if request.method == "POST":

        name = request.POST.get('name')
        email = request.POST.get('email')
        amount = int(request.POST.get('amount'))

        if amount < 50:
            return render(request,'donation.html',{"error":"Minimum ₹50 required"})

        client = razorpay.Client(auth=(settings.RAZORPAY_KEY_ID,settings.RAZORPAY_KEY_SECRET))

        payment = client.order.create({
            'amount': amount * 100,
            'currency': 'INR',
            'payment_capture': '1'
        })

        donation = Donation.objects.create(
            name=name,
            email=email,
            amount=amount,
            order_id=payment['id']
        )

        context = {
            'payment': payment,
            'key': settings.RAZORPAY_KEY_ID,
            'name':name,
            'email':email,
            'amount':amount
        }

        return render(request,'donation.html',context)

    return render(request,'donation.html')


@csrf_exempt
def payment_success(request):

    order_id = request.POST.get('razorpay_order_id')
    payment_id = request.POST.get('razorpay_payment_id')

    donation = Donation.objects.get(order_id=order_id)

    donation.payment_id = payment_id
    donation.save()

    # Send Email
    subject = "Thank You for Your Donation ❤️"
    from_email = settings.EMAIL_HOST_USER
    to_email = donation.email

    html_content = render_to_string('donation_email.html',{
        'name':donation.name,
        'amount':donation.amount
    })

    email = EmailMultiAlternatives(
        subject,
        "",
        from_email,
        [to_email]
    )

    email.attach_alternative(html_content,"text/html")
    email.send()

    return render(request,'success.html')

@login_required
def admin_dashboard(request):
    # Stats
    total_users = User.objects.count()
    total_police = Police.objects.count()
    total_fir = FIR.objects.count()
    total_donation = Donation.objects.aggregate(Sum('amount'))['amount__sum'] or 0

    # Data lists
    pending_police = Police.objects.filter(status='Pending')
    firs = FIR.objects.all().order_by('-id')[:10]
    donations = Donation.objects.all().order_by('-id')[:10]
    users = User.objects.all().order_by('-id')[:10]

    context = {
        'total_users': total_users,
        'total_police': total_police,
        'total_fir': total_fir,
        'total_donation': total_donation,
        'pending_police': pending_police,
        'firs': firs,
        'donations': donations,
        'users': users
    }

    return render(request, 'admin_dashboard.html', context)

# manual admin police approval and rejection

def approve_police(request, id):
    police = Police.objects.get(id=id)
    police.status = "Approved"
    police.save()
    messages.success(request, "Police Approved Successfully")
    return redirect('admin_dashboard')


def reject_police(request, id):
    police = Police.objects.get(id=id)
    police.status = "Rejected"
    police.save()
    messages.warning(request, "Police Rejected")
    return redirect('admin_dashboard')

# detailed fir for admin
@login_required
def admin_detailed_fir(request, id):

    # 🔒 Allow only admin
    if not request.user.groups.filter(name='admin group').exists():
        return redirect('home')

    fir = get_object_or_404(FIR, id=id)

    # No police lookup here ❌ (this was your error)
    timeline = FIRTimeline.objects.filter(fir=fir)

    # If you have evidence model
    evidence = Evidence.objects.filter(fir=fir)

    return render(request, 'admin_detailed_fir.html', {
        'fir': fir,
        'timeline': timeline,
        'evidence': evidence
    })

# admin approve fir
def admin_approve_fir(request, id):
    if not request.user.groups.filter(name='admin group').exists():
        return redirect('home')

    fir = get_object_or_404(FIR, id=id)

    fir.status = "Approved"
    fir.save()

    FIRTimeline.objects.create(
        fir=fir,
        status='Approved',
        updated_by=None,
        note="Case approved by admin"
    )

    messages.success(request, "FIR approved successfully")
    return redirect('admin_dashboard')

# admin close fir
def admin_close_fir(request,id):
    if not request.user.groups.filter(name='admin group').exists():
        return redirect('home')
    
    fir =get_object_or_404(FIR, id=id)

    fir.status = 'Closed'
    fir.save()

    FIRTimeline.objects.create(
        fir=fir,
        status='Closed',
        updated_by=None,
        note="Case Closed by admin"
    )

    messages.success(request, "FIR closed successfully")
    return redirect('admin_dashboard')

