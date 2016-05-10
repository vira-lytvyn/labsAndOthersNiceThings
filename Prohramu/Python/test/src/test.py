'''
Created on 05.11.2011

@author: Admin
'''
#print 'Hello World!'
def enquote1(in_str):
    """Quotes input string with single-quote"""
    in_str = in_str.replace("'", r"\'")
    return "'%s'" % in_str

def enquote2(in_str):
    """Quotes input string with double-quote"""
    in_str = in_str.replace('"', r'\"')
    return '"%s"' % in_str

def gen_insert(table, **kwargs):
    """Generates DB insert statement"""
    cols = []
    vals = []
    for col, val in kwargs.items():
        cols.append(enquote2(col))
        vals.append(enquote1(str(val)))
    cols = ", ".join(cols)
    vals = ", ".join(vals)

    return 'INSERT INTO "%s"(%s) VALUES(%s);' % (
            table,cols,vals )

print gen_insert("workers", name="John", salary=1500.0, age=21)
params = {"name": "Mary", "salary": 1700.0, "age": 19 }
print gen_insert("workers", **params)
