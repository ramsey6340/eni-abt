#include "Polygone.h"

using namespace std;

Polygone::Polygone (int nbSommets)
{
   m_vPoints.resize(nbSommets);   
}

void Polygone::asgPoint(int pos, const Point& p)
{
   m_vPoints[pos-1] = p;
}

void Polygone::agrandir (const Point& centre, double facteur)
{
   vector<Point>::iterator iterI = m_vPoints.begin();
   while (iterI != m_vPoints.end())
   {
      (*iterI).agrandir(centre, facteur);
      iterI++;
   }
}

void Polygone::deplacer (double dx, double dy)
{
   vector<Point>::iterator iterI = m_vPoints.begin();
   while (iterI != m_vPoints.end())
   {
      (*iterI).deplacer(dx,dy);
      iterI++;
   }
}

double Polygone::circonference() const
{
   double circonference = 0;

   for (int i=0; i<m_vPoints.size(); i++)
   {
      Point p1 = m_vPoints[i];
      Point p2 = (i+1 == m_vPoints.size()) ? m_vPoints[0] : m_vPoints[i+1];
      circonference += Point::reqDistance (p1, p2);
   }
   return circonference;
}

void Polygone::afficher (ostream& os) const
{
   os << "Polygone " << m_vPoints.size();

   vector<Point>::const_iterator iterI = m_vPoints.begin();
   while (iterI != m_vPoints.end())
   {
      os << " ";
      (*iterI).afficher(os);
      iterI++;
   }
}

Point Polygone::reqPoint (int pos) const
{
   return m_vPoints[pos-1];
}

