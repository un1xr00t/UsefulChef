# System Update Cookbook

## 📌 Overview
The `system_update_cookbook` is a Chef cookbook that **automatically installs OS updates** for:
- **✅ Windows**
- **✅ macOS**
- **✅ Fedora**

This ensures all systems remain **up to date, secure, and patched**.  
It also **reboots the system** if an update requires it.

---

## 🚀 Features
- **Automatic OS update detection**
- **Installs security and system updates**
- **Reboots if required**
- **Works with Chef Server or Standalone Mode**
- **Supports large-scale deployments**

---

## 🛠 Installation

### **1️⃣ Ensure Chef Client is Installed**
The cookbook requires **Chef Infra Client**. If Chef is already installed, skip this step.

Check if Chef is installed:
```sh
chef-client --version
