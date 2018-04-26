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

jour(X) :- jour(X, _). % La journée qui a pour id X est un jour répetorié s'il l'on trouve une date associée

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