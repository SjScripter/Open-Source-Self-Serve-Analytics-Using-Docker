# Module 7: Jupyter & Python Data Science

## 1. Learning Objectives
By the end of this module, you will understand:
- How to build a custom Docker image using a `Dockerfile`.
- How to connect Python (Pandas + SQLAlchemy) to our PostgreSQL database.
- How Data Analysts use Jupyter Notebooks in a self-serve environment.

## 2. Concept Explanation

### Why Jupyter and Python?
While Metabase is great for standard business dashboards, Data Scientists often need more power. They need to run statistical models, machine learning algorithms, or perform complex data wrangling. Python, specifically with the `pandas` library, is the industry standard for this. **Jupyter Notebooks** provide an interactive web environment to write and run this Python code block by block.

### Building a Custom Docker Image
Instead of pulling a pre-made image, we needed specific Python libraries. Look at `jupyter/Dockerfile`:
```dockerfile
FROM jupyter/scipy-notebook:python-3.10

COPY requirements.txt /tmp/
RUN pip install --no-cache-dir -r /tmp/requirements.txt

WORKDIR /home/jovyan/work
```
This tells Docker to:
1. Start with an official Jupyter image.
2. Copy our `requirements.txt` into the image.
3. Install the libraries we need (Pandas, SQLAlchemy, psycopg2).
4. Set the working directory.

In `docker-compose.yml`, instead of `image:`, we used `build: ./jupyter`. When you run `docker compose up`, Docker reads the Dockerfile, builds the custom image locally, and then runs the container.

### Volume Mapping for Code
In our compose file, we mapped `./jupyter/notebooks:/home/jovyan/work/notebooks`. 
This is crucial: any notebook you create inside the Jupyter web interface is instantly saved to your local hard drive. If you destroy the container, your code is safe!

## 3. Hands-On: Python Analysis
1. Run `docker compose up -d` to build and start the Jupyter container.
2. Run `docker logs jupyter` to find the authentication token. You will see a URL like `http://127.0.0.1:8888/lab?token=abc123...`.
3. Open that URL in your browser.
4. Navigate into the `notebooks` folder on the left sidebar and open `01-analysis.ipynb`.

### Understanding the Code
The notebook demonstrates how to securely connect to the database. Instead of hard-coding passwords in Python, it reads the same **Environment Variables** that Docker passed into the container!
```python
db_user = os.environ.get('POSTGRES_USER')
engine = create_engine(f'postgresql://{db_user}:{db_password}@postgres:5432/{db_name}')
```
Notice we connect to the host `postgres` just like we did with pgAdmin and Metabase.

## 4. Verification
Run the cells in the Jupyter notebook (Shift + Enter). You should see the SQL query execute, load into a Pandas DataFrame, and finally render a bar chart of Total Revenue by Category!

## 5. Troubleshooting

> [!WARNING]
> **Local vs. Docker Execution**
> Be careful about *where* you are running your notebook! If you open a notebook locally in VS Code using your computer's Python installation, the host `@postgres` will not work. You must change the connection string to use `@localhost:5432`. You should ideally run notebooks directly in the Jupyter web interface (`http://localhost:8888`) so the code executes inside the Docker network.

> [!TIP]
> **Missing Dependencies**
> If you encounter an error like `ModuleNotFoundError: No module named 'sqlalchemy'` inside the Jupyter web interface, it means the Docker image used a stale cache and didn't install the `requirements.txt` correctly. You can fix this instantly by adding a new cell at the top of your notebook and running:
> ```python
> !pip install sqlalchemy psycopg2-binary
> ```

## 6. Summary
You have now added an advanced analytics environment to your stack. The ecosystem is fully featured. In the next section, we'll review the complete stack and wrap everything up.
