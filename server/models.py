from sqlalchemy import Column, Integer, String, Date, Float, CheckConstraint, ForeignKey, DateTime
from sqlalchemy.orm import relationship, Session
from sqlalchemy.dialects.postgresql import ENUM
from enum import Enum

from database import Base

class MovieGenreEnum(str, Enum):
    action = "Action"
    comedy = "Comedy"
    drama = "Drama"
    fantasy = "Fantasy"
    horror = "Horror"

class Movie(Base):
    __tablename__ = "movies"

    id = Column(Integer, primary_key=True)
    title = Column(String(255), nullable=False)
    director = Column(String(255), nullable=False)
    actors = Column(String(255), nullable=False)
    release_date = Column(Date, nullable=False)
    rating = Column(Float, CheckConstraint('rating >= 1 AND rating <= 10'))
    genre = Column(ENUM(MovieGenreEnum), nullable=False, default=MovieGenreEnum.horror)

    reviews = relationship("Review", back_populates="movie")
    images = relationship("Image", back_populates="movie")

class FindMovie:
    @staticmethod
    def get_movies(db: Session):
        return db.query(Movie).all()
    
    @staticmethod
    def get_movie_by_id(id: int, db: Session):
        return db.query(Movie).filter(Movie.id == id).first()

    @staticmethod
    def get_movie_by_title(title: str, db: Session):
        return db.query(Movie).filter(Movie.title == title).first()

class Review(Base):
    __tablename__ = "reviews"

    id = Column(Integer, primary_key=True)
    date = Column(DateTime, nullable=False)
    text = Column(String(2550), nullable=False)
    movie_id = Column(Integer, ForeignKey("movies.id"))
    
    movie = relationship("Movie", back_populates="reviews")

    def __repr__(self):
        return f"<Review(id={self.id}, content={self.content}, movie_id={self.movie_id})>"

class Image(Base):
    __tablename__ = "images"

    id = Column(Integer, primary_key=True)
    url = Column(String, nullable=False)
    type = Column(String, nullable=False)
    movie_id = Column(Integer, ForeignKey("movies.id"))

    movie = relationship("Movie", back_populates="images")

    def __repr__(self):
        return f"<Image(id={self.id}, url={self.url}, type={self.type}, movie_id={self.movie_id})>"