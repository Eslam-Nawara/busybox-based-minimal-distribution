# Busybox Based Minimal Distribution

This script automates the process of creating a minimal Linux distribution using the Linux kernel `linux-5.15.132` and BusyBox `busybox-1.36.1`. 
The resulting system is a basic, lightweight Linux environment that is run using QEMU virtual machine.

## Requirements 

- **Linux Environment:** This script is intended to be run on a Linux-based system.

- **Internet Connection:** The script downloads both Linux kernel and BusyBox, so an active internet connection is needed.

- **QEMU:** QEMU should be installed on your system to run the resulting Linux image.

## Usage

1. Clone or download this repository to your local machine.

2. Make sure that the script executable:

   ```sh
   chmod +x busybox.sh
   ```

3. Run the script:

   ```sh
   ./busybox.sh
   ```

## What the Script Does

1. **Downloads the Linux Kernel:** It downloads Linux kernel of version `5.15.132`.

2. **Extracts and Compiles the Kernel:** The script extracts the downloaded kernel source code and compiles it with default configuration options.

3. **Downloads BusyBox:** It downloads BusyBox of version `1.36.1`.

4. **Builds BusyBox in Static Mode:** The script configures and builds BusyBox in static mode, which makes BusyBox a single executable binary that includes many common Unix utilities.

5. **Creates an Initramfs:** It creates an initial RAM filesystem (initramfs) with a simple init script that mounts essential filesystems and starts a shell.

6. **Runs QEMU:** Finally, the script uses QEMU to launch the Linux kernel with the initramfs as the root filesystem, creating a minimal Linux environment.

## Customization

You can customize this script by changing the versions of the Linux kernel and BusyBox to meet your specific requirements. Additionally, you can modify the init script in the `initrd` directory to include additional setup steps or commands that you need for your minimal distribution.
