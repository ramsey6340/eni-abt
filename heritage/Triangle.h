#ifndef TRIANGLE_H_DEJA_INCLU
#define TRIANGLE_H_DEJA_INCLU

#include <iostream>
#include "Point.h"
#include "Polygone.h"

class Triangle : public Polygone
{
public:
         Triangle (const Point& p1, const Point& p2, const Point& p3);
   void  afficher (std::ostream& os) const;
};

#endif // --- #ifndef TRIANGLE_H_DEJA_INCLU
