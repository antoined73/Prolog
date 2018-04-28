%%%%%%%%%%%%%%%%%
%%%% Données %%%%
%%%%%%%%%%%%%%%%%

%%%% Jours %%%%
% jour(ID_jour, date)
% Semaine 1 
jour(0,'4/2/2018').
jour(1,'4/3/2018').
jour(2,'4/4/2018').
jour(3,'4/5/2018').
jour(4,'4/6/2018').

% Semaine 2
jour(7,'4/9/2018').
jour(8,'4/10/2018').
jour(9,'4/11/2018').
jour(10,'4/12/2018').
jour(11,'4/13/2018').

% Semaine 3 
jour(14,'4/16/2018').
jour(15,'4/17/2018').
jour(16,'4/18/2018').
jour(17,'4/19/2018').
jour(18,'4/20/2018').

% Semaine 4
jour(21,'4/23/2018').
jour(22,'4/24/2018').
jour(23,'4/25/2018').
jour(24,'4/26/2018').
jour(25,'4/27/2018').

%%%% Crénaux %%%%
creneau(0, '8:00 AM', '10:00 AM').
creneau(1, '10:00 AM', '12:00 AM').
creneau(2, '1:30 PM', '3:30 PM').
creneau(3, '3:30 PM', '5:30 PM').

%%%% Salle %%%%
salle(0, 'O+110').
salle(1, 'O+111').
salle(2, 'O+112').
salle(3, 'O+113').
salle(4, 'O+114').
salle(5, 'O+115').
salle(6, 'E+110').
salle(7, 'E+111').
salle(8, 'E+112').
salle(9, 'E+113').
salle(10, 'E+114').
salle(11, 'E+115').

%%%% Matière %%%%
% matiere(ID_Matiere, nom, nombre_heures_total)
matiere(0, 'Programmation fonctionnelle', 27).
matiere(1, 'Programmation parallele', 22).
matiere(2, 'Chinois', 12).
matiere(3, 'Anglais', 14).
matiere(4, 'Communication', 10).
matiere(5, 'Réseau', 27).
matiere(6, 'DevOps', 28).
matiere(7, 'ISA', 28).
matiere(8, 'WebServices', 24).

%%%% Professeurs %%%
% professeur(ID_Professeur, nom, ID_Matiere, nombre_heures_enseignement)
professeur(0, 'Collet', 6, 15).
professeur(1, 'Tigli', 8, 25).
professeur(2, 'Pinna', 7, 15).
professeur(3, 'Mosser', 7, 15).
professeur(4, 'Aygen', 3, 15).
professeur(5, 'Tang', 2, 12).
professeur(6, 'Buis', 4, 10).
professeur(7, 'Lopez', 5, 22).
professeur(8, 'Baude', 5, 10).
professeur(9, 'Molines', 6, 15).
professeur(10, 'Gallesio', 0, 15).
professeur(11, 'Rueher', 0, 15).
professeur(8, 'Huet', 1, 25).

%%%%%%%%%%%%%%%%%%%
%%%% Fonctions %%%%
%%%%%%%%%%%%%%%%%%%

%%%% Jours %%%%
% La journée qui a pour id X est un jour répetorié si on le trouve dans la base de données
jour(X):- jour(X,_,_). 

% La journée qui a pour id X est un jour répetorié si on le trouve dans la base de données
est_un_jour_travaille(X,EstTravaille):- jour(X,_,EstTravaille). 

%%%% Crénaux %%%%
% Le creneau qui a pour id X est un creneau répetorié si on le trouve dans la base de données
creneau(X):- creneau(X,_,_). 

%%%% Salle %%%%
% La salle d'id X est un salle si on la trouve dans la base de données
salle(X):- salle(X,_).

%%%% Matière %%%%
% Une matiere d'id X est une matiere si on la trouve dans la base de données
matiere(X):- matiere(X,_,_).

%%% Professeur %%%
% Un professeur d'id X est un professseur si on le trouve dans la base de données
professeur(X):- professeur(X,_,_).

% Permet d'obtenir le nombre d'heures d'une matiere dans Nb_heures
nb_heure_matiere(X,Nb_heures):- matiere(X,_,Nb_heures).


%%%%%%%%%%%%%%%%%%%
%%%%  Compter  %%%%
%%%%%%%%%%%%%%%%%%%

% Permet d'obtenir dans R le nombre d'heure deja présente dans le planning pour la matiere M voulue
nb_hours_assigned(Planning,M,R):-
	nb_hours_assigned_bis(Planning,M,0,R).

% Si le créneau est assigné a la matiere M, on ajoute 2h au res et on passe a la suivante.
nb_hours_assigned_bis([[M,_,_,_,_]|L],M,N,R):-
	N1 is N+2,
	nb_hours_assigned_bis(L,M,N1,R).

% Si le créneau n'est pas assigné a la matiere, on passe a la suivante.
nb_hours_assigned_bis([[_,_,_,_,_]|L],M,N,R):-
	nb_hours_assigned_bis(L,M,N,R).

% Si le planning est vide, on a la recherche.
nb_hours_assigned_bis([],_,N,R):-R is N.


%%%% Affichage au format csv %%%%

% Ecriture au format csv de la liste des cours : printcsv(Liste_des_cours)
printcsv([]).
printcsv([[Matiere, Salle, Creneau, ID_Jour, Prof]|List]) :-
% Subject, Start Date, Start Time, End Date, End Time, Description, Location
    jour(ID_Jour, Jour),
    creneau(Creneau,Hdebut,Hfin),
    write(Matiere),write(' - '),write(Prof),write(','), %Subject
    write(Jour),write(','),                             %Start Date
    write(Hdebut),write(','),                           %Start Time
    write(Jour),write(','),                             %End Date
    write(Hfin),write(','),                             %End Time
    write(''),                                          %Description
    write(Salle),write(','),nl,                         %Location
    printcsv(List).

% Méthode d'export du .csv : exportcsv(Liste_des_cours)
exportcsv([[Matiere, Salle, Creneau, ID_Jour, Prof]|List]) :-
	% Ecriture premiere ligne du fichier csv pour google agenda
	write('Subject, Start Date, Start Time, End Date, End Time, Description, Location'),nl,
	printcsv([[Matiere, Salle, Creneau, ID_Jour, Prof]|List]).