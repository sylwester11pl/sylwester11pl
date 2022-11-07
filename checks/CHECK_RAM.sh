#!/bin/bash

#Skrypt do sprawdzania zapchania pamieci RAM. Opiera sie na tworzeniu plikow tymczasowych oraz obliczeniach korzystajac z pliku "mem info". \
#Plik wymagany aby skrypt dzialal (lokalizacja /proc/meminfo).
#Skrypt tworzy katalog roboczy w tmp ktory jest usuwany na koniec pracy skryptu (/tmp/check_ram). 
#Skrypt powiadiamia uzytkownika o % zajetosci RAM oraz wysyla infomracje do pliku mem_info.log.
#Wymagane uprawnienia do modyfikacji.
#W tej wersji skrypt dziala jako interaktywny -> ma ustawione time w niektorych miejscach po ktorych sprawia wrazenie ze "mysli" :)
#Jesli ma dzialac jako automat to trzeba usunac timery -> najlepiej zakomentowac lub odkomentowac. 
#Po tym zabiegu dziala sam do konca (timery ustawilem w sekcji "read").
#Wersja 0.1b, stworzyl Patryk Basko

clear
echo "Skrypt sprawdzajacy zajecie pamieci RAM"
echo "======================================="
echo "Wersja skryptu: 0.1b -> wersja interaktywna z uzytkownikiem."
#echo "W przypadku braku reakcji w danym momencie, kroki ida dalej po 5s."
echo ""
read -p "wcisnij ENTER aby rozpoczac."  #-t 5

#sprawdzam i tworze katalog roboczy
#echo w tym przypadku pomocnicze


if [ -d /tmp/check_ram ];
	then
	cd /tmp/check_ram;
	echo "";
	echo "Folder juz istnieje";
	else
	mkdir /tmp/check_ram/;
        cd /tmp/check_ram/;
	echo "";
        echo "Folder zostal utworzony";
fi


#pobieram dane do pliku
echo ""
echo "Pobieram informacje o pamieci, prosze czekac"
read -t 2

cat /proc/meminfo > /tmp/check_ram/check_ram_1
read -p "Gotowe, wcisnij ENTER aby kontynuowac" #-t 5
echo ""
echo ""

#wyswietlam pobrane dane. Zakomentuj jesli nie chcesz widziec.
echo "Wyswietlam pobrane i zapisane dane"
head -n 5 check_ram_1 > check_ram_2 #| cut -c18-25 > ZADANIE_6
cat check_ram_2

echo ""
echo "==========="

#formatuje dane do obliczenia
cut -c18-25 check_ram_2 > check_ram_3

let total=$[`sed -n '1p' < check_ram_3`]
let free_mem=$[`sed -n '2p' < check_ram_3`]
let ava_mem=$[`sed -n '3p' < check_ram_3`]
let buf_mem=$[`sed -n '4p' < check_ram_3`]
let cach_mem=$[`sed -n '5p' < check_ram_3`]
read -t 2

#do weryfikacji czy dane sie pokrywaja -> prawde mowiac nie wiem po co to dalem. ZAkomentuj jesli nie chcesz widziec
echo "Calkowita liczba pamieci: "$total
echo "Wolna pamiec: "$free_mem
echo "Dostepna pamiec: "$ava_mem
echo "Pamiec buforowana: "$buf_mem
echo "Pamiec jako cache: "$cach_mem
echo ""
read -p "Sprawdz czy dane sie pokrywaja i wcisnij ENTER aby ZAKONCZYC TEN ETAP" #-t 5

echo "" 
echo "" 

procent=`echo "scale=2; (($total-$ava_mem)/$total)*100" | bc`


echo "Procent zuzycia RAM: "$procent"%"

#sprawdzam jaki status mam
#dodatkowo zamieniam liczbe zmiennoprzecinkowa na calkowita - ulomnosc basza

let procent_czysty=$[`echo $procent | cut -c1-2`]
let szesc=60
let osiem=80

echo ""

#punkt testowy
#echo "Liczba do porownani" $procent_czysty
#read -p "Pacnij aby kontynuowac"

if [ $procent_czysty -lt $szesc ];
	then
	echo -e "severity \e[1;32mOK\e[1;m" 				#zakomentuj linie jesli nie chcesz widziesz
	date >> /tmp/mem_info.log;
	echo -e "severity \e[1;32mOK\e[1;m" >> /tmp/mem_info.log;
	echo "Zajetosc RAM: "$procent"%" >> /tmp/mem_info.log;
	echo "" >> /tmp/mem_info.log;
	else
		if [[ $procent_czysty -ge $szesc && $procent_czysty -lt $osiem ]];
		then
		echo -e "severity \e[1;33mWARNING\e[1;m"  		#zakomentuj linie jesli nie chcesz widziesz
		date >> /tmp/mem_info.log;
		echo -e "severity \e[1;33mWARNING\e[1;m" >> /tmp/mem_info.log;
		echo "Zajetosc RAM: "$procent"%" >> /tmp/mem_info.log;
		echo "" >> /tmp/mem_info.log;
			else
			echo -e "severity \e[1;31mCRITICAL\e[1;m"	#zakomentuj linie jesli nie chcesz widziesz 
			date >> /tmp/mem_info.log;
			echo -e "severity \e[1;31mCRITICAL\e[1;m" >> /tmp/mem_info.log;
			echo "Zajetosc RAM: "$procent"%" >> /tmp/mem_info.log;
			echo "" >> /tmp/mem_info.log;
		fi
fi

#otwieram log dla sprawdzenia

echo ""
read -p "Wcisnij ENTER aby zakonczyc i otworzyc plik mem_info.log"
echo ""
echo "======================*******======================"
cat /tmp/mem_info.log
echo ""
echo "======================*******======================"
read -p "Wcisnij ENTER aby zamknac logi i zamknac skrypt"
clear

echo "============================"
echo "Czyszcze po sobie ... "\



#sprzatam po sobie
rm -r -v /tmp/check_ram
read -p "Koniec pracy"

exit 0
