import os
import sqlite3

from flask import Flask, render_template, g
from flask_bootstrap import Bootstrap5

app = Flask(__name__, instance_relative_config=True)
app.config["BOOTSTRAP_SERVE_LOCAL"] = True
bootstrap = Bootstrap5(app)

# instance/app.db - Flask auto-creates the instance folder if missing
DB_PATH = os.path.join(app.instance_path, "app.db")
os.makedirs(app.instance_path, exist_ok=True)


def get_db():
    """Open a new database connection if there isn't one for this request."""
    if "db" not in g:
        g.db = sqlite3.connect(DB_PATH)
        g.db.row_factory = sqlite3.Row  # lets us access columns by name
    return g.db


@app.teardown_appcontext
def close_db(exception=None):
    db = g.pop("db", None)
    if db is not None:
        db.close()


@app.route("/")
def index():
    return render_template("index.html", db_path=DB_PATH)


@app.route("/preview")
def preview():
    """Show every table and its rows - a quick way to 'see inside' the db."""
    db = get_db()

    tables = [
        row["name"]
        for row in db.execute(
            "SELECT name FROM sqlite_master "
            "WHERE type='table' AND name NOT LIKE 'sqlite_%';"
        ).fetchall()
    ]

    data = {}
    for table in tables:
        rows = db.execute(f"SELECT * FROM {table};").fetchall()
        columns = rows[0].keys() if rows else [
            row[1] for row in db.execute(f"PRAGMA table_info({table});").fetchall()
        ]
        data[table] = {"columns": columns, "rows": rows}

    return render_template("preview.html", data=data)


if __name__ == "__main__":
    app.run(debug=True)
