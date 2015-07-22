from django.conf.app_template import admin
from django.conf.urls import patterns, include, url
import settings
# Uncomment the next two lines to enable the admin:
from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
    url(r'^admin/', include(admin.site.urls)),
)

urlpatterns += patterns('manager.views',
                       (r'^login/$', 'user_login'),
                       (r'^logout/$', 'user_logout'),
                       (r'^$', 'my_movies'),
                       (r'^movie/(?P<film_id>\d+)/$', 'view_movie'),
                       (r'^add_movie/$', 'add_movie'),
)