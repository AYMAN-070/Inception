```markdown
# Developer Documentation - Inception

This documentation provides deep engineering insights for setting up, adjusting, and developing within the Inception infrastructure.

## Environment Setup & Configuration
To mirror this configuration or adapt it for development, follow this file hierarchy layout:

1.  **Prerequisites**: A Linux environment (or a Virtual Machine running Debian/Alpine) featuring modern installations of `docker` and `docker-compose`.
2.  **Configuration Structure**:
    * `srcs/docker-compose.yml`: Defines the structural relationships, networks, and mounting configurations.
    * `srcs/.env`: Holds runtime environment configurations. Keep this local and git-ignored.
    * `srcs/requirements/`: Contains individual configuration directories for `nginx/`, `mariadb/`, and `wordpress/`, each housing its dedicated `Dockerfile` and automated setup tools.

## Build and Lifecycle Sequences
The custom build workflows are managed entirely via the root automation engine (`Makefile`):

* **Full Compilation & Deployment**:
    ```bash
    make all
    ```
* **Total Hard-Reset (Purge Data & Volumes)**:
    ```bash
    make fclean
    ```
* **Rebuild from Scratch**:
    ```bash
    make re
    ```

## Useful Container & Volume Management Commands
When troubleshooting or developing scripts within the ecosystem, use these native Docker directives:

* **Inspect Live Log Outputs**:
    ```bash
    docker logs <container_name>
    ```
* **Enter a Container Session (Interactive Shell)**:
    ```bash
    docker exec -it <container_name> /bin/bash
    ```
* **Audit Network Topologies**:
    ```bash
    docker network ls
    docker network inspect srcs_inception_network
    ```
* **View Mounted Volume Storage Structures**:
    ```bash
    docker volume ls
    ```

## Data Storage Policy and Persistence Strategy
In strict compliance with the project specifications, bind mounts are banned for primary storage. Data persistence is engineered using **Docker Named Volumes**:

* **Database Files**: Managed by the volume configuration pointing internally to MariaDB data logs.
* **WordPress Core Source Files**: Synchronized via volume attachments sharing data structures with NGINX for fast processing.
* **Host Persistence Path**: On the physical host machine, both volumes securely save their raw storage maps inside the strict path: `/home/ayhammou/data/`.