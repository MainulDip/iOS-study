### SOLID Pattern:

Single Responsibility
Open (to adopt change) Close (to modification)
Liskov substitution principal 
    - (Subtypes must be substitutable for the base type, ie `enum NetworkError: Error{}` )
Interface Segregation 
    - (client should not be forced to implement a interface that may not be used)
Dependency Inversion 
    - (Higher level module should not depend directly for lower level module)
    - both higher and lower module should depend on 3rd module
