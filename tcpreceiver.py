import socket
import threading

HOST = '0.0.0.0'   
PORT = 5050         
LOG_FILE = "received_logs.txt"

def handle_client(client_socket, address):
    print(f"[+] Connection from {address}")
    
    with client_socket:
        try:
            while True:
                data = client_socket.recv(1024).decode('utf-8')
                if not data:
                    break
                print(f"[DATA] {data}")
                with open(LOG_FILE, "a") as log_file:
                    log_file.write(f"{address} - {data}\n")
        except Exception as e:
            print(f"[-] Error handling client {address}: {e}")
    
    print(f"[-] Connection closed for {address}")

def start_server():
    server = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    server.bind((HOST, PORT))
    server.listen(5)
    
    print(f"[+] Server listening on {HOST}:{PORT}")
    
    while True:
        client_socket, address = server.accept()
        client_thread = threading.Thread(target=handle_client, args=(client_socket, address))
        client_thread.start()

if __name__ == "__main__":
    start_server()
