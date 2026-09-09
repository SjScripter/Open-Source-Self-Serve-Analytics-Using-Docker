# Module 8: Complete Stack Configuration

## 1. Learning Objectives
By the end of this module, you will understand:
- How Docker Compose binds all our distinct services into a single ecosystem.
- How to manage the lifecycle of the stack (start, stop, reset).
- Common troubleshooting scenarios.

## 2. Concept Explanation

### The Final `docker-compose.yml`
Docker Compose is the glue that holds our ecosystem together. Let's review the high-level structure:

```yaml
version: '3.8'

services:
  postgres:
    # Uses official image, maps volumes for persistent data
  pgadmin:
    # Exposes port 5050, waits for postgres to be healthy
  metabase:
    # Exposes port 3000, waits for postgres to be healthy
  jupyter:
    # Builds a custom image, maps local notebooks folder, exposes port 8888

networks:
  analytics-net: # The bridge that allows them to talk via hostnames

volumes:
  postgres_data: # The persistent storage for the database
```

### Lifecycle Management
- **Start:** `docker compose up -d` (The `-d` runs it in "detached" mode so you can continue using your terminal).
- **Stop:** `docker compose down` (Safely stops and removes the containers. Your data is perfectly safe because of the `postgres_data` volume and your mapped `notebooks/` directory).
- **Hard Reset:** `docker compose down -v` (The `-v` destroys the `postgres_data` volume. Next time you start the stack, Postgres will run the `.sql` initialization scripts from scratch. This is incredibly useful for testing!).

## 3. Common Troubleshooting

- **Port Conflicts:** If `docker compose up` throws an error about a port being in use (e.g., `bind: address already in use`), it means another application on your computer is already using that port. Open `docker-compose.yml` and change the *first* number in the `ports:` array. (e.g., change `"5432:5432"` to `"5433:5432"`).
- **Database Connection Fails:** Ensure you are using `postgres` as the Hostname inside pgAdmin/Metabase/Jupyter, and NOT `localhost`.
- **Finding Logs:** If a container isn't behaving, use `docker logs <container_name>` (e.g., `docker logs metabase`) to read the internal console output.

## 4. Summary
You now understand the architecture, the code, and how to operate the Docker environment. In the final module, we will conduct a role-play demonstration to see why this stack is so powerful for an organization.
