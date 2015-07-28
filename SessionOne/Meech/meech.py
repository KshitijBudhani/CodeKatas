from cStringIO import StringIO

__author__ = 'meech'

silly_string = "(id,created,employee(id,firstname,employeeType(id), lastname),location)"
silly_string2 = "(id,created,employee(id,firstname(mid),employeeType(id), lastname),location(lat,lon))"


def tokenize_string(string):
    import tokenize

    type_map = {
        tokenize.NAME: "(name)",
        tokenize.OP: "(operator)",
    }
    for t in tokenize.generate_tokens(StringIO(string).next):
        try:
            yield type_map[t[0]], t[1]
        except KeyError:
            if t[0] == tokenize.ENDMARKER:
                break
    yield "(end)", "(end)"


current_function_name = "null"
current_name = ""

objects = {}
objects_list = []
args_list = []
names = []


def tokenize(string):
    source = tokenize_string(string)
    arr = []
    current_object = objects
    for id, value in source:
        if id == "(operator)":
            if value == "(":
                arr, current_object = start_function(arr, current_object)
            elif value == ")":
                if current_object in objects_list:
                    objects_list.remove(current_object)
                if arr in args_list:
                    args_list.remove(arr)
                arr, current_object = end_function()
        elif id == "(name)":
            push_argument(value, arr)


def start_function(array_names, current_object):
    if not len(array_names):
        current_object["null"] = array_names
        objects_list.append(current_object)
        args_list.append(array_names)
    else:
        key = array_names.pop()
        new_object = {}
        new_object[key] = []
        array_names.append(new_object)
        objects_list.append(new_object)
        args_list.append(new_object[key])
    return args_list[-1], objects_list[-1]


def end_function():
    return args_list[-1] if len(args_list) else [], objects_list[-1] if len(objects_list) else {}


def push_argument(arg, list):
    names.append(arg)
    list.append(arg)

def silly_print(src, level=0):

    tabs = lambda n: '-' * n

    if isinstance(src, dict):
        for key, value in src.iteritems():
            print (tabs(level) + ' %s' % key) if level else key
            silly_print(value, level + 1)
    elif isinstance(src, list):
        for listitem in src:
            silly_print(listitem, level)
    else:
        print tabs(level) + (('%s' if not level else ' %s') % src)

def parse(string):
    tokenize(string)


def main():
    print "input:", silly_string
    parse(silly_string)
    silly_print(objects["null"])


if __name__ == "__main__":
    main()