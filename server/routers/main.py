from fastapi import APIRouter, Depends, HTTPException
from starlette.status import HTTP_200_OK
from sqlalchemy import or_

from models import FindMovie, FindReview, Review, Movie, FindGenre, Image
from dtos import ReviewCreate, MovieCreate
from database import db_dependency

from datetime import datetime

main = APIRouter(prefix='/api')

@main.get("/index", status_code=HTTP_200_OK)
def get_data(db: db_dependency):
    movies = FindMovie.get_movies_ordered_by_release_date(db)
    movie_list = [{"id": i.id, "image_url": i.images[0].url} for i in movies if bool(i.images) and bool(i.images[0].url)]
    return {"message": ["Тут публикуются рецензии на фильмы.", movie_list]}


@main.get("/movies", status_code=HTTP_200_OK)
async def get_movies(db: db_dependency):
    movies_with_images = FindMovie.get_movies(db)

    movie_list = []

    for movie in movies_with_images:
        is_reviewed = bool(movie.reviews) and bool(movie.reviews[0])
        image_url = movie.images[0].url if bool(movie.images) and bool(movie.images[0]) else ""
        movie_dict = {
            "Movie ID": movie.id,
            "Title": movie.title,
            "Director": movie.director,
            "Actors": movie.actors,
            "Release Date": str(movie.release_date),
            "Rating": movie.rating,
            "Image URL": image_url,
            "Genre": [i.name for i in movie.genres],
            "is_reviewed": is_reviewed
        }
        movie_list.append(movie_dict)
    
    return {"message": movie_list}


@main.get("/review", status_code=HTTP_200_OK)
async def get_review(db: db_dependency):
    review = FindReview.get_review_random_order(db)
    formatted_time = review.date.strftime("%H:%M:%S %d.%m.%Y")
    if review:
        reviews_dict = [{
            "Review ID": review.id,
            "Title": review.movie.title,
            "Date": formatted_time,
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
    errors = []

    if not data.movie_id:
        errors.append("Movie ID is required")
    if not data.text:
        errors.append("Text is required")

    if errors:
        raise HTTPException(status_code=422, detail=errors)

    current_date = datetime.now()
    review = Review(movie_id=data.movie_id, text=data.text, date=current_date)

    db.add(review)
    db.commit()
    db.refresh(review)

    return review
    
@main.post("/create/movie", status_code=HTTP_200_OK)
async def create_movie(data: MovieCreate, db: db_dependency):
    errors = []

    if not data.title:
        errors.append("Title is required")
    if not data.director:
        errors.append("Director is required")
    if not data.actors:
        errors.append("Actors is required")
    if not data.release_date:
        errors.append("Release date is required")
    if not data.rating:
        errors.append("Rating is required")
    if not data.genres:
        errors.append("At least one genre is required")

    if errors:
        raise HTTPException(status_code=422, detail=errors)

    release_date = datetime.strptime(data.release_date, "%Y-%m-%d").date()

    movie = Movie(
        title=data.title,
        director=data.director,
        actors=data.actors,
        release_date=release_date,
        rating=data.rating
    )

    for genre_name in data.genres:
        genre = FindGenre.get_genre_by_name(genre_name, db)
        if not genre:
            errors.append(f"Genre '{genre_name}' not found")

        movie.genres.append(genre)

    if not data.url or not data.url:
        errors.append("Invalid or missing image URL")

    if errors:
        raise HTTPException(status_code=422, detail=errors)

    image = Image(url=data.url)
    movie.images.append(image)

    db.add(movie)
    db.commit()
    db.refresh(movie)

    return movie
    
@main.get("/review/{id}", status_code=HTTP_200_OK)
async def get_review_by_id(id: int, db: db_dependency):
    review = FindReview.get_review_by_id(id, db)
    if bool(review) and bool(review.id):
        return {"message": [{
            "Review ID": review.id,
            "Title": review.movie.title,
            "Date": review.date.strftime("%H:%M:%S %d.%m.%Y"),
            "Text": review.text,
            "Image URL": review.movie.images[0].url,
        }]}
    else:
        return {"message": [{
            "Review ID": "Не найдено.",
            "Title": "Не найдено.",
            "Date": "Не найдено.",
            "Text": "Не найдено.",
            "Image URL": "Не найдено.",
        }]}
    
@main.get("/movies/search/{query}")
def search_movies(query: str, db: db_dependency):
    keywords = query.split()
    movies = db.query(Movie).filter(or_(*[Movie.title.ilike(f"%{keyword}%") for keyword in keywords])).all()

    movie_list = []

    for movie in movies:
        movie_dict = {
            "Movie ID": movie.id,
            "Title": movie.title,
        }
        movie_list.append(movie_dict)
    
    return {"message": movie_list}