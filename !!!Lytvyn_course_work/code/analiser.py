# -*- coding: cp1251 -*-
# analiser.py
# Virusya Lytvyn
# -*- coding: utf-8 -*-

import sys
import os
import sqlite3

from binascii import b2a_hex

from pdfminer.pdfinterp import PDFResourceManager, process_pdf
from pdfminer.pdfparser import PDFParser, PDFDocument
from pdfminer.converter import TextConverter
from pdfminer.layout import LAParams
from cStringIO import StringIO
from pdfminer.layout_scanner import *

def getTableOfContents (path, pageNum):
    fp = open(path, 'rb')
    parser = PDFParser(fp)
    doc = PDFDocument()
    parser.set_document(doc)
    doc.set_parser(parser)
    #doc.initialize(password)

    for pageNumber, page in enumerate(doc.get_pages()):
        if pageNumber == pageNum:
            return getParsedPage(doc, pageNum)

def getParsedPage (doc, pageNumber):
    rsrcmgr = PDFResourceManager()
    retstr = StringIO()
    codec = 'utf-8'
    laparams = LAParams()
   # device = TextConverter(rsrcmgr, retstr, codec=codec, laparams=laparams)
    device = PDFPageAggregator(rsrcmgr, laparams=laparams)
    interpreter = PDFPageInterpreter(rsrcmgr, device)

    text_content = []
    for i, page in enumerate(doc.get_pages()):
        if i == pageNumber:
            interpreter.process_page(page)
            layout = device.get_result()
            text_content.append(parse_lt_objs(layout, (i+1), '\tmp'))

    return text_content

#test for parsing
def getKeywordsFromBook(pathToBook, pageNumber):
    result = getTableOfContents(pathToBook, pageNumber)
    item = result[0]

    single_item = item.splitlines()
    return single_item

def getKeywordfFromBookWithRange(pathToBook, firstPage, lastPage):
    array = []
    if (firstPage < lastPage):
        i = firstPage - 1
        while (i < lastPage):
            item = getKeywordsFromBook(pathToBook, i)
            array.append((item))
            i = i + 1
    else:
        print 'error'
    return array

#ar = getKeywordfFromBookWithRange("Neuburg Matt - Programming iOS 4 - 2011.pdf", 814, 815)
