#ifndef TEXTE_H_DEJA_INCLU
#define TEXTE_H_DEJA_INCLU

#include <string>
#include <iostream>
#include "Point.h"

class Texte 
{
public:
        Texte      (const Point&, const std::string&);
   void agrandir   (const Point& centre, double facteur);
   void deplacer   (double dx, double dy);
   void afficher   (std::ostream& os) const;

private:
   Point m_pos;
   std::string m_texte;
};

#endif // --- #ifndef TEXTE_H_DEJA_INCLU
