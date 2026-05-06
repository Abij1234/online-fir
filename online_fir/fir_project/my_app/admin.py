from django.contrib import admin
from .models import *
from django.core.mail import EmailMessage
from django.conf import settings


# Register your models here.
admin.site.register(Register)
admin.site.register(Police)
admin.site.register(FIRTimeline)
admin.site.register(sos)
admin.site.register(sos_status)
admin.site.register(Evidence)
admin.site.register(Donation)

# send mail when the fir is rejected by the admin

class FIRAdmin(admin.ModelAdmin):

    list_display = ['fir_number', 'name', 'crime_type', 'status', 'priority', 'created_at']

    def save_model(self, request, obj, form, change):

        if change:
            old_obj = FIR.objects.get(pk=obj.pk)

            if old_obj.status != "Rejected" and obj.status == "Rejected":

                if obj.email:

                    html_content = f"""
                    <html>
                    <body style="font-family: Arial, sans-serif; background-color: #f5f6fa; padding: 20px;">
                    
                        <div style="max-width:600px;margin:auto;background:white;border-radius:8px;
                        overflow:hidden;box-shadow:0 0 10px rgba(0,0,0,0.1);">

                            <div style="background:#0d6efd;color:white;padding:20px;text-align:center;">
                                <h2>Police Department</h2>
                                <p>Online FIR Management System</p>
                            </div>

                            <div style="padding:20px;">

                                <h3 style="color:#dc3545;">FIR Rejected</h3>

                                <p>Dear <strong>{obj.name}</strong>,</p>

                                <p>Your FIR has been <strong style="color:red;">Rejected</strong> by the Police Department.</p>

                                <hr>

                                <h4>FIR Details</h4>

                                <table style="width:100%;border-collapse:collapse;">
                                    <tr>
                                        <td style="padding:8px;border:1px solid #ddd;"><strong>FIR Number</strong></td>
                                        <td style="padding:8px;border:1px solid #ddd;">{obj.fir_number}</td>
                                    </tr>

                                    <tr>
                                        <td style="padding:8px;border:1px solid #ddd;"><strong>Crime Type</strong></td>
                                        <td style="padding:8px;border:1px solid #ddd;">{obj.crime_type}</td>
                                    </tr>

                                    <tr>
                                        <td style="padding:8px;border:1px solid #ddd;"><strong>Incident Place</strong></td>
                                        <td style="padding:8px;border:1px solid #ddd;">{obj.incident_place}</td>
                                    </tr>

                                    <tr>
                                        <td style="padding:8px;border:1px solid #ddd;"><strong>Status</strong></td>
                                        <td style="padding:8px;border:1px solid #ddd;color:red;">Rejected</td>
                                    </tr>

                                </table>

                                <br>

                                <p>If you need further clarification, please contact your nearest police station.</p>

                                <br>

                                
                            </div>

                            <div style="background:#f1f1f1;padding:15px;text-align:center;">
                                <p style="margin:0;">Police Department</p>
                                <small>This is an automated email. Do not reply.</small>
                            </div>

                        </div>

                    </body>
                    </html>
                    """

                    email = EmailMessage(
                        subject="FIR Rejected - Police Department",
                        body=html_content,
                        from_email=settings.EMAIL_HOST_USER,
                        to=[obj.email],
                    )

                    email.content_subtype = "html"
                    email.send()

        super().save_model(request, obj, form, change)


admin.site.register(FIR, FIRAdmin)
