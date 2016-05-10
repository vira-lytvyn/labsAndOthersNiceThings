# coding=utf-8
#
# MyFilms - персональная библиотека киномана.
# Использовалось: Python, PyGTK, SQLAlchemy, GVim, Banshee + дискография группы Scorpions :)
# proft // 2010 // http://proft.com.ua
# 

from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, scoped_session
from sqlalchemy import Column, Integer, Unicode, Date, MetaData, Boolean
import os

DB_FILE = 'films.db'

engine = create_engine('sqlite:///%s' % DB_FILE, echo=True)
Base = declarative_base()
Session = scoped_session(sessionmaker(bind=engine))

def init_db():
    """
    Создание БД.
    """

    Base.metadata.create_all(engine)

def exist_db():
    return os.path.exists(DB_FILE)

class Film(Base):
    """
    Модель 'Фильм'
    """

    __tablename__ = 'films'

    fid = Column(Integer, primary_key=True)
    title = Column(Unicode)
    genre = Column(Unicode)
    release = Column(Date)
    is_viewed = Column(Boolean)

    def __init__(self, title, genre, release, is_viewed):
        self.title = title
        self.genre = genre
        self.release = release
        self.is_viewed = is_viewed

    def __repr__(self):
        return "<Metadata('%s')>" % (self.title)
