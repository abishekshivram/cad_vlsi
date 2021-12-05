from string import Template

_class_template = """
class ${klass}:
    def __init__(self, name):
        self.name = name

    def ${method}(self):
        print('Hi', self.name + ',', 'welcome to', '$site')
"""

template = Template(_class_template)
a = template.substitute(klass='MyClass',
                         method='greet',
                         site='StackAbuse.com')
print(a)                         

# obj = MyClass("John Doe")
# obj.greet()