📌 Overview
This Chef cookbook automatically detects and applies the correct time zone on a system. It works across Windows, macOS, and Linux (Fedora) by using network-based detection and ensuring the system time is accurate.

✨ Features
✅ Accurately detects the user's time zone based on IP location
<br />
✅ Maps IANA time zones to Windows time zone names (prevents tzutil errors)
<br />
✅ Applies the correct time zone and syncs system time
<br />
✅ Works across Windows, macOS, and Fedora Linux
<br />
✅ No external API keys required
<br />

🛠 Supported Platforms
Windows (10, 11, Server 2016+)
macOS (Big Sur, Monterey, Ventura)
Linux (Fedora, RHEL, Ubuntu with timedatectl)

📜 How It Works
Detects the system’s public IP-based time zone using http://worldtimeapi.org/api/ip
Maps the IANA timezone format (e.g., America/New_York) to Windows time zones (e.g., Eastern Standard Time)
Applies the correct time zone if different from the current system setting
Ensures time synchronization is enabled to keep the clock accurate
