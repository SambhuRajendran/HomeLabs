# Engineered Home Labs on Raspberry Pi

## Introduction
This project demonstrates setting up a home lab on Raspberry Pi devices to host various services, including Jellyfin, Plex, and Pi-Hole, utilizing Docker for easy deployment and management. Pi-Hole is specifically used for filtering and DNS, enhancing network performance and security.

## Getting Started

### Prerequisites
- A Raspberry Pi (model 2, 3, or 4) with Raspberry Pi OS installed.
- Docker and Docker Compose installed on your Raspberry Pi.
- Basic understanding of terminal commands and network configurations.



### Installation Steps

1. **Install Docker on Raspberry Pi:**
   Utilize the `get-docker.sh` script to install Docker on your Raspberry Pi for running containerized applications.
   ```bash
   curl -fsSL https://raw.githubusercontent.com/SambhuRajendran/HomeLabs/Docker/get-docker.sh | sh
