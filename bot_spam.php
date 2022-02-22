<?php

echo "<h3>Envoi d'une requ�te POST via HTTP.</h3><br />";
 
/*
---------------------------
CONFIGURATION DE LA SOCKET
---------------------------
*/
 
$port = getservbyname('www','tcp');
$ip = gethostbyname("http://adopteunpokemon.net23.net/");
$socket = socket_create(AF_INET, SOCK_STREAM, SOL_TCP);
 
 
/*
----------------------------------------------------
GESTION DES ERREURS LORS DE LA CREATION DE LA SOCKET
----------------------------------------------------
*/
 
if ($socket < 0)
   echo "socket_create() n'a pas fonctionn�. Motif : " . socket_strerror($socket) . "<br />";
else
   echo "La socket a pu �tre cr��e.<br />";
echo "Essai de connexion � '$ip' sur le port '$port' ...";
 
 
/*
-------------------------
CONNEXION DE NOTRE SOCKET
-------------------------
*/
 
$resultat = socket_connect($socket,$ip,$port);
 
 
/*
-----------------------------------------------------
GESTION DES ERREURS LORS DE LA CONNEXION DE LA SOCKET
-----------------------------------------------------
*/
 
if ($resultat < 0)
   echo "socket_connect() n'a pas fonctionn�. Motif : " . socket_strerror($resultat) . "<br />";
else
   echo "La socket a pu �tre connect�e.<br />";
 
/*
---------------------------------------------------------------------
ECRITURE ET ENVOI DE LA REQUETE A ENVOYER POUR VALIDER LE FORMULAIRE
---------------------------------------------------------------------
*/
 
echo "Envoi de la requ�te HTTP en cours.....";
 
 
$creation_sujet = "nom=PaAUL&prenom=DUPUIS&question=&value&email=votre@mail.com&commentaires=VOTRE SPAM";
 
$envoi = "POST /contact.php HTTP/1.1\r\n";
$envoi .= "Host: http://adopteunpokemon.net23.net/ \r\n";
$envoi .= "Connection: keep-alive\r\n";
$envoi .= "Content-type: application/x-www-form-urlencoded\r\n";
$envoi .= "Content-Length: ".strlen($creation_sujet)."\r\n\r\n";
$envoi .= $creation_sujet;
$envoi .= "\r\n";
 
socket_write($socket, $envoi, strlen($envoi));
echo "La requ�te HTTP a �t� envoy� avec succ�s.<br />";
 
 
echo "Fermeture de la socket ouvert au pr�alable..... ";
socket_close($socket);
echo "Fermeture r�ussie.";

?>