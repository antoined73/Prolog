%%%%%%%%%%%%%%%%%
%%%% Données %%%%
%%%%%%%%%%%%%%%%%

%%%% Jours %%%%
% Semaine 1 
jour(0,'4/2/2018').
jour(1,'4/3/2018').
jour(2,'4/4/2018').
jour(3,'4/5/2018').
jour(4,'4/6/2018').

% Semaine 2
jour(5,'4/9/2018').
jour(6,'4/10/2018').
jour(7,'4/11/2018').
jour(8,'4/12/2018').
jour(9,'4/13/2018').

% Semaine 3 
jour(10,'4/16/2018').
jour(11,'4/17/2018').
jour(12,'4/18/2018').
jour(13,'4/19/2018').
jour(14,'4/20/2018').

% Semaine 4
jour(15,'4/23/2018').
jour(16,'4/24/2018').
jour(17,'4/25/2018').
jour(18,'4/26/2018').
jour(19,'4/27/2018').

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

%%%%%%%%%%%%%%%%%%%
%%%% Fonctions %%%%
%%%%%%%%%%%%%%%%%%%

%%%% Jours %%%%

% La journée qui a pour id X est un jour répetorié si on le trouve dans la base de données
jour(X) :- jour(X, _). 

%%%% Crénaux %%%%

% Le creneau qui a pour id X est un creneau répetorié si on le trouve dans la base de données
creneau(X):- creneau(X,_,_). 


%%%% Salle %%%%

% La salle d'id X est un salle si on la trouve dans la base de données
salle(X):- salle(X,_).

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
    write('),                                          %Description
    write(Salle),write(','),nl,                         %Location
    printcsv(List).

% Méthode d'export du .csv : exportcsv(Liste_des_cours)
exportcsv([[Matiere, Salle, Creneau, ID_Jour, Prof]|List]) :-
	% Ecriture premiere ligne du fichier csv pour google agenda
	write('Subject, Start Date, Start Time, End Date, End Time, Description, Location'),nl,
	printcsv([[Matiere, Salle, Creneau, ID_Jour, Prof]|List]).