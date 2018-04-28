%%%%%%%%%%%%%%%%%
%%%% Données %%%%
%%%%%%%%%%%%%%%%%

%%%% Jours %%%%
% jour(ID_jour, date, est_un_jour_travaillé)
% Semaine 1 
jour(0,'4/2/2018', 1).
jour(1,'4/3/2018', 1).
jour(2,'4/4/2018', 1).
jour(3,'4/5/2018', 1).
jour(4,'4/6/2018', 1).
jour(5,'4/7/2018', 0).
jour(6,'4/8/2018', 0).

% Semaine 2
jour(7,'4/9/2018', 1).
jour(8,'4/10/2018', 1).
jour(9,'4/11/2018', 1).
jour(10,'4/12/2018', 1).
jour(11,'4/13/2018', 1).
jour(12,'4/14/2018', 0).
jour(13,'4/15/2018', 0).

% Semaine 3 
jour(14,'4/16/2018', 1).
jour(15,'4/17/2018', 1).
jour(16,'4/18/2018', 1).
jour(17,'4/19/2018', 1).
jour(18,'4/20/2018', 1).
jour(19,'4/21/2018', 0).
jour(20,'4/22/2018', 0).

% Semaine 4
jour(21,'4/23/2018', 1).
jour(22,'4/24/2018', 1).
jour(23,'4/25/2018', 1).
jour(24,'4/26/2018', 1).
jour(25,'4/27/2018', 1).
jour(26,'4/28/2018', 0).
jour(27,'4/29/2018', 0).

%%%% Crénaux %%%%
% creneau(ID_Creneau, horaire de début, horaire de fin, temps total)
creneau(0, '8:00 AM', '10:00 AM', 2).
creneau(1, '10:00 AM', '12:00 AM', 2).
creneau(2, '1:30 PM', '3:30 PM', 2).
creneau(3, '3:30 PM', '5:30 PM', 2).

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
matiere(0, 'Programmation fonctionnelle', 12).
matiere(1, 'Programmation parallele', 12).
matiere(2, 'Chinois', 4).
matiere(3, 'Anglais', 5).
matiere(4, 'Communication', 3).
matiere(5, 'Réseau', 12).
matiere(6, 'DevOps', 12).
matiere(7, 'ISA', 12).
matiere(8, 'WebServices', 10).

%%%% Professeurs %%%
% professeur(ID_Professeur, nom, ID_Matiere, nombre_heures_enseignement)
professeur(0, 'Collet', 6, 8).
professeur(1, 'Tigli', 8, 13).
professeur(2, 'Pinna', 7, 8).
professeur(3, 'Mosser', 7, 8).
professeur(4, 'Aygen', 3, 8).
professeur(5, 'Tang', 2, 6).
professeur(6, 'Buis', 4, 5).
professeur(7, 'Lopez', 5, 10).
professeur(8, 'Baude', 5, 5).
professeur(9, 'Molines', 6, 8).
professeur(10, 'Gallesio', 0, 8).
professeur(11, 'Rueher', 0, 8).
professeur(8, 'Huet', 1, 12).

%%%%%%%%%%%%%%%%%%%
%%%% Fonctions %%%%
%%%%%%%%%%%%%%%%%%%

%%%% Jours %%%%
% La journée qui a pour id X est un jour répetorié si on le trouve dans la base de données
jour(X):- jour(X,_,_). 

% La journée qui a pour id X est un jour répetorié si on le trouve dans la base de données
est_un_jour_travaille(X):- jour(X,_,1). 

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
professeur(X):- professeur(X,_,_,_).
% X enseigne la matiere MatiereID
enseigne_par(X, MatiereID):- professeur(X,_,MatiereID,_).
% X est enseigné par ProfesseurID
enseigne(ProfesseurID, X):- professeur(ProfesseurID,_,X,_).

% MatiereID fait X heures
nb_heure_matiere(MatiereID,X):- matiere(MatiereID,_,X).

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

