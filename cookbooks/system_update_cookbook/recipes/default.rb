# Cookbook:: system_update_cookbook
# Recipe:: default
# Description: Automates system updates across Windows, macOS, and Fedora

if platform?('windows')
  # Windows Update via PowerShell
  powershell_script "Run Windows Update" do
    code <<-EOH
      Install-Module PSWindowsUpdate -Force -Scope CurrentUser
      Import-Module PSWindowsUpdate
      Get-WindowsUpdate -AcceptAll -Install -IgnoreReboot
    EOH
    action :run
  end

  # Check if a reboot is required
  powershell_script "Check and Perform Reboot on Windows" do
    code <<-EOH
      if (Test-Path "HKLM:\\SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\WindowsUpdate\\Auto Update\\RebootRequired") {
          Restart-Computer -Force
      }
    EOH
    action :run
  end

elsif platform?('mac_os_x')
  # macOS Software Update
  execute "Run macOS Software Update" do
    command "sudo softwareupdate -ia"
    action :run
  end

  # Check if a reboot is required on macOS
  execute "Check and Perform Reboot on macOS" do
    command "sudo shutdown -r now"
    only_if { ::File.exist?('/var/run/reboot-required') }
    action :run
  end

elsif platform?('fedora')
  # Fedora System Update
  execute "Run Fedora System Update" do
    command "sudo dnf update -y"
    action :run
  end

  # Check if a reboot is required on Fedora
  execute "Check and Perform Reboot on Fedora" do
    command "sudo shutdown -r now"
    only_if { ::File.exist?('/var/run/reboot-required') }
    action :run
  end

else
  Chef::Log.warn("Unsupported OS detected. No updates applied.")
end