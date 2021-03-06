## Praca domowa nr. 1
library(PogromcyDanych)
head(auta2012)
# Zadanie 1
# Sprawd� ile jest aut z silnikiem diesla wyprodukowanych w 2007 roku?
x <- auta2012 %>% 
  filter(Rodzaj.paliwa == "olej napedowy (diesel)", Rok.produkcji == 2007)
dim(x)[1]

# Zadanie 2
# Jakiego koloru auta maj� najmniejszy medianowy przebieg?
x <- auta2012 %>% 
 group_by(Kolor) %>%
   summarise(mediana = median(Przebieg.w.km, na.rm = TRUE)) %>% 
    arrange(mediana ,desc = FALSE)

x[1,1]
# Zadanie 3
# Gdy ograniczy� si� tylko do aut wyprodukowanych w 2007, kt�ra Marka wyst�puje najcz�ciej w zbiorze danych auta2012?

x <- auta2012 %>% 
  filter(Rok.produkcji == 2007) %>% 
    group_by(Marka) %>% 
      summarise(n =n()) %>% 
        arrange(-n)
  
x[1,1]  

# Zadanie 4
# Spo�r�d aut z silnikiem diesla wyprodukowanych w 2007 roku kt�ra marka jest najta�sza?
x <- auta2012 %>% 
      filter(Rodzaj.paliwa == "olej napedowy (diesel)", Rok.produkcji == 2007) %>% 
        group_by(Marka) %>% 
          summarise(�rednia_cena = mean(Cena.w.PLN, na.rm = TRUE)) %>% 
            arrange(�rednia_cena)
x[1,1]

# Zadanie 5
# Spo�r�d aut marki Toyota, kt�ry model najbardziej straci� na cenie pomi�dzy rokiem produkcji 2007 a 2008.
x <-auta2012 %>% 
      filter( Marka == "Toyota") %>% 
        group_by(Model) %>% 
          filter(Rok.produkcji == 2007) %>% 
             summarise(�rednia_cena_2007 = mean(Cena.w.PLN, na.rm = TRUE))

y <- auta2012 %>% 
  filter( Marka == "Toyota") %>% 
    group_by(Model) %>% 
      filter(Rok.produkcji == 2008) %>% 
         summarise(�rednia_cena_2008 = mean(Cena.w.PLN, na.rm = TRUE))
y
z <- inner_join(x,y)
z <- z %>% 
  transmute(z,r�nica = z[,2]-z[,3]) %>% 
    arrange(-r�nica)
z[1,1]


# Zadanie 6
# W jakiej marce klimatyzacja jest najcz�ciej obecna?

z <- auta2012 %>% 
  mutate(Wyposazenie.dodatkowe_splited = strsplit(as.character(auta2012$Wyposazenie.dodatkowe), split = ", ")) %>% 
  filter("klimatyzacja" %in% Wyposazenie.dodatkowe_splited) %>% 
  group_by(Marka) %>% 
  summarise(n =n()) %>% 
  arrange(-n)
  
z[1,1]
  

      
strsplit(as.character(auta2012$Wyposazenie.dodatkowe), split = ", ")




# Zadanie 7
# Gdy ograniczy� si� tylko do aut z silnikiem ponad 100 KM, kt�ra Marka wyst�puje najcz�ciej w zbiorze 
# danych auta2012?
x <- auta2012 %>% 
   filter(KM >= 100) %>% 
   group_by(Marka) %>% 
   summarise(n =n()) %>% 
   arrange(-n)

x[1,1]
# Zadanie 8
# Gdy ograniczy� si� tylko do aut o przebiegu poni�ej 50 000 km o silniku diesla,
# kt�ra Marka wyst�puje najcz�ciej w zbiorze danych auta2012? 

x <- auta2012 %>% 
    filter(Przebieg.w.km <= 50000 & Rodzaj.paliwa == "olej napedowy (diesel)") %>% 
    group_by(Marka) %>% 
    summarise(n =n()) %>% 
    arrange(-n)
    
x[1, 1]
  
# Zadanie 9
# Spo�r�d aut marki Toyota wyprodukowanych w 2007 roku, kt�ry model jest �rednio najdro�szy?

x <- auta2012 %>% 
  filter(Marka == "Toyota" & Rok.produkcji == 2007) %>% 
  group_by(Model) %>% 
  summarise(�rednia_cena = mean(Cena.w.PLN, na.rm = TRUE)) %>% 
  arrange(-�rednia_cena)

x[1,1]

# Zadanie 10
# Spo�r�d aut marki Toyota, kt�ry model ma najwi�ksz� r�nic� cen gdy por�wna� silniki benzynowe a diesel?

x <-auta2012 %>% 
  filter( Marka == "Toyota") %>% 
  group_by(Model) %>% 
  filter(Rodzaj.paliwa == "olej napedowy (diesel)") %>% 
  summarise(�rednia_cena_diesel = mean(Cena.w.PLN, na.rm = TRUE))

y <- auta2012 %>% 
  filter( Marka == "Toyota") %>% 
  group_by(Model) %>% 
  filter(Rodzaj.paliwa == "benzyna") %>% 
  summarise(�rednia_cena_benzyna = mean(Cena.w.PLN, na.rm = TRUE))
z <- inner_join(x,y)
z
z <- z %>% 
  mutate(r�nica = abs(z[,2]-z[,3])) %>% 
  arrange(-r�nica)
z
z[1,1]





auta2012













