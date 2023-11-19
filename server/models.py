from sqlalchemy import Column, Integer, String, Date, Float, CheckConstraint, ForeignKey, DateTime, desc, func, UniqueConstraint
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
    def get_movies_ordered_by_release_date(db: Session):
        return db.query(Movie).order_by(desc(Movie.release_date)).all()
    
class Review(Base):
    __tablename__ = "reviews"

    id = Column(Integer, primary_key=True)
    date = Column(DateTime, nullable=False)
    text = Column(String, nullable=False)
    movie_id = Column(Integer, ForeignKey("movies.id"))
    
    movie = relationship("Movie", back_populates="reviews")
    
    __table_args__ = (UniqueConstraint('movie_id'),)

class FindReview:
    @staticmethod
    def get_reviews(db: Session):
        return db.query(Review).all()

    @staticmethod
    def get_movies_random_order(db: Session):
        return db.query(Review).order_by(func.random()).first()
    
class Image(Base):
    __tablename__ = "images"

    id = Column(Integer, primary_key=True)
    url = Column(String, nullable=False)
    movie_id = Column(Integer, ForeignKey("movies.id"))

    movie = relationship("Movie", back_populates="images")