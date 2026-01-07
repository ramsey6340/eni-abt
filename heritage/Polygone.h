#ifndef POLYGONE_H_DEJA_INCLU
#define POLYGONE_H_DEJA_INCLU

#include <iostream>
#include <vector>
#include "Point.h"

class Polygone 
{
public:
          Polygone      (int nbSommets = 0);
   void   asgPoint      (int pos, const Point& p);
   void   deplacer      (double dx, double dy);
   void   agrandir      (const Point& centre, double facteur);
   double circonference () const;
   void   afficher      (std::ostream& os) const;

protected:
   Point reqPoint (int pos) const;

private:
   std::vector<Point> m_vPoints;
};

#endif // --- #ifndef POLYGONE_H_DEJA_INCLU