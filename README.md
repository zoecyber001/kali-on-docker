# Running Kali Linux on Docker

## Why Use Docker Instead of VirtualBox?
Running Kali Linux on Docker offers several advantages:

- **Lightweight**: Containers share the host kernel, making them more resource-efficient.
- **Faster Startup**: Containers launch almost instantly compared to virtual machines.
- **Portability**: Docker images can run consistently on any system with Docker installed.
- **Easier Resource Management**: Specify CPU and memory usage directly in Docker.
- **Modern Integration**: Works seamlessly in CI/CD pipelines and with DevOps tools.

## Prerequisites
1. Install [Docker Desktop](https://www.docker.com/products/docker-desktop).
2. Basic understanding of Docker commands.
3. If using a custom Kali ISO file, ensure it is available on your system.

## Steps to Run Kali Linux on Docker

### Step 1: Pull the Official Kali Linux Docker Image
```bash
docker pull kalilinux/kali-rolling
```

### Step 2: Run the Docker Container
Run the following command to start a Kali container:
```bash
docker run -it --name kali-container kalilinux/kali-rolling /bin/bash
```
- `-it`: Interactive terminal mode.
- `--name`: Assign a custom name to the container.
- `/bin/bash`: Starts the container with a Bash shell.

### Step 3: Install Tools Inside the Container
You can install tools as needed. For example:
```bash
apt update && apt install -y nmap metasploit-framework
```

### Step 4: Persist Data Using Volumes (Optional)
To retain files or configurations, mount a volume:
```bash
docker run -it --name kali-container -v $(pwd)/kali-data:/data kalilinux/kali-rolling /bin/bash
```
- Replace `$(pwd)/kali-data` with your preferred directory.

### Step 5: Networking (Optional)
To enable advanced networking options, ensure Docker's bridge network is correctly configured.

## Using a Custom Kali ISO
If you already have a custom Kali Linux ISO file, you can build a Docker image using the provided `Dockerfile`.


#### Steps to Build and Run:
1. Place your custom Kali ISO file in the same directory as the `Dockerfile`.
2. Rename the ISO file to match the format `kali-linux-<version>.iso` (e.g., `kali-linux-2023.4.iso`) or use its current name.
3. Build the Docker image by specifying the ISO file name:
   ```bash
   docker build -t custom-kali --build-arg KALI_ISO=<your-iso-file-name> .
   ```
   Replace `<your-iso-file-name>` with the actual file name of your ISO.
4. Run the container:
   ```bash
   docker run -it --name custom-kali-container custom-kali
   ```

## Comparison: Docker vs. VirtualBox
| Feature                | Docker                         | VirtualBox                     |
|------------------------|--------------------------------|--------------------------------|
| **Performance**        | Lightweight, uses host kernel | Resource-heavy, full OS boot  |
| **Startup Time**       | Instant                       | Slow (OS boot required)       |
| **Resource Usage**     | Minimal                       | High                          |
| **Portability**        | High                          | Limited                       |
| **Integration**        | DevOps-friendly               | Not ideal for CI/CD           |
| **GUI Support**        | Limited without extra setup   | Full GUI support              |

## FAQ

### How do I update tools in the container?
Run `apt update && apt upgrade` within the container.

### How can I run GUI applications like Burp Suite in Docker?
Use an X server on your host machine to forward the GUI:
```bash
docker run -it -e DISPLAY=<host_ip>:0 -v /tmp/.X11-unix:/tmp/.X11-unix kalilinux/kali-rolling
```

### Can I save the state of the container?
Yes, commit the container as a new image:
```bash
docker commit kali-container my-kali-image
```

### How can I use a custom Kali ISO file?
Follow the instructions in Step 6 to build and run a Docker container using your ISO file.

## Contributions
Feel free to contribute by submitting pull requests or issues. Let's make this guide even better!
