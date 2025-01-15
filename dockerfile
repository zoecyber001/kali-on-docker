```dockerfile
# Base image
FROM scratch

# Metadata
LABEL maintainer="Your Name <your.email@example.com>"
LABEL description="Build a Kali Linux container from an existing ISO file."

# Specify the ISO file path
ARG KALI_ISO

# Copy the ISO into the image
COPY ${KALI_ISO} /tmp/kali-linux.iso

# Setup tools
RUN apt-get update && apt-get install -y debootstrap xorriso squashfs-tools grub-pc-bin grub-efi-amd64-bin mtools && \
    rm -rf /var/lib/apt/lists/*

# Extract ISO content
RUN mkdir /mnt/kali && \
    mount -o loop /tmp/kali-linux.iso /mnt/kali && \
    mkdir /kali && \
    debootstrap --arch=amd64 kali-rolling /kali http://http.kali.org/kali && \
    umount /mnt/kali && \
    rm /tmp/kali-linux.iso

# Set working directory
WORKDIR /kali

# Default command
CMD ["/bin/bash"]
```
