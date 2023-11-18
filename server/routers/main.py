from fastapi import APIRouter, Depends, HTTPException, File, UploadFile, HTTPException, Form
from starlette.status import HTTP_200_OK, HTTP_404_NOT_FOUND
from fastapi.staticfiles import StaticFiles
from sqlalchemy.orm import Session

from models import FindMovie, FindReview
from database import db_dependency

main = APIRouter(prefix='/api')
# main.mount("/uploads", StaticFiles(directory="uploads"), name="uploads")


@main.get("/index", status_code=HTTP_200_OK)
def get_data(db: db_dependency):
    movies = FindMovie.get_movies_ordered_by_release_date(db)
    movie_list = [i.images[0].url for i in movies]

    return {"message": ["Тут публикуются рецензии на фильмы.", movie_list]}


@main.get("/movies", status_code=HTTP_200_OK)
async def get_movies(db: db_dependency):
    movies_with_images = FindMovie.get_movies(db)

    movie_list = []

    for movie in movies_with_images:
        movie_dict = {
            "Movie ID": movie.id,
            "Title": movie.title,
            "Director": movie.director,
            "Actors": movie.actors,
            "Release Date": str(movie.release_date),
            "Rating": movie.rating,
            "Image URL": movie.images[0].url,
            "Genre": [i.name for i in movie.genres]
        }
        movie_list.append(movie_dict)
    
    return {"message": movie_list}


@main.get("/reviews", status_code=HTTP_200_OK)
async def get_reviews(db: db_dependency):
    review = FindReview.get_movies_random_order(db)
    if review:
        reviews_dict = {
            "Review ID": review.id,
            "Title": review.movie[0].title,
            "Date": review.date,
            "Text": review.text,
            "Image URL": review.movie[0].images[0].url,
        }
        return {"message": reviews_dict}
    else:
        return {"message": "No reviews found."}