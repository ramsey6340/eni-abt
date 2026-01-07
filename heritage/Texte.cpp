#include "Texte.h"

Texte::Texte(const Point& p, const std::string& s)
: m_pos(p), m_texte(s)
{
}

void Texte::deplacer(double dx, double dy)
{
   m_pos.deplacer(dx,dy);
}

void Texte::agrandir(const Point& centre, double facteur)
{
   m_pos.agrandir(centre, facteur);
}

void Texte::afficher(std::ostream& os) const
{
   os << "Position: ";
   m_pos.afficher(os);
   os << " ";
   os << m_texte;
}
