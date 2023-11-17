from fastapi import APIRouter, Depends, HTTPException, File, UploadFile, HTTPException, Form
from starlette.status import HTTP_200_OK, HTTP_404_NOT_FOUND
from fastapi.staticfiles import StaticFiles
from sqlalchemy.orm import Session

from models import Movie, FindMovie, Image
from database import db_dependency

main = APIRouter(prefix='/api')
# main.mount("/uploads", StaticFiles(directory="uploads"), name="uploads")


@main.get("/index")
def get_data():
    return {"message": "Тут публикуются рецензии на новые фильмы."}


@main.get("/movies", status_code=HTTP_200_OK)
async def get_movies(db: db_dependency):
    movies_with_images = FindMovie.get_movies_with_images(db)

    movie_list = []

    for movie, image in movies_with_images:
        movie_dict = {
            "Movie ID": movie.id,
            "Title": movie.title,
            "Director": movie.director,
            "Actors": movie.actors,
            "Release Date": str(movie.release_date),
            "Rating": movie.rating,
            "Image URL": image.url
        }
        movie_list.append(movie_dict)

    return {"message": movie_list}


@main.get("/movies/{id}", status_code=HTTP_200_OK)
async def get_movie_by_id(id: int, db: db_dependency):
    return FindMovie.get_movie_by_id(id, db)