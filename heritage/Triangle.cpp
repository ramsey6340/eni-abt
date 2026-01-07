#include "Triangle.h"

Triangle::Triangle (const Point& p1, const Point& p2, const Point& p3)
: Polygone(3)
{
   asgPoint(1, p1);
   asgPoint(2, p2);
   asgPoint(3, p3);
}

void Triangle::afficher(std::ostream& os) const
{
   os << "Triangle " << 3 << " ";
   reqPoint(1).afficher(os);
   os << " ";
   reqPoint(2).afficher(os);
   os << " ";
   reqPoint(3).afficher(os);
}
