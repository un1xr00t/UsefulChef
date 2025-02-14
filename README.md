# Chef Automation Cookbooks

## 📌 Overview
This repository contains **two Chef cookbooks** designed to automate essential system tasks across Windows, macOS, and Linux:

1️⃣ **[`timezone_cookbook`](./timezone_cookbook/README.md)** → **Automatically detects and applies the correct system time zone**  
2️⃣ **[`system_update_cookbook`](./system_update_cookbook/README.md)** → **Automatically installs OS updates and reboots if required**  

These cookbooks are designed to work **at scale**, supporting thousands of machines in an enterprise environment.

---

## 🚀 Cookbooks Included

### **1️⃣ Timezone Configuration Cookbook (`timezone_cookbook`)**
✅ Detects the user's **correct time zone**  
✅ Applies the **appropriate time zone** for **Windows, macOS, and Fedora**  
✅ Synchronizes system time after applying the time zone  

📖 **[Read Full Documentation](./timezone_cookbook/README.md)**  

#### **🛠 Quick Run**
```sh
sudo chef-client --local-mode --runlist "recipe[timezone_cookbook::default]"
