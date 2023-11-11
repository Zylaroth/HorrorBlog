from fastapi import APIRouter, Depends, HTTPException
from starlette.status import HTTP_200_OK, HTTP_404_NOT_FOUND

from models import Movie, FindMovie
from database import db_dependency

main = APIRouter()

@main.get("/movies", status_code=HTTP_200_OK)
async def get_movies(db: db_dependency):
    return FindMovie.get_movies(db)


@main.get("/movies/{id}", status_code=HTTP_200_OK)
async def get_movie_by_id(id: int, db: db_dependency):
    return FindMovie.get_movie_by_id(id, db)