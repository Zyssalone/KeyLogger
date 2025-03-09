# Keylogger Simulation Toolkit

> A PowerShell-based keylogger designed for **educational** and **cybersecurity awareness** purposes only.

⚠️ **Disclaimer:** This project is intended for learning, research, and security awareness. It must not be used for illegal or unethical purposes. Misuse may result in legal consequences. Please act responsibly.

---

## Features
✅ Records keypresses with timestamps  
✅ Encrypts log files for secure storage  
✅ Detects potential sensitive data patterns (emails, passwords, etc.)  
✅ Supports offline logging when network connectivity is unavailable  
✅ Demonstrates common tactics used by attackers to improve defensive strategies  

---

## Educational Purpose
This project aims to:

🔹 Educate developers and system administrators about potential security risks  
🔹 Demonstrate how attackers exfiltrate data using PowerShell  
🔹 Help improve defenses against unauthorized data exfiltration  
🔹 Promote the importance of endpoint protection and security monitoring  

**I strongly discourage using this code for malicious purposes.**

---

## Installation & Usage

### Prerequisites
- Windows System (PowerShell required)
- Python 3.x (for the server)

### Step 1: Clone the Repository
```bash
git clone https://github.com/YourUsername/Keylogger-Simulation.git
cd Keylogger-Simulation
```

### Step 2: Run the Server
1. Install Python requirements if needed.
```bash
python3 server.py
```

### Step 3: Deploy the PowerShell Script
Run the following command in PowerShell:
```powershell
powershell.exe -ExecutionPolicy Bypass -File .\keylogger.ps1
```

**Ensure this is done in a safe, controlled environment like a virtual machine.**

---

## Project Structure
```
📂 Keylogger-Simulation
 ┣ 📜 keylogger.ps1       # PowerShell keylogger script
 ┣ 📜 server.py           # Python TCP server for receiving logs
 ┣ 📄 README.md           # Project documentation
 ┣ 📄 LICENSE             # License information
```

---

## How It Works
🔹 The PowerShell script logs keystrokes and stores them securely using AES encryption.  
🔹 Detected sensitive data (emails, passwords, URLs) is flagged and sent to the TCP server.  
🔹 The server captures and logs incoming data for security research.  

---

## Defensive Strategies
To protect systems from threats like this keylogger, consider the following:

✅ **Enable File Extensions:** Display full file extensions to avoid tricks like `image.jpg.ps1`.  
✅ **Use Endpoint Protection Solutions:** Tools such as Microsoft Defender, CrowdStrike, or SentinelOne can detect malicious scripts.  
✅ **Restrict PowerShell Execution:** Set PowerShell's Execution Policy to `Restricted` as a baseline defense.  
```powershell
Set-ExecutionPolicy Restricted
```
✅ **Monitor Network Traffic:** Use network analysis tools like Wireshark or Suricata to detect suspicious data exfiltration.  
✅ **Educate Users:** Awareness is the best defense against phishing and social engineering attacks.  

---

## ⚠️ Disclaimer
This project is intended for **educational** and **security awareness** purposes only.

✅ Use this code responsibly.  
✅ Test only on systems you own or have explicit permission to audit.  
❌ Do not use this project for malicious intent.  

I am **not responsible** for any misuse of this project or any resulting consequences.

---

## Contributing
Contributions to improve the project for security awareness are welcome. Please submit pull requests with detailed descriptions.

---

## License
This project is licensed under the [MIT License](LICENSE). Feel free to use, modify, and distribute for educational purposes.

