# Chef Automation Cookbooks

## 📌 Overview
This repository contains **two Chef cookbooks** designed to automate essential system tasks across Windows, macOS, and Linux:

1️⃣ **[`timezone_cookbook`](cookbooks/timezone_cookbook/recipes/README.md)** → **Automatically detects and applies the correct system time zone**  
2️⃣ **[`system_update_cookbook`](cookbooks/system_update_cookbook/recipes/README.md)** → **Automatically installs OS updates and reboots if required**  

These cookbooks are designed to work **at scale**, supporting thousands of machines in an enterprise environment.

---

## 🚀 Cookbooks Included

### **1️⃣ Timezone Configuration Cookbook (`timezone_cookbook`)**
✅ Detects the user's **correct time zone**  
✅ Applies the **appropriate time zone** for **Windows, macOS, and Fedora**  
✅ Synchronizes system time after applying the time zone  

📖 **[Read Full Documentation](./timezone_cookbook/README.md)**  

### **2️⃣ OS Auto-Update Cookbook (system_update_cookbook)**
✅ Installs **Windows updates** via `PSWindowsUpdate`  
✅ Installs **macOS updates** via `softwareupdate`  
✅ Installs **Fedora updates** via `dnf update`  
✅ Reboots the system **only if required**  

#### **🛠 Quick Run**
```sh
sudo chef-client --local-mode --runlist "recipe[timezone_cookbook::default]"
sudo chef-client --local-mode --runlist "recipe[system_update_cookbook::default]"
