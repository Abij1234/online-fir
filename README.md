<h1 align="center">🚔 Online FIR System</h1>

<p align="center">
A web-based platform to file FIR complaints online, track case status, and send emergency SOS alerts with location.
</p>

<hr>

<h2>📌 Project Overview</h2>
<p>
The <b>Online FIR System</b> is designed to digitize the traditional FIR process. It allows users to submit complaints online,
track their FIR status, and send emergency SOS alerts. This system improves efficiency, reduces paperwork, and enables
faster police response.
</p>

<hr>

<h2>✨ Features</h2>

<h3>👤 User Features</h3>
<ul>
<li>📝 User Registration & Login</li>
<li>📂 File FIR complaints online</li>
<li>🔍 Track FIR status</li>
<li>👤 Profile management</li>
<li>🚨 Emergency SOS alert system</li>
<li>💬 Add detailed complaint descriptions</li>
</ul>

<h3>👮 Police/Admin Features</h3>
<ul>
<li>🧾 View all FIR complaints</li>
<li>📌 Assign FIR cases</li>
<li>✅ Approve / Reject FIR</li>
<li>🔄 Update FIR status (Pending, In Progress, Closed)</li>
<li>🚨 View SOS alerts</li>
<li>🗑️ Manage or delete SOS records</li>
</ul>

<h3>🚨 SOS Emergency System</h3>
<ul>
<li>One-click SOS button</li>
<li>Sends user details (Name, Phone)</li>
<li>📍 Sends live location (Latitude & Longitude)</li>
<li>Works even if GPS fails (fallback support)</li>
<li>Stored in database for police access</li>
</ul>

<h3>💰 Donation System</h3>
<ul>
<li>Charity donation page</li>
<li>Payment success flow</li>
<li>Supports public service initiatives</li>
</ul>

<hr>

<h2>🛠️ Tech Stack</h2>

<h3>💻 Frontend</h3>
<ul>
<li>HTML5</li>
<li>CSS3</li>
<li>Bootstrap 5</li>
<li>JavaScript (Fetch API)</li>
</ul>

<h3>⚙️ Backend</h3>
<ul>
<li>Python</li>
<li>Django Framework</li>
</ul>

<h3>🗄️ Database</h3>
<ul>
<li>SQLite (default)</li>
<li>Supports MySQL / PostgreSQL</li>
</ul>

<hr>

<h2>🧩 Project Modules</h2>
<ul>
<li>🔐 Authentication Module</li>
<li>📝 FIR Management Module</li>
<li>👮 Police Dashboard Module</li>
<li>🚨 SOS Alert Module</li>
<li>💰 Donation Module</li>
</ul>

<hr>

<h2>📂 Project Structure</h2>

<pre>
online-fir/
│
├── my_app/
│   ├── models.py
│   ├── views.py
│   ├── urls.py
│   ├── templates/
│   └── static/
│
├── fir_project/
│   ├── settings.py
│   ├── urls.py
│
├── db.sqlite3
└── manage.py
</pre>

<hr>

<h2>⚙️ Installation & Setup</h2>

<h3>1️⃣ Clone Repository</h3>
<pre>git clone https://github.com/your-username/online-fir.git
cd online-fir</pre>

<h3>2️⃣ Create Virtual Environment</h3>
<pre>python -m venv venv
venv\Scripts\activate</pre>

<h3>3️⃣ Install Dependencies</h3>
<pre>pip install -r requirements.txt</pre>

<h3>4️⃣ Run Migrations</h3>
<pre>python manage.py makemigrations
python manage.py migrate</pre>

<h3>5️⃣ Create Superuser</h3>
<pre>python manage.py createsuperuser</pre>

<h3>6️⃣ Run Server</h3>
<pre>python manage.py runserver</pre>

<hr>

<h2>🌐 Usage</h2>
<ul>
<li>Open browser → <b>http://127.0.0.1:8000/</b></li>
<li>Register or Login</li>
<li>File FIR or send SOS alert</li>
<li>Admin/Police manage FIRs from dashboard</li>
</ul>

<hr>

<h2>🔐 Security Features</h2>
<ul>
<li>CSRF Protection enabled</li>
<li>Django Authentication system</li>
<li>Frontend & Backend validation</li>
</ul>

<hr>

<h2>📸 Screenshots</h2>
<p>Add screenshots here:</p>
<ul>
<li>Home Page</li>
<li>FIR Form</li>
<li>Police Dashboard</li>
<li>SOS Popup</li>
</ul>

<hr>

<h2>🚀 Future Enhancements</h2>
<ul>
<li>📱 SMS alerts (Twilio integration)</li>
<li>📍 Google Maps integration</li>
<li>📧 Email notifications</li>
<li>📊 Analytics dashboard</li>
<li>🔔 Real-time alerts using WebSockets</li>
</ul>

<hr>

<h2>🤝 Contribution</h2>
<p>Contributions are welcome! Feel free to fork and submit a pull request.</p>

<hr>

<h2>📜 License</h2>
<p>This project is for educational purposes.</p>

<hr>

<h2>👨‍💻 Author</h2>
<p>
<b>Abijith P</b><br>
📧 abijithjr63@gmail.com
</p>

<hr>

<h2 align="center">⭐ If you like this project, give it a star!</h2>
