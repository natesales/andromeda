import logging
from os import environ

from fastapi import FastAPI
from rich.logging import RichHandler

VERSION = "0.0.1"

if environ.get("ANDROMEDA_DEVELOPMENT"):
    DEVELOPMENT = True
else:
    DEVELOPMENT = False

# Init rich logging handler
logging.basicConfig(level=("DEBUG" if DEVELOPMENT else "NOTSET"), format="%(message)s", datefmt="[%X]", handlers=[RichHandler()])
log = logging.getLogger("rich")

app = FastAPI(title="Andromeda Control Plane", version=VERSION)
