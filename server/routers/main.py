from fastapi import APIRouter, Depends, HTTPException
from starlette.status import HTTP_200_OK

from models import FindMovie, FindReview, Review
from dtos import ReviewCreate
from database import db_dependency

from datetime import datetime

main = APIRouter(prefix='/api')

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


@main.get("/review", status_code=HTTP_200_OK)
async def get_review(db: db_dependency):
    review = FindReview.get_movies_random_order(db)
    if review:
        reviews_dict = [{
            "Review ID": review.id,
            "Title": review.movie.title,
            "Date": review.date,
            "Text": review.text,
            "Image URL": review.movie.images[0].url,
        }]
        return {"message": reviews_dict}
    else:
        return {"message": "No reviews found."}
    
@main.get("/reviews", status_code=HTTP_200_OK)
async def get_reviews(db: db_dependency):
    reviews = FindReview.get_reviews(db)
    if reviews:
        reviews_list = []

        for review in reviews:
            reviews_dict = {
                "Review ID": review.id,
                "Title": review.movie[0].title,
                "Date": review.date,
                "Text": review.text,
                "Image URL": review.movie[0].images[0].url,
            }
            reviews_list.append(reviews_dict)
            return {"message": reviews_dict}
        else:
            return {"message": "No reviews found."}

@main.post("/create/review", status_code=HTTP_200_OK)
async def create_review(data: ReviewCreate, db: db_dependency):
    try:
        current_date = datetime.now().date()
        review = Review(movie_id=data.movie_id, text=data.text, date=current_date)
        db.add(review)
        db.commit()
        db.refresh(review)
        return review
    except Exception as e:
        print("Error:", str(e))
        raise HTTPException(status_code=500, detail="Internal Server Error")