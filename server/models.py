from sqlalchemy import Column, Integer, String, Date, Float, CheckConstraint, ForeignKey, DateTime
from sqlalchemy.orm import relationship, Session
from database import Base

class MovieGenre(Base):
    __tablename__ = "movie_genres"

    movie_id = Column(Integer, ForeignKey("movies.id"), primary_key=True)
    genre_id = Column(Integer, ForeignKey("genres.id"), primary_key=True)

class Genre(Base):
    __tablename__ = "genres"

    id = Column(Integer, primary_key=True)
    name = Column(String(255), nullable=False, unique=True)

    movies = relationship("Movie", secondary="movie_genres", back_populates="genres")

class Movie(Base):
    __tablename__ = "movies"

    id = Column(Integer, primary_key=True)
    title = Column(String(255), nullable=False)
    director = Column(String(255), nullable=False)
    actors = Column(String(255), nullable=False)
    release_date = Column(Date, nullable=False)
    rating = Column(Float, CheckConstraint('rating >= 1 AND rating <= 10'))

    reviews = relationship("Review", back_populates="movie")
    images = relationship("Image", back_populates="movie")
    genres = relationship("Genre", secondary="movie_genres", back_populates="movies")

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
    
    @staticmethod
    def get_movies_with_images(db: Session):
        return db.query(Movie, Image).join(Image).all()
    
    @staticmethod
    def get_movie_with_image(title: str, db: Session):
        return db.query(Movie, Image).join(Image).filter(Movie.title == title).first()
    
class Review(Base):
    __tablename__ = "reviews"

    id = Column(Integer, primary_key=True)
    date = Column(DateTime, nullable=False)
    text = Column(String(2550), nullable=False)
    movie_id = Column(Integer, ForeignKey("movies.id"))
    
    movie = relationship("Movie", back_populates="reviews")

class Image(Base):
    __tablename__ = "images"

    id = Column(Integer, primary_key=True)
    url = Column(String, nullable=False)
    movie_id = Column(Integer, ForeignKey("movies.id"))

    movie = relationship("Movie", back_populates="images")