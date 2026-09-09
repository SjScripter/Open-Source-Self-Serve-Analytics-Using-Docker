# Module 2: Docker Fundamentals

## 1. Learning Objectives
By the end of this module, you will understand:
- What Docker is and why it is critical for modern infrastructure.
- The difference between Docker Images and Containers.
- How Docker handles Networking and Storage (Volumes).
- How Environment Variables are used to configure containers safely.
- The purpose of Dockerfiles and Docker Compose.

## 2. Concept Explanation

### What is Docker?
In the past, setting up a database, a BI tool, and a Python environment meant installing dozens of specific libraries on your operating system. This often led to version conflicts and the dreaded "it works on my machine" syndrome.

**Docker** solves this by packaging software and all its dependencies into isolated units called **containers**. A container has everything it needs to run: code, runtime, system tools, and system libraries.

### Images vs. Containers
- **Image**: An image is a read-only template or a blueprint. For example, there is an official PostgreSQL image that contains the instructions to run PostgreSQL.
- **Container**: A container is a running instance of an image. If an image is the blueprint of a house, the container is the actual house you can walk into. You can spin up multiple containers from the same image.

### Ports
By default, containers are isolated. If a database is running inside a container on port 5432, your host computer cannot access it. 
We use **Port Mapping** to map a port on your host machine to a port inside the container. 
For example, mapping host port `5432` to container port `5432` allows you to connect to the database from your laptop.

### Volumes
Containers are ephemeral (temporary). If you delete a database container, all the data inside it is destroyed. 
To save data permanently, we use **Volumes**. A volume is a designated storage area on your host machine that the container uses. Even if the container is destroyed, the volume (and your data) persists. 

### Networks
By default, containers cannot talk to each other. We will create a **Docker Network**. When multiple containers are on the same network, they can communicate securely using their container names as hostnames. For example, Metabase can connect to PostgreSQL simply by pinging the hostname `postgres`.

### Environment Variables
Services need configuration. Instead of hard-coding passwords or configuration settings into files, we pass them into the container when it starts using **Environment Variables**. This is much more secure and flexible.

### Dockerfiles vs. Docker Compose
- **Dockerfile**: A text file containing the step-by-step instructions to build a custom Docker Image. We will use a Dockerfile later to build our custom Jupyter Notebook environment.
- **Docker Compose**: A YAML file (`docker-compose.yml`) that defines and runs multi-container Docker applications. Instead of running 4 separate complex Docker commands to start our ecosystem, we will write one Compose file and run `docker compose up -d`.

## 3. Why is this useful for our Analytics Stack?
- **Reproducibility**: You can share this repository with a colleague, and they can spin up the exact same ecosystem in minutes.
- **Isolation**: Our Python environment won't conflict with any Python libraries already installed on your host machine.
- **Easy Cleanup**: If you make a mistake, you can easily destroy the containers and start completely fresh without cluttering your OS.

## 4. Verification Steps
- Do you have Docker Desktop installed?
- Open your terminal and run `docker --version` to verify it is installed.
- Run `docker compose version` to verify Compose is available.

## 5. Summary
Docker provides the underlying infrastructure for our analytics ecosystem. We will use official images for PostgreSQL, pgAdmin, and Metabase, and build a custom image for Jupyter. Docker Compose will orchestrate them, networks will connect them, and volumes will save our data.

In the next module, we will apply these concepts by spinning up our central database: PostgreSQL.
