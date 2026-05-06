from django.db import models
from django.contrib.auth.models import User
from datetime import datetime

class Register(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    name = models.CharField(max_length=50, null=True, blank=True)
    email = models.EmailField()
    phone = models.CharField(max_length=15, null=True, blank=True)
    address = models.TextField(null=True, blank=True)
    city = models.CharField(max_length=50, null=True, blank=True)
    state = models.CharField(max_length=50, null=True, blank=True)
    password = models.CharField(max_length=60, null=True, blank=True)
    def __str__(self):
        return self.name
    

from django.db import models
from django.contrib.auth.models import User


class Police(models.Model):

    POST_CHOICES = (
        ('Constable', 'Constable'),
        ('Head Constable', 'Head Constable'),
        ('ASI', 'Assistant Sub Inspector'),
        ('SI', 'Sub Inspector'),
        ('CI', 'Circle Inspector'),
        ('DySP', 'Deputy Superintendent'),
        ('SP', 'Superintendent'),
    )
    STATUS_CHOICES = (
        ('Pending', 'Pending'),
        ('Approved', 'Approved'),
        ('Rejected', 'Rejected'),
    )
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    name = models.CharField(max_length=100,null=True,blank=True)
    email = models.EmailField(null=True,blank=True)
    phone = models.CharField(max_length=15,null=True,blank=True)
    badge_id = models.CharField(
        max_length=20,
        unique=True,
        null=True,
        blank=True
    )
    post = models.CharField(
        max_length=50,
        choices=POST_CHOICES,
        null=True,
        blank=True
    )
    station = models.CharField(max_length=100, null=True, blank=True)
    district = models.CharField(max_length=100, null=True, blank=True)
    status = models.CharField(
        max_length=20,
        choices=STATUS_CHOICES,
        default='Pending'
    )
    password = models.CharField(max_length=50, null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    def __str__(self):
        return self.name
    

class FIR(models.Model):

    STATUS_CHOICES = (
        ('Pending','Pending'),
        ('Approved','Approved'),
        ('Rejected','Rejected'),
        ('Under Investigation','Under Investigation'),
        ('Closed','Closed'),
    )

    CRIME_CHOICES = (
        ('Theft','Theft'),
        ('Robbery','Robbery'),
        ('Missing Person','Missing Person'),
        ('Cyber Crime','Cyber Crime'),
        ('Assault','Assault'),
        ('Domestic Violence','Domestic Violence'),
        ('Harassment','Harassment'),
        ('Accident','Accident'),
        ('Fraud','Fraud'),
        ('Kidnapping','Kidnapping'),
        ('Murder','Murder'),
        ('Sexual Harassment','Sexual Harassment'),
        ('Other','Other'),
    )

    PRIORITY_CHOICES = (
        ('Normal','Normal'),
        ('Urgent','Urgent'),
        ('Emergency','Emergency'),
    )

    user = models.ForeignKey(User,on_delete=models.CASCADE)

    # Complainant Details
    name = models.CharField(max_length=100, null=True, blank=True)
    phone = models.CharField(max_length=15, null=True, blank=True)
    email = models.EmailField(null=True, blank=True)
    address = models.TextField(null=True, blank=True)
    district = models.CharField(max_length=100, null=True, blank=True)
    state = models.CharField(max_length=100, null=True, blank=True)
    pincode = models.CharField(max_length=10, null=True, blank=True)

    # Incident Details
    crime_type = models.CharField(max_length=100,choices=CRIME_CHOICES)
    incident_date = models.DateField(null=True, blank=True)
    incident_time = models.TimeField(null=True, blank=True)
    incident_place = models.CharField(max_length=200, null=True, blank=True)
    police_station = models.CharField(max_length=100, null=True, blank=True)

    # Description
    description = models.TextField(null=True, blank=True)

    # Suspect Details
    suspect_name = models.CharField(max_length=100,null=True,blank=True)
    suspect_details = models.TextField(null=True,blank=True)


    # Priority
    priority = models.CharField(
        max_length=20,
        choices=PRIORITY_CHOICES,
        default="Normal"
    )

    # Emergency Flag
    is_emergency = models.BooleanField(default=False)

    # FIR Status
    status = models.CharField(
        max_length=50,
        choices=STATUS_CHOICES,
        default="Pending"
    )

    # FIR Number
    fir_number = models.CharField(max_length=30,null=True,blank=True)

    # Assigned Officer
    assigned_officer = models.ForeignKey(
        Police,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="assigned_officer"
    )

    # Assigned By
    assigned_by = models.ForeignKey(
        Police,
        on_delete=models.SET_NULL,
        null=True,
        blank=True,
        related_name="assigned_by"
    )

    # Timestamps
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)


    def save(self, *args, **kwargs):

        # Emergency Auto Detect
        if self.priority == "Emergency":
            self.is_emergency = True

        # FIR Number Generate
        if not self.fir_number:

            last_fir = FIR.objects.order_by('-id').first()

            if last_fir:
                new_id = last_fir.id + 1
            else:
                new_id = 1

            year = datetime.now().year

            self.fir_number = f"KL-{year}-{str(new_id).zfill(4)}"

        super().save(*args, **kwargs)


    def __str__(self):
        return f"{self.fir_number} - {self.name}"
    
# for multiple evidence file upload 
class Evidence(models.Model):

    fir = models.ForeignKey(
        FIR,
        on_delete=models.CASCADE,
        related_name="evidences"
    )

    file = models.FileField(upload_to="fir_evidence/")

    uploaded_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"Evidence for {self.fir.fir_number}"
    
class FIRTimeline(models.Model):

    STATUS_CHOICES = (
        ('Pending','Pending'),
        ('Approved','Approved'),
        ('Rejected','Rejected'),
        ('Assigned','Assigned'),
        ('Under Investigation','Under Investigation'),
        ('Evidence Collected','Evidence Collected'),
        ('Suspect Identified','Suspect Identified'),
        ('Closed','Closed'),
    )

    fir = models.ForeignKey(FIR,on_delete=models.CASCADE)

    status = models.CharField(
        max_length=50,
        choices=STATUS_CHOICES
    )

    updated_by = models.ForeignKey(
        Police,
        on_delete=models.SET_NULL,
        null=True,
        blank=True
    )

    note = models.TextField(null=True,blank=True)

    created_at = models.DateTimeField(auto_now_add=True)


    def save(self, *args, **kwargs):
        self.fir.status = self.status
        self.fir.save()
        super().save(*args, **kwargs)


    def __str__(self):
        return f"{self.fir.fir_number} - {self.status}"
    
class sos_status(models.Model):
    status = models.CharField(max_length=20, null=True, blank=True)
    def __str__(self):
        return self.status
    
class sos(models.Model):
    name = models.CharField(max_length=50, null=True, blank=True)
    phone = models.CharField(max_length=15, null=True, blank=True)
    message = models.TextField(null=True, blank=True)
    latitude = models.CharField(max_length=50, null=True, blank=True)
    longitude = models.CharField(max_length=50, null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    status = models.ForeignKey(sos_status, on_delete=models.CASCADE, null=True, blank=True)

class Donation(models.Model):
    name = models.CharField(max_length=100)
    email = models.EmailField()
    amount = models.IntegerField()
    order_id = models.CharField(max_length=200,null=True,blank=True)
    payment_id = models.CharField(max_length=200,null=True,blank=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return self.name
    

class Admin(models.Model):
    name = models.CharField(max_length=50, null=True, blank=True)
    password = models.CharField(max_length=50, null=True, blank=True)

    def __str__(self):
        return self.name