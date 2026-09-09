# Module 4: pgAdmin

## 1. Learning Objectives
By the end of this module, you will understand:
- Why we need pgAdmin.
- How container-to-container networking works in Docker.
- How to connect a database GUI to a database running in a separate container.

## 2. Concept Explanation

### What is pgAdmin?
While you can manage PostgreSQL entirely through the command line (using `psql`), a graphical user interface makes it much easier to visualize table structures, manage user roles, and run exploratory queries. **pgAdmin** is the most popular open-source administration tool for PostgreSQL.

### Container-to-Container Networking
In our `docker-compose.yml`, both `postgres` and `pgadmin` are attached to `analytics-net`. 

Because they share a Docker network, they can talk to each other using their service names. 
If pgAdmin was running directly on your laptop, it would connect to `localhost:5432`. However, because pgAdmin is running *inside* a container, `localhost` means the pgAdmin container itself! To connect to PostgreSQL from the pgAdmin container, we tell it to connect to the hostname `postgres`.

### The depends_on block
We use a `depends_on` block with a `condition: service_healthy` for pgAdmin. This ensures that Docker Compose waits for the database to fully boot up and be ready to accept connections before it even tries to start pgAdmin.

## 3. Running pgAdmin
To start pgAdmin (assuming Postgres is already running, or starting them both together):
`docker compose up -d`

Open your web browser and go to `http://localhost:5050`. 
Log in using the email and password you set in the `.env` file (e.g., `admin@analytics.com`).

## 4. Connecting pgAdmin to PostgreSQL
1. Once logged in, click **Add New Server**.
2. **General Tab**: Name the connection anything you like (e.g., "Analytics DB").
3. **Connection Tab**: 
   - **Host name/address**: `postgres` (This is the crucial step! We use the Docker service name, not localhost).
   - **Port**: `5432`
   - **Maintenance database**: `analytics_db`
   - **Username**: `analytics_user`
   - **Password**: `your_secure_password_here` (check your `.env` file).
4. Click **Save**.

## 5. Verification
If successful, the server tree will expand. Navigate to Databases -> analytics_db -> Schemas -> public -> Tables. You should see the 4 e-commerce tables we created using our initialization scripts!

## 6. Summary
We have successfully deployed our database and an administration tool, and we connected them using Docker's internal networking. Next, we will explore the SQL data that was automatically generated.
