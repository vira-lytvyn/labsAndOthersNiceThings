from django.contrib.auth import login, logout
from django.contrib.auth.forms import AuthenticationForm
from django.shortcuts import render, HttpResponseRedirect
from django.views.decorators.csrf import csrf_exempt
from models import Movie, STATUS_CHOICE, MOVIES_GENRE
import sys


def user_login(request):
    if request.user.is_authenticated():
        return HttpResponseRedirect('/')

    form = AuthenticationForm(None, request.POST or None)
    nextpage = request.GET.get('next', '/')

    if form.is_valid():
        login(request, form.get_user())
        return HttpResponseRedirect(nextpage)

    return render(request, 'login.html', {'form': form, 'next': nextpage, 'page_title': 'Welcome'})


def user_logout(request):
    logout(request)
    return HttpResponseRedirect('/login/')


@csrf_exempt
def my_movies(request):
    watched_list = []
    will_watch_list = []
    favourite_list = []
    for movie in Movie.objects.all():
        if movie.status == 'w':
            watched_list.append(movie)
        elif movie.status == 'p':
            will_watch_list.append(movie)
        elif movie.status == 'f':
            favourite_list.append(movie)

    return render(request, "manager/my_movies.html", {
        'watched': watched_list, 'will_watch': will_watch_list, 'favourite': favourite_list
    })

@csrf_exempt
def view_movie(request, film_id):
    movie = Movie.objects.get(id=film_id)
    statuses = STATUS_CHOICE
    if request.method == 'POST':
        if 'rate_range' in request.POST:
            movie.personal_rate = request.POST['rate_range']
        elif 'new_status' in request.POST:
            movie.status = request.POST['new_status']
        movie.save()
    return render(request, "manager/movie.html", {'movie': movie, 'status_choice': statuses})


@csrf_exempt
def add_movie(request):
    user = request.user
    if user.is_authenticated():
        if user.is_superuser:
            if request.method == 'POST':
                try:
                    new_movie = Movie(
                        name=request.POST['name'],
                        publish_year=request.POST['publish_year'],
                        genre=request.POST['genre'],
                        status=request.POST['status'],
                        personal_rate=request.POST['rate'],
                        stars=request.POST['stars']
                    )
                    new_movie.save()
                    return HttpResponseRedirect('/movie/' + str(new_movie.pk) +'/')
                except:
                    print "Error: Cannot save the movie - " + str(sys.exc_info()[0])
            else:
                return render(request, "manager/add_movie.html", {'genres': MOVIES_GENRE})
        else:
            return render(request, '404.html')
    else:
        return HttpResponseRedirect('/login/')

