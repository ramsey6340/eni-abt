#include <iostream>
#include "Polygone.h"
#include "Triangle.h"
#include "Texte.h"
#include "TexteProportionnel.h"

using namespace std;

void main()
{
   {
      Point p1(3.0, 2.0); cout << "p1 = "; p1.afficher(cout);
      Point p2(1.5, 2.5); cout << endl << "p2 = "; p2.afficher(cout);
      Point p3(1.0, 1.5); cout << endl << "p3 = "; p3.afficher(cout);
      Point p4(2.0, 0.5); cout << endl << "p4 = ";p4.afficher(cout);


      cout << endl << "Creation d'un polygone a 4 sommets" << endl;
      Polygone q(4); 
      q.asgPoint(1, p1);
      q.asgPoint(2, p2);
      q.asgPoint(3, p3);
      q.asgPoint(4, p4);
      q.afficher(cout);

      cout << endl << "Pressez retour" << endl;
      cin.get();
      system("cls");
   }
   {
      Point p1(3.0, 2.0); cout << "p1 = "; p1.afficher(cout);
      Point p2(0.5, 2.5); cout << endl << "p2 = "; p2.afficher(cout);
      Point p3(4.0, 1.0); cout << endl << "p3 = "; p3.afficher(cout);

      cout << endl << "Creation d'un polygone a 3 sommets" << endl;
      Polygone p(3);
      p.asgPoint(1, p1);
      p.asgPoint(2, p2);
      p.asgPoint(3, p3);
      p.afficher(cout);

      cout << endl << "Creation d'un triangle avec impression personnalisee" << endl;
      Triangle t(p1, p2, p3);
      t.afficher(cout);

      cout << endl << "Pressez retour" << endl;
      cin.get();
      system("cls");
   }
   {
      Point p1(3.0, 2.0); cout << "p1 = "; p1.afficher(cout);
      Point p2(0.5, 2.5); cout << endl << "p2 = "; p2.afficher(cout);
      Point p3(4.0, 1.0); cout << endl << "p3 = "; p3.afficher(cout);

      cout << endl << "Creation d'un triangle et deplacement de [2,1]" << endl;

      Triangle t(Point(3,2), Point(0.5,2.5), Point(4,1));
      t.afficher(cout); cout << endl;
      t.deplacer(2, 1);
      t.afficher(cout); 

      cout << endl << "Pressez retour" << endl;
      cin.get();
      system("cls");
   }
   {
      Point centre(0,0);

      Point p1(3.0, 2.0); cout << "p1 = "; p1.afficher(cout);
      Point p2(0.5, 2.5); cout << endl << "p2 = "; p2.afficher(cout);
      Point p3(4.0, 1.0); cout << endl << "p3 = "; p3.afficher(cout);

      cout << endl << "Creation d'un triangle et calcul de la circonference." << endl;

      Triangle t(Point(3,2), Point(0.5,2.5), Point(4,1));
      t.afficher(cout); cout << endl;
      cout << "Circonference : " << t.circonference() << endl;

      cout << endl << "Agrandir le triangle d'un facteur de 1.5" << endl;
      t.agrandir(centre, 1.5);
      t.afficher(cout); cout << endl;
      cout << "Circonference : " << t.circonference() << endl;

      cout << endl << "Pressez retour" << endl;
      cin.get();
      system("cls");
   }
   {
      Point centre(0,0);
      Point p1(3.0, 2.0); cout << "p1 = "; p1.afficher(cout);

      cout << endl << "Creation d'un texte a une position a l'ecran" << endl;
      Texte txt(p1, "Bonjour la police");
      txt.afficher(cout);
      cout << endl;

      cout << "Agrandir le texte d'un facteur de 1.2" << endl;
      txt.agrandir(centre, 1.2);
      txt.afficher(cout);
      cout << endl << "Le texte ne change pas de dimension" << endl;

      cout << endl << "Creation d'un texte proportionnel a 12 points" << endl;
      TexteProportionnel tp(p1, "Bonjour la police", 12);
      tp.afficher(cout);
      cout << endl;

      cout << "Agrandir le texte d'un facteur de 1.2" << endl;
      tp.agrandir(centre, 1.2);
      tp.afficher(cout);
      cout << endl << "Le texte est change de dimension" << endl;
   }
}