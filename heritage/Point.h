#ifndef POINT_H_DEJA_INCLU
#define POINT_H_DEJA_INCLU

#include <iostream>

class Point 
{
public:
                 Point       (double x=0, double y=0);
   void          deplacer    (double dx, double dy);
   void          agrandir    (const Point& centre, double facteur);
   void          afficher    (std::ostream& os) const;
   double        x           () const;
   double        y           () const;

   static double reqDistance (const Point& p1, const Point& p2);

private:
   double m_x;
   double m_y;
};

inline double Point::x() const
{
   return m_x;
}

inline double Point::y() const
{
   return m_y;
}

#endif // --- #ifndef POINT_H_DEJA_INCLU
