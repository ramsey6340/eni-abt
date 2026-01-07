#include "Point.h"
#include <cmath>

Point::Point(double x, double y)
: m_x (x), m_y (y)
{
}

void Point::agrandir(const Point& centre, double facteur)
{
   m_x = m_x * facteur + centre.x() * (1-facteur);
   m_y = m_y * facteur + centre.x() * (1-facteur);
}

void Point::deplacer(double dx, double dy)
{
   m_x += dx;
   m_y += dy;
}

void Point::afficher(std::ostream& os) const
{
   os << "[" << m_x << "," << m_y << "]";
}

double Point::reqDistance(const Point& p1, const Point& p2)
{
   double x2 = pow(p2.x() - p1.x(), 2);
   double y2 = pow(p2.y() - p1.y(), 2);
   double racine2 = sqrt (x2 + y2);
   return racine2;
}
