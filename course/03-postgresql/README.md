# Module 3: PostgreSQL

## 1. Learning Objectives
By the end of this module, you will understand:
- The role of PostgreSQL in our analytics stack.
- How Docker Compose spins up PostgreSQL.
- How we configure persistent volumes so data isn't lost.
- How initialization scripts work in the official Postgres image.

## 2. Concept Explanation

### What is PostgreSQL?
PostgreSQL (often just called Postgres) is an advanced, open-source object-relational database. In an analytics ecosystem, the database is the central hub. All our tools (pgAdmin, Metabase, Python) will connect to it to read data.

### The Docker Compose Configuration
Let's look at the `docker-compose.yml` file for the `postgres` service:

```yaml
  postgres:
    image: postgres:15
    container_name: postgres
    environment:
      POSTGRES_USER: ${POSTGRES_USER}
      POSTGRES_PASSWORD: ${POSTGRES_PASSWORD}
      POSTGRES_DB: ${POSTGRES_DB}
    volumes:
      - postgres_data:/var/lib/postgresql/data
      - ./postgres/init:/docker-entrypoint-initdb.d
    ports:
      - "5432:5432"
    networks:
      - analytics-net
```

- **image**: We specify `postgres:15` to ensure we get a stable, specific version rather than relying on `latest`, which could break unexpectedly in the future.
- **environment**: These variables tell the container what the admin username, password, and default database should be. They are loaded from the `.env` file.
- **volumes**: We map a named volume `postgres_data` to `/var/lib/postgresql/data` (where Postgres stores its files internally). This makes our data survive container restarts.
- **initialization**: We map our local `./postgres/init` folder to `/docker-entrypoint-initdb.d`. The official Postgres image is programmed to run any `.sql` scripts found in this folder the *very first time* the database boots up. This is how we automatically build our mock dataset!

## 3. Running PostgreSQL
Ensure you have copied `.env.example` to a new file named `.env`.

To start the database, open your terminal in the project root and run:
`docker compose up -d postgres`

## 4. Verification
Run `docker ps` to see if the container is running and healthy. You should see port `5432` mapped.

## 5. Summary
We now have a robust database running locally. In the next module, we will spin up a graphical user interface to look inside it.
