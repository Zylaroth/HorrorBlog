from pydantic import BaseModel
from typing import List

class ReviewCreate(BaseModel):
    movie_id: int
    text: str

class MovieCreate(BaseModel):
    title: str
    director: str
    actors: str
    release_date: str
    rating: float
    genres: List[str]
    url: str