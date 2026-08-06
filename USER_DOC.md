# User Documentation - Inception

This document provides a guide for users and administrators to understand, run, and interact with the Inception services stack.

## Provided Services
The infrastructure deploys a fully operational and containerized WordPress website backed by a relational database and secured by a proxy gateway:
* **NGINX**: Serving as the only public entrypoint via secured HTTPS.
* **WordPress**: Run dynamically by PHP-FPM to serve the CMS web pages.
* **MariaDB**: Storing all user profiles, posts, and site settings securely in isolation.

## Starting and Stopping the Project
All commands must be executed from the root directory containing the `Makefile`.

* **To start the infrastructure**:
    ```bash
    make
    ```
    This will initialize the required folders, build the Docker images, and start the containers in the background.

* **To stop the infrastructure**:
    ```bash
    make down
    ```
    This cleanly stops the running containers without deleting any persistent data.

## Accessing the Website and Admin Panel
Due to security boundaries and WordPress configurations, the site can only be accessed using the official domain mapping.

1.  **Launch your browser with the temporary DNS rule** (as detailed in the main README).
2.  **Access the User Homepage**: Open `https://ayhammou.42.fr` in your browser.
3.  **Access the Admin Dashboard**: Navigate to `https://ayhammou.42.fr/wp-admin`.

> 💡 *Note: Since the SSL certificate is locally self-signed for development, you must manually bypass the browser's certificate privacy warning to load the pages.*

## Locating and Managing Credentials
* All operational configuration keys, database details, and root setup values are securely stored inside the `srcs/.env` file.
* **Crucial Rule**: The `.env` file contains sensitive local credentials and must never be pushed to a public Git repository. It is included in the `.gitignore` scheme.

## Checking Service Health
To verify that all three core systems are up and healthy, run:
```bash
docker ps