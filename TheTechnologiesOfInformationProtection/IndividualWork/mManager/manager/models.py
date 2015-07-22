from django.db import models

# Create your models here.

MOVIES_GENRE = (
    (1, 'Action'),
    (2, 'Adventure'),
    (3, 'Biopic'),
    (4, 'Comedy'),
    (5, 'Crime'),
    (6, 'Fantasy'),
    (7, 'Historical'),
    (8, 'Horror'),
    (9, 'Mystery'),
    (10, 'Philosophical'),
    (11, 'Romance'),
    (12, 'Saga'),
    (13, 'Science fiction'),
    (14, 'Thriller')
)

STATUS_CHOICE = (
    ('w', 'Watched'),
    ('p', 'Will watch'),
    ('f', 'Favourite')
)

class Movie(models.Model):
    name = models.CharField(max_length=255)
    genre = models.PositiveSmallIntegerField(blank=True, choices=MOVIES_GENRE, default=1)
    publish_year = models.IntegerField()
    status = models.CharField(max_length=1, choices=STATUS_CHOICE, default='1')
    personal_rate = models.PositiveSmallIntegerField(default=10)
    stars = models.CharField(max_length=255)

    def __unicode__(self):
        return str(self.name) + '_' + str(self.publish_year)

    def get_status_name(self):
        for key, value in STATUS_CHOICE:
            if self.status == key:
                return value
        return 'No status'

    def get_genre_name(self):
        for key, value in MOVIES_GENRE:
            if self.genre == key:
                return value
        return 'Unknown genre'