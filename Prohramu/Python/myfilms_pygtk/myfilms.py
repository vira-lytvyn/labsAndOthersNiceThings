# coding=utf-8
#
# MyFilms - персональная библиотека киномана.
# Использовалось: Python, PyGTK, SQLAlchemy, GVim, Banshee + дискография группы Scorpions :)
# proft // 2010 // http://proft.com.ua
# 

from models import *
import gtk
import datetime

class App(gtk.Window):
    """
    Класс основного окна.
    """

    def __init__(self):
        super(App, self).__init__()

        # параметры окна
        self.set_size_request(500, 350)
        self.set_position(gtk.WIN_POS_CENTER)
        self.connect('destroy', gtk.main_quit)
        self.set_title('My Films')
        self.set_icon_from_file('film.png')

        # инициализируем виджеты
        toolbar = gtk.Toolbar()
        toolbar.set_style(gtk.TOOLBAR_ICONS)
        tb_new = gtk.ToolButton(gtk.STOCK_NEW)
        self.tb_add = gtk.ToolButton(gtk.STOCK_ADD)
        self.tb_edit = gtk.ToolButton(gtk.STOCK_EDIT)
        self.tb_del = gtk.ToolButton(gtk.STOCK_DELETE)
        tb_about = gtk.ToolButton(gtk.STOCK_ABOUT)
        tb_sep0 = gtk.SeparatorToolItem()
        tb_sep1 = gtk.SeparatorToolItem()
        tb_exit = gtk.ToolButton(gtk.STOCK_QUIT)
        toolbar.insert(tb_new, 0)
        toolbar.insert(tb_sep0, 1)
        toolbar.insert(self.tb_add, 2)
        toolbar.insert(self.tb_edit, 3)
        toolbar.insert(self.tb_del, 4)
        toolbar.insert(tb_sep1, 5)
        toolbar.insert(tb_about, 6)
        toolbar.insert(tb_exit, 7)

        # назначаем обработчики
        tb_new.connect('clicked', self.on_create_db)
        self.tb_add.connect('clicked', self.on_film_dialog)
        self.tb_del.connect('clicked', self.on_film_delete)
        self.tb_edit.connect('clicked', self.on_film_edit)
        tb_about.connect('clicked', self.on_about_dialog)
        tb_exit.connect("clicked", gtk.main_quit)

        # назначаем виджетам подсказки
        tb_new.set_tooltip_text("Создание БД")
        self.tb_add.set_tooltip_text("Добавить фильм")
        self.tb_edit.set_tooltip_text("Редактировать фильм")
        self.tb_del.set_tooltip_text("Удалить фильм")
        tb_about.set_tooltip_text("О ...")
        tb_exit.set_tooltip_text("Выход")

        # создаем layout, с вертикальным расположением виджетов
        vbox = gtk.VBox(False, 8)

        vbox.pack_start(toolbar, False, False, 0)

        # создадим прокручиваемое окно, в котором будет находится таблица с фильмами
        sw = gtk.ScrolledWindow()
        sw.set_shadow_type(gtk.SHADOW_ETCHED_IN)
        sw.set_policy(gtk.POLICY_AUTOMATIC, gtk.POLICY_AUTOMATIC)

        vbox.pack_start(sw, True, True, 0)

        # создадим виджет, который будет отображать таблицу и хранилище данных для этого виджета (далее - грид)
        self.store = self.create_model()
        self.treeView = gtk.TreeView(self.store)
        self.treeView.connect("row-activated", lambda widget, row, col: self.edit_film(widget))
        self.treeView.connect("cursor-changed", self.on_row_selected)
        self.treeView.set_rules_hint(True)
        sw.add(self.treeView)
        self.create_columns(self.treeView)

        # добавим строку состояния
        self.statusbar = gtk.Statusbar()
        vbox.pack_start(self.statusbar, False, False, 0)

        self.add(vbox)
        self.show_all()

    def toolbutton_status(self, status):
        """
        Метод отвечает за статус кнопок управления фильмом: если есть файл с БД - редактирование разрешено, иначе - запрещено.
        """

        self.tb_add.set_sensitive(status)
        self.tb_edit.set_sensitive(status)
        self.tb_del.set_sensitive(status)

    def create_model(self):
        """
        Метод отвечает за существование файла с БД и наполнение грида.
        """
        store = gtk.ListStore(int, str, str, str, str)

        if exist_db():
            self.toolbutton_status(True)
            session = Session()
            films = session.query(Film).all()

            for film in films:
                store.append([film.fid, film.title, film.genre, film.release, film.is_viewed])
        else:
            self.toolbutton_status(False)

        return store

    def create_columns(self, treeView):
        """
        Метод отвечает за создание колонок для грида.
        """

        rendererText = gtk.CellRendererText()
        column = gtk.TreeViewColumn("ID", rendererText, text=0)
        column.set_sort_column_id(0)
        treeView.append_column(column)

        rendererText = gtk.CellRendererText()
        column = gtk.TreeViewColumn("Название", rendererText, text=1)
        column.set_sort_column_id(1)
        treeView.append_column(column)

        rendererText = gtk.CellRendererText()
        column = gtk.TreeViewColumn("Жанр", rendererText, text=2)
        column.set_sort_column_id(2)
        treeView.append_column(column)

        rendererText = gtk.CellRendererText()
        column = gtk.TreeViewColumn("Дата релиза", rendererText, text=3)
        column.set_sort_column_id(3)
        treeView.append_column(column)

        rendererText = gtk.CellRendererText()
        column = gtk.TreeViewColumn("Смотрел?", rendererText, text=4)
        column.set_sort_column_id(4)
        treeView.append_column(column)

    def save_film(self, widget, is_update):
        """
        Метод отвечает за создание/обновление фильма в БД.
        """

        title = unicode(self.title_entry.get_text())
        genre = unicode(self.genre_entry.get_text())
        viewed = self.viewed_chk.get_active()

        # Формат даты - d.m.Y. Все остальные варианты считаются неправильные.
        try:
            date_parts = map(int, self.release_entry.get_text().split('.'))
            date = datetime.date(date_parts[2], date_parts[1], date_parts[0])
        except:
            date = datetime.date.today()

        session = Session()

        if is_update:
            tree_model, tree_iter = self.treeView.get_selection().get_selected()
            fid = tree_model.get_value(tree_iter, 0)

            # обновляем данные о фильме
            film = session.query(Film).get(fid)
            film.title = title
            film.genre = genre
            film.release = date
            film.is_viewed = viewed

            # обновляем грид
            self.store.set(tree_iter, 1, title, 2, genre, 3, date, 4, viewed)
            session.add(film)
            session.commit()
        else:
            # добавляем новый фильм
            film = Film(title, genre, date, viewed)
            session.add(film)
            session.commit()

            # обновляем грид
            self.store.append([film.fid, film.title, film.genre, film.release, film.is_viewed])

        self.dlg.hide()

    def on_create_db(self, widget):
        """
        Метод отвечает за создание файла с БД.
        """

        if exist_db():
            self.on_warn(None, 'База данных уже существует!')
        else:
            init_db()
            self.toolbutton_status(True)
            self.on_info(None, 'База данных успешно создана!')

    def on_row_selected(self, widget):
        """
        Метод отвечает за обновление строки состояния при выборе фильма в гриде.
        """

        tree_model, tree_iter = widget.get_selection().get_selected()
        film = tree_model.get_value(tree_iter, 1)
        self.statusbar.push(0, 'Фильм: %s' % film)

    def on_film_dialog(self, widget, title=None, genre=None, release=None, viewed=None):
        """
        Метод отвечает за отображение диалога с характеристиками фильма.
        """

        if title or genre or release or viewed:
            dlg_title = 'Редактирование фильма'
            is_update = True
        else:
            dlg_title = 'Добавление фильма'
            is_update = False

        self.dlg = gtk.Dialog(title=dlg_title, flags=gtk.DIALOG_DESTROY_WITH_PARENT)
        self.dlg.set_border_width(20)

        # создадим кнопки для диалога
        btn_save = gtk.Button('Сохранить')
        btn_save.connect('clicked', self.save_film, is_update)
        self.dlg.action_area.pack_start(btn_save, True, True, 0)

        btn_cancel = gtk.Button('Отменить')
        btn_cancel.connect('clicked', lambda x: self.dlg.hide())
        self.dlg.action_area.pack_start(btn_cancel, True, True, 0)

        # layout отвечающий за виджеты для поля 'Название'
        title_label = gtk.Label("Название")
        title_label.set_width_chars(12)
        self.title_entry = gtk.Entry()
        if not (title is None):
            self.title_entry.set_text(title)

        title_hbox = gtk.HBox(False, 0)
        title_hbox.pack_start(title_label, False, False, 0)
        title_hbox.pack_start(self.title_entry, False, False, 0)

        # layout отвечающий за виджеты для поля 'Жанр'
        genre_label = gtk.Label("Жанр")
        genre_label.set_width_chars(12)
        self.genre_entry = gtk.Entry()
        if not (genre is None):
            self.genre_entry.set_text(genre)

        genre_hbox = gtk.HBox(False, 0)
        genre_hbox.pack_start(genre_label, False, False, 0)
        genre_hbox.pack_start(self.genre_entry, False, False, 0)

        # layout отвечающий за виджеты для поля 'Дата выхода'
        release_label = gtk.Label("Дата выхода")
        release_label.set_width_chars(12)
        self.release_entry = gtk.Entry()
        if not (release is None):
            self.release_entry.set_text(release.strftime('%d.%m.%Y'))
        else:
            self.release_entry.set_text(datetime.date.today().strftime('%d.%m.%Y'))

        release_hbox = gtk.HBox(False, 0)
        release_hbox.pack_start(release_label, False, False, 0)
        release_hbox.pack_start(self.release_entry, False, False, 0)

        # layout отвечающий за виджеты для поля 'Смотрел?'
        self.viewed_chk = gtk.CheckButton("Смотрел?")
        if not (viewed is None):
            self.viewed_chk.set_active(viewed)

        viewed_hbox = gtk.HBox(False, 0)
        viewed_hbox.pack_start(self.viewed_chk, False, False, 20)

        # добавляем все виджеты в основной layout для диалога
        self.dlg.vbox.pack_start(title_hbox, False, False, 5)
        self.dlg.vbox.pack_start(genre_hbox, False, False, 5)
        self.dlg.vbox.pack_start(release_hbox, False, False, 5)
        self.dlg.vbox.pack_start(viewed_hbox, False, False, 5)
        self.dlg.show_all()

        self.dlg.run()
        self.dlg.destroy()

    def on_about_dialog(self, widget):
        """
        Метод отвечает за отображение диалога о 'продукте' :).
        """

        about = gtk.AboutDialog()
        about.set_program_name("My Films")
        about.set_version("1.0")
        about.set_copyright("(c) proft")
        about.set_comments("MyFilms - персональная библиотека киномана.")
        about.set_website("http://proft.com.ua")
        about.set_logo(gtk.gdk.pixbuf_new_from_file("film.png"))
        about.run()
        about.destroy()

    def on_film_delete(self, widget):
        """
        Метод отвечает за удаление выбранного фильма.
        """

        tree_model, tree_iter = self.treeView.get_selection().get_selected()
        fid = tree_model.get_value(tree_iter, 0)

        session = Session()
        film = session.query(Film).filter_by(fid=fid).one()
        session.delete(film)
        session.commit()

        self.store.remove(tree_iter)

    def on_film_edit(self, widget):
        """
        Метод отвечает за редактирование выбранного фильма.
        """

        tree_model, tree_iter = self.treeView.get_selection().get_selected()
        fid = tree_model.get_value(tree_iter, 0)

        session = Session()
        film = session.query(Film).filter_by(fid=fid).one()
        self.on_film_dialog(None, title=film.title, genre=film.genre, release=film.release, viewed=film.is_viewed)

    def on_warn(self, widget, msg):
        """
        Метод отвечает за отображение диалога с предупреждением.
        """

        md = gtk.MessageDialog(self, gtk.DIALOG_DESTROY_WITH_PARENT, gtk.MESSAGE_WARNING, gtk.BUTTONS_CLOSE, msg)
        md.run()
        md.destroy()

    def on_info(self, widget, msg):
        """
        Метод отвечает за отображение диалога с 'информацией'.
        """

        md = gtk.MessageDialog(self, gtk.DIALOG_DESTROY_WITH_PARENT, gtk.MESSAGE_INFO, gtk.BUTTONS_CLOSE, msg)
        md.run()
        md.destroy()

App()
gtk.main()
