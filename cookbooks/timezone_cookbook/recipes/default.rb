# Cookbook:: timezone_cookbook
# Recipe:: default
# Description: Accurately determine and apply the correct time zone on Windows/macOS/Linux.

# Mapping of IANA time zones (from the API) to Windows time zone names
IANA_TO_WINDOWS_TZ = {
  "America/New_York" => "Eastern Standard Time",
  "America/Chicago" => "Central Standard Time",
  "America/Denver" => "Mountain Standard Time",
  "America/Los_Angeles" => "Pacific Standard Time",
  "America/Phoenix" => "Mountain Standard Time",
  "America/Anchorage" => "Alaskan Standard Time",
  "America/Honolulu" => "Hawaiian Standard Time",
  "Europe/London" => "GMT Standard Time",
  "Europe/Berlin" => "W. Europe Standard Time",
  "Asia/Tokyo" => "Tokyo Standard Time",
  "Asia/Kolkata" => "India Standard Time",
  "Australia/Sydney" => "AUS Eastern Standard Time",
  "UTC" => "UTC",
}.freeze

# Function to fetch the timezone from an online API
def fetch_online_timezone
  if platform?('windows')
    response = powershell_out!("Invoke-WebRequest -Uri \"http://worldtimeapi.org/api/ip\" -UseBasicParsing").stdout
  else
    response = shell_out("curl -s http://worldtimeapi.org/api/ip").stdout
  end

  match = response.match(/\"timezone\":\"(.*?)\"/)
  match ? match[1] : nil
end

if platform?('windows')
  # Fetch timezone from online API
  iana_timezone = fetch_online_timezone
  correct_timezone = IANA_TO_WINDOWS_TZ[iana_timezone] || "UTC"

  # Get the current system time zone
  current_timezone = powershell_out!("tzutil /g").stdout.strip

  Chef::Log.info("Detected IANA Time Zone: #{iana_timezone}")
  Chef::Log.info("Mapped Windows Time Zone: #{correct_timezone}")
  Chef::Log.info("Current Windows Time Zone: #{current_timezone}")

  if correct_timezone && current_timezone != correct_timezone
    execute "Set Correct Time Zone on Windows" do
      command "tzutil /s \"#{correct_timezone}\""
      action :run
    end
  end

  service "w32time" do
    action [:enable, :start]
  end

  execute "Sync Time on Windows" do
    command "w32tm /resync"
    action :run
  end

elsif platform?('mac_os_x') || platform?('fedora') || platform?('ubuntu')
  correct_timezone = fetch_online_timezone
  current_timezone = shell_out("timedatectl show --property=Timezone --value").stdout.strip

  Chef::Log.info("Detected IANA Time Zone: #{correct_timezone}")
  Chef::Log.info("Current Linux/macOS/Ubuntu Time Zone: #{current_timezone}")

  if correct_timezone && current_timezone != correct_timezone
    execute "Set Correct Time Zone on Linux/macOS/Ubuntu" do
      command "sudo timedatectl set-timezone \"#{correct_timezone}\""
      action :run
    end
  else
    Chef::Log.info("Time zone is already correct.")
  end

  # Ensure NTP synchronization is enabled for Ubuntu and other Linux distros
  execute "Enable NTP Sync on Linux/macOS/Ubuntu" do
    command <<-EOH
      sudo timedatectl set-ntp true
      sudo systemctl restart systemd-timesyncd.service
    EOH
    action :run
  end

else
  Chef::Log.warn("Unsupported OS detected. Timezone not set.")
end
