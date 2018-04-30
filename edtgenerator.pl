%%%%%%%%%%%%%%%%%
%%%% Donnees %%%%
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
% creneau(ID_Creneau, horaire de début, horaire de fin, temps total)
creneau(0, '8:00 AM', '10:00 AM', 2).
creneau(1, '10:00 AM', '12:00 PM', 2).
creneau(2, '1:30 PM', '3:30 PM', 2).
creneau(3, '3:30 PM', '5:30 PM', 2).
creneau(4, '5:30 PM', '6:30 PM', 1).

%%%% Salle %%%%
% salle(ID_Salle, NomSalle)
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

%%%% Professeurs %%%
% professeur(ID_Professeur, nom, ID_Matiere)
professeur(0, 'Collet', 6).
professeur(1, 'Tigli', 8).
professeur(2, 'Pinna', 7).
professeur(3, 'Mosser', 7).
professeur(4, 'Aygen', 3).
professeur(5, 'Tang', 2).
professeur(6, 'Buis', 4).
professeur(7, 'Lopez', 5).
professeur(8, 'Baude', 5).
professeur(9, 'Molines', 6).
professeur(10, 'Gallesio', 0).
professeur(11, 'Rueher', 0).
professeur(8, 'Huet', 1).

%%%% Matière %%%%
% matiere(ID_matiere, NomMatiere, Nombre_heures_matiere)
matiere(0, 'Programmation fonctionnelle', 14).
matiere(1, 'Programmation parallele', 14).
matiere(2, 'Chinois', 4).
matiere(3, 'Anglais', 7).
matiere(4, 'Communication', 4).
matiere(5, 'Reseau', 14).
matiere(6, 'DevOps', 4).
matiere(7, 'ISA', 5).
matiere(8, 'WebServices', 14).

%%%%%%%%%%%%%%%%%%%
%%%% Fonctions %%%%
%%%%%%%%%%%%%%%%%%%

%%%% Jours %%%%
% La journée qui a pour id X est un jour si on le trouve dans la base de donnees
jour(X):- jour(X,_). 

%%%% Creneaux %%%%
% Le creneau qui a pour id X est un creneau si on le trouve dans la base de donnees
creneau(X):- creneau(X,_,_,_).

%%%% Salle %%%%
% La salle d'id X est un salle si on la trouve dans la base de donnees
salle(X):- salle(X,_).

%%%% Matiere %%%%
% Une matiere d'id X est une matiere si on la trouve dans la base de donnees
matiere(X):- matiere(X,_,_).

%%% Professeur %%%

% Permet d'obtenir le nombre d'heures d'une matiere dans Nb_heures
nb_heure_matiere(X,Nb_heures):- matiere(X,_,Nb_heures).

% Un professeur d'id X est un professseur si on le trouve dans la base de données
professeur(X):- professeur(X,_,_,_).
% X enseigne la matiere MatiereID
enseigne_par(X, MatiereID):- professeur(X,_,MatiereID,_).
% X est enseigné par ProfesseurID
enseigne(ProfesseurID, X):- professeur(ProfesseurID,_,X,_).

%%%%%%%%%%%%%%%%%%%
%%%%  Compter  %%%%
%%%%%%%%%%%%%%%%%%%

% Permet de tester le fait que N est bien inférieur aux heures voulues pour la matière NbHeuresMatiere
nb_hours_assigned(Planning,MatiereNom,NbHeuresMatiere):-
    %write('nb_hours_assigned appele : '),write(Planning),nl,
	nb_hours_assigned_bis(Planning,MatiereNom,0, NbHeuresMatiere).

% Si le creneau est assignee a la matiere MatiereNom, on ajoute 2h au res et on passe a la suivante.
nb_hours_assigned_bis([[MatiereNom,_,_,_,_]|L],MatiereNom,N, NbHeuresMatiere):-
    N1 is N+2,
	nb_hours_assigned_bis(L,MatiereNom,N1, NbHeuresMatiere).

% Si le creneau n'est pas assignee a la matiere, on passe a la suivante.
nb_hours_assigned_bis([[_,_,_,_,_]|L],MatiereNom,N, NbHeuresMatiere):-
	nb_hours_assigned_bis(L,MatiereNom,N, NbHeuresMatiere).

% Si le planning est vide, on a la recherche voulue : on test le fait que N est bien inférieur aux heures voulues pour la matière
nb_hours_assigned_bis([],_,N, NbHeuresMatiere):-
    NbHeuresMatiere is N.


%%%% Affichage au format csv %%%%

% Ecriture au format csv de la liste des cours : printcsv(Liste_des_cours)
printcsv([]).
printcsv([[Matiere, Salle, ID_Creneau, Jour, Prof]|List]) :-
% Subject, Start Date, Start Time, End Date, End Time, Description, Location
    creneau(ID_Creneau,Hdebut,Hfin,_),
    write(Matiere),write(' - '),write(Prof),write(','), %Subject
    write(Jour),write(','),                             %Start Date
    write(Hdebut),write(','),                           %Start Time
    write(Jour),write(','),                             %End Date
    write(Hfin),write(','),                             %End Time
    write(''),                                          %Description
    write(Salle),write(','),nl,                         %Location
    printcsv(List).

% Methode d'export du .csv : exportcsv(Liste_des_cours)
exportcsv([[Matiere, Salle, ID_Creneau, Jour, Prof]|List]) :-
	% Ecriture premiere ligne du fichier csv pour google agenda
	write('Subject, Start Date, Start Time, End Date, End Time, Description, Location'),nl,
	printcsv([[Matiere, Salle, ID_Creneau, Jour, Prof]|List]).


genere_edt :-
    findall(X, matiere(X), L),
    ajouter_matiere_edt(L, []).

%Exemple
% Planning : [[NomMatiere,NomSalle,ID_Creneau,NomJour,NomProf],[NomMatiere,NomSalle,ID_Creneau,NomJour,NomProf]...]
% ajouter_matiere_edt( ID_Matieres_a_ajouter, Planning)
ajouter_matiere_edt([], Planning) :- write(Planning),nl,exportcsv(Planning).

ajouter_matiere_edt([ID_Mat|AutresIDMatieres],Planning) :- 
matiere(ID_Mat, NomMatiere, NbHeuresMatiere),
ajouter_matiere_edt_bis([ID_Mat|AutresIDMatieres],Planning,0,NbHeuresMatiere).


ajouter_matiere_edt_bis([ID_Mat|AutresIDMatieres], Planning, Jourmin, Nbr) :- 
Nbr =< 0, % Si on a ajoute toutes les heures pour une matiere
ajouter_matiere_edt(AutresIDMatieres,Planning). 

ajouter_matiere_edt_bis([ID_Mat|AutresIDMatieres], Planning, Jourmin, NbHrestant) :-
    matiere(ID_Mat, NomMatiere, NbHeuresMatiere),
    NbHrestant > 0, % On veut que NbHrestant ne dépasse pas NbHeuresMatiere OR prolog cherche d'autres valeurs pour Nbh ! WTF ?
    jour(ID_Jour, NomJour), % On parcours tous les jours
    ID_Jour > Jourmin, % On prends le premier qui soit supérieur au jour minimum
    creneau(ID_Creneau,_,_,TempsTotalCreneau), % On prends tous les creneaux
    salle(ID_Salle, NomSalle), % On parcours toutes les salles
    enseigne_par(ID_Prof,ID_Mat), % On parcours tous les profs qui enseignent cette matiere
    professeur(ID_Prof, NomProf,_,_), % On prend leur nom

    % Contraintes
    \+member([_, _, ID_Creneau, NomJour, _], Planning), % On vérifie que le créneau c'est pas déjà pris
    \+member([_, NomSalle, ID_Creneau, NomJour, _], Planning), % On vérifie qu'une scéance sur la meme salle et le meme créneaux existe pas
    \+member([_, _, ID_Creneau, NomJour, NomProf], Planning), % On vérifie qu'un prof n'a pas cours le même jour pendant ce créneau

    append(Planning, [[NomMatiere, NomSalle, ID_Creneau, NomJour, NomProf]], Result), % On ajoute le résultat au Planning`
    Nbr is NbHrestant-TempsTotalCreneau,
    Nbr >= 0,
    ajouter_matiere_edt_bis([ID_Mat|AutresIDMatieres], Result, Jourmin, Nbr).

