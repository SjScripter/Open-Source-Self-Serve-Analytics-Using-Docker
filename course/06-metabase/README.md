# Module 6: Metabase

## 1. Learning Objectives
By the end of this module, you will understand:
- Why Metabase is critical for self-serve analytics.
- How to connect Metabase to our internal PostgreSQL container.
- How to build a basic dashboard with multiple metrics (without writing SQL).

## 2. Concept Explanation

### What is Metabase?
Metabase is a simple, open-source Business Intelligence tool. It connects to your database and lets anyone ask questions about the data using a visual builder. It is designed to be user-friendly, allowing business analysts and executives to generate their own reports, saving data engineers countless hours.

### The Docker Compose Configuration
In our `docker-compose.yml`, we added a new block for Metabase:
```yaml
  metabase:
    image: metabase/metabase:v0.47.6
    container_name: metabase
    ports:
      - "3000:3000"
    networks:
      - analytics-net
    depends_on:
      postgres:
        condition: service_healthy
```
Like pgAdmin, Metabase runs on the `analytics-net` network, meaning it can reach PostgreSQL using the hostname `postgres`. It exposes its web interface on port `3000` of our host machine.

## 3. Setup and Connection

1. Run `docker compose up -d` in your terminal to start the full stack (now including Metabase).
2. Open your web browser and go to `http://localhost:3000`. Note: Metabase might take a minute or two to start up for the very first time.
3. Click **Let's get started**. Select your language and create an admin account for yourself.
4. On the **Add your data** step:
   - **Database type**: Select `PostgreSQL`.
   - **Name**: `Analytics DB` (or whatever you prefer).
   - **Host**: `postgres` (Using our Docker network!).
   - **Port**: `5432`
   - **Database name**: `analytics_db`
   - **Username**: `analytics_user`
   - **Password**: `your_secure_password_here` (from your `.env` file).
5. Click **Next** and finish the setup.

## 4. Building the Dashboard (Hands-on)
Let's build a simple Sales Analytics dashboard.

1. **Total Revenue Metric**:
   - Click **+ New** (top right) -> **Question**.
   - Select your database (`Analytics DB`), then select the `Order Items` table.
   - Click the **Summarize** button on the right. 
   - We need `quantity * unit_price`. Since we don't have a total column, Metabase allows custom expressions. Select **Custom Expression**, type `Sum([Quantity] * [Unit Price])`, and name it `Total Revenue`.
   - Click **Done** and then click the **Save** button. Add it to a new dashboard called "Sales Dashboard".

2. **Total Orders Metric**:
   - Click **+ New** -> **Question**.
   - Select the `Orders` table.
   - Click **Summarize** -> Metric: `Count`.
   - Save this and add it to your dashboard.

3. **Top Products (Bar Chart)**:
   - Click **+ New** -> **Question**.
   - Select `Order Items`.
   - Click **Summarize**. Under **Metric**, use the same `Sum([Quantity] * [Unit Price])` expression.
   - Under **Group by**, select the `Products -> Name` column. (Metabase is smart enough to auto-join the tables based on our foreign keys!).
   - Metabase should automatically suggest a Bar Chart. Save it to your dashboard.

## 5. Verification
Open your "Sales Dashboard". You should see your total revenue number, total order count, and a bar chart showing which mock products are selling the most. 

## 6. Summary
You have just built a completely functional, open-source BI layer on top of your database. Business users can now explore data safely. Next, we will cater to Data Analysts by setting up a Python Jupyter environment for advanced statistics.
