from pydantic import BaseModel

class ReviewCreate(BaseModel):
    movie_id: int
    text: str