#include "TexteProportionnel.h"

using namespace std;


TexteProportionnel::TexteProportionnel (const Point& pos, const std::string& txt, int size)
: Texte(pos, txt), m_size(size)
{}

void TexteProportionnel::afficher(std::ostream& os) const
{  
   os << "Size: " << m_size << " ";
   // --- Appel de la méthode du parent
   Texte::afficher(os);
}

void TexteProportionnel::agrandir(const Point& centre, double facteur)
{  
   // --- Appel de la méthode du parent
   Texte::agrandir(centre, facteur);
   m_size *= facteur;
}
