#ifndef TexteProportionnel_H_DEJA_INCLU
#define TexteProportionnel_H_DEJA_INCLU

#include "Texte.h"
#include <string>
#include <iostream>
#include "Point.h"

class TexteProportionnel : public Texte 
{
public:
        TexteProportionnel (const Point& pos, const std::string& txt, int size);
   void agrandir           (const Point& centre, double facteur);
   void afficher           (std::ostream& os) const;

private:
   int m_size;
};

#endif // --- #ifndef TexteProportionnel_H_DEJA_INCLU
