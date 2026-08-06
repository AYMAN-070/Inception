*This project has been created as part of the 42 curriculum by ayhammou.*

# Inception - 42

## Description
This project is an introduction to system administration using Docker and Docker Compose. The goal is to build a complete, secure, and multi-container infrastructure from scratch using a personal Virtual Machine. Every service runs within its own dedicated container, built from the penultimate stable version of Debian or Alpine, ensuring strict isolation, performance, and reliability.

## Architecture & Technical Choices

### Mandatory Infrastructure
* **NGINX**: The unique entrypoint of the infrastructure, listening strictly on port 443 using TLSv1.2/TLSv1.3 protocols.
* **WordPress & PHP-FPM**: Pre-configured and installed automatically without hosting NGINX locally inside its container.
* **MariaDB**: The relational database, completely isolated from the outside network.

### Concept Comparisons

#### 1. Virtual Machines vs Docker
* **Virtual Machines (VM)**: Virtualize an entire hardware stack, including a full guest Operating System (OS). This results in high resource consumption (RAM, CPU, disk storage) and slow boot times.
* **Docker Containers**: Share the host OS kernel and isolate processes at the software level. They are lightweight, start instantly, and use significantly fewer resources.

#### 2. Secrets vs Environment Variables
* **Environment Variables (`.env`)**: Great for non-sensitive data configuration (domain names, database names, ports). They are easily readable by any system process or inspection command (`docker inspect`).
* **Docker Secrets**: Specifically designed for sensitive data (passwords, private keys). They are encrypted during transit and mounted securely in-memory inside the container, preventing leaks in repository logs or environment dumps.

#### 3. Docker Network vs Host Network
* **Docker Network (Bridge)**: Creates an isolated private network where containers can communicate using their service name as a hostname. It prevents external traffic from accessing internal services directly.
* **Host Network**: Removes network isolation between the container and the Docker host. The container binds directly to the host's ports, which exposes services directly and risks port conflicts.

#### 4. Docker Volumes vs Bind Mounts
* **Docker Named Volumes**: Managed entirely by Docker (`/var/lib/docker/volumes/`). They are abstracted from the host's direct filesystem structure, making them portable, secure, and highly optimized for databases.
* **Bind Mounts**: Link a direct, absolute path from the host machine to a container path. They depend heavily on the host’s directory structure and file permissions.

---

## Instructions

### Prerequisites
Ensure your configuration files are placed inside the `srcs/` directory, including your `.env` file containing all variables.

### Makefile Commands
* `make` / `make all`: Sets up folders, builds custom Docker images, and launches the application in detached mode.
* `make down`: Stops running containers without destroying persistent data.
* `make clean`: Removes containers and unused Docker images.
* `make fclean`: Triggers a full reset. Removes containers, volumes, networks, and wipes data folders on the host.
* `make re`: Performs a complete `fclean` followed by `make all`.

---

## How to Access the Website (Evaluation Guide)

As mandated by the subject, the platform is configured to be accessible only via the official domain name: `https://ayhammou.42.fr`. WordPress enforces this structure and will reject or redirect any naked IP requests like `127.0.0.1`.

### ⚠️ Overcoming the 42 Cluster Permission Limit
To map `ayhammou.42.fr` to the local machine, one would normally edit the host's `/etc/hosts` file. However, **students do not have `sudo` privileges on the physical 42 iMacs/PCs** to perform this action. 

To solve this natively without system modifications, we inject a temporary DNS routing rule directly inside the Chromium-based browser session.

### Execution Commands for Evaluation

**If testing on a 42 Mac (macOS):**

Close all active Chrome windows, open the Mac terminal, and execute:

```bash
/Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --host-resolver-rules="MAP ayhammou.42.fr 127.0.0.1"
```

**If testing on a local Windows machine:**

```bash
start chrome --host-resolver-rules="MAP ayhammou.42.fr 127.0.0.1"
```

Once the custom browser session opens, use these exact URLs to access the services:

- **WordPress Homepage:** https://ayhammou.42.fr
- **Admin Dashboard:** https://ayhammou.42.fr/wp-admin

> **Note:** Bypass the browser self-signed SSL certificate warning to proceed to the site.

---

## Resources & AI Usage

### References

- Docker Documentation
- WordPress CLI (WP-CLI) Commands Handbook
- NGINX Core HTTP Functionality

### AI Tool Usage Description

AI was leveraged as a pair-programming assistant during this project for specific tasks:

- **Debugging Script Sequences:** Assisting in analyzing conditional Bash logic inside `init.sh` to ensure `wp core install` waits properly for MariaDB's availability before execution.

- **Architecture Clarification:** Helping visualize network packet forwarding behavior between VirtualBox port-forwarding rules and NGINX routing.

### Limitations Encountered

AI lacks domain-specific workspace context and initially suggested hardcoded network URLs or infinite-loop solutions such as `tail -f`, which violate the 42 project requirements.

Every AI-generated suggestion was critically reviewed against the official subject, manually tested, and refactored when necessary to ensure full compliance with the 42 evaluation criteria.