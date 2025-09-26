# Webcam Pi

An embedded Linux image that turns your Raspberry Pi Zero 2 W and camera module into a plug-and-play USB webcam.

## Table of Contents

1. [Required Hardware](#required-hardware)
2. [Supported Camera Sensors](#supported-camera-sensors)
3. [Features](#features)
4. [Installation](#installation)
5. [Setup](#setup)
6. [Usage](#usage)
7. [Building](#building)
8. [Credits](#credits)

## Required Hardware

| Part                    | Description           |
| ----------------------- | --------------------- |
| Raspberry Pi Zero 2 W   | Main compute module   |
| Supported camera sensor | CSI-2 camera module   |
| microSD card (≥100 MB)  | System storage        |
| USB-C cable         	  | USB-OTG data & power  |
| Case (optional)         | Protection & mounting |

## Supported Camera Sensors

- OV5647\*
- IMX219\*
- IMX708
- IMX477
- IMX500\*
- IMX296\*
- IMX290\*
- IMX519\*

**\*: Untested** – only the IMX708 has been verified to work. Other sensors are included in the kernel and supported by libcamera, but your mileage may vary.

## Features

- **Fast boot:** Less than 6 seconds to go from plugged in to functional.
- **Running status:** [GPIO 23](https://pinout.xyz/pinout/pin16_gpio23) goes `HIGH` whenever uvc-gadget is active.
- **Streaming status:** [GPIO 24](https://pinout.xyz/pinout/pin18_gpio24) goes `HIGH` whenever video is being streamed to host.
- **Pause/resume:** [GPIO 26](https://pinout.xyz/pinout/pin37_gpio26) freezes video on `HIGH` while keeping the stream alive.

## Installation

1. Download the latest image from the [Releases](https://github.com/elcalzado/webcampi/releases) page.
2. Insert your microSD card into your host computer.
3. Flash the image:
	- Linux/macOS:
   ```bash
   # Replace /dev/sdX with your card device
   sudo dd if=webcampi-<version>.img of=/dev/sdX
   ```
	- Windows:
   ```
   Use a tool like Balena Etcher or Raspberry Pi Imager
   ```

**Alternatively**, if you already have a Linux image on a Pi that supports OTG you can skip Webcam Pi and just follow the generic UVC-gadget setup guide: [uvc-gadget#installation](https://github.com/elcalzado/uvc-gadget#Installation)

## Setup

1. Insert the flashed microSD card into the Pi.
2. Connect the camera to the Pi’s camera port and secure the ribbon cable.
3. Plug a Micro-USB cable into the “USB” OTG port of the Pi and the other end into your host USB port.
4. On your host machine, a new video device should appear.

## Usage

Once the gadget is running, any standard UVC-compatible tool can access it:

```
Any webcam-enabled app: Zoom, OBS, Discord, etc. just pick the Webcam Pi as your camera.
```
...or...
```bash
# List video devices
v4l2‐ctl --list-devices

# Stream with VLC
vlc v4l2:///dev/video0

# Record with ffmpeg
ffmpeg -f v4l2 -i /dev/video0 -t 00:00:10 output.mkv
```

## Building

### Prerequisites

- Linux host (WSL is fine)
- Git and buildroot dependencies

### Clone

```bash
git clone --recursive https://github.com/elcalzado/webcampi.git
cd webcampi
```

### Build

```bash
# This will configure Buildroot and compile the kernel, rootfs, and image
./build.sh
```

When complete, the final SD card image will be in:

```
buildroot/output/images/sdcard.img
```

Flash it as described in [Installation](#installation).

## Credits

- [uvc-gadget](https://github.com/elcalzado/uvc-gadget): Fork of the main uvc-gadget with added GPIO functionality.
- [showmewebcam](https://github.com/showmewebcam/showmewebcam): Inspiration for this project and learning resource.
- [Buildroot](https://gitlab.com/buildroot.org/buildroot)
