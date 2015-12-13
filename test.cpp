#include <new>


class Obj
{
    public:
    int a;
    int b;
}


Obj get_something(int a)
{
    return new Obj(4, 5);
}


int main()
 {
    int *x;
    *x = 5;

    x = new int;
    Obj t = get_something(4);

    return t.a;
}
