% Ecriture au format csv de la liste des cours : printcsv(Liste_des_cours)
printcsv([]).
printcsv([[Matiere, Salle, Creneau, ID_Jour, Prof]|List]) :-
% Subject, Start Date, Start Time, End Date, End Time, Description, Location
    jour(ID_Jour, Jour),
    creneau(Creneau,Hdebut,Hfin),
    write(Matiere),write(" - "),write(Prof),write(","), %Subject
    write(Jour),write(","),                             %Start Date
    write(Hdebut),write(","),                           %Start Time
    write(Jour),write(","),                             %End Date
    write(Hfin),write(","),                             %End Time
    write(""),                                          %Description
    write(Salle),write(","),nl,                         %Location
    printcsv(List).

% Méthode d'export du .csv : exportcsv(Liste_des_cours)
exportcsv([[Matiere, Salle, Creneau, ID_Jour, Prof]|List]) :-
	% Ecriture premiere ligne du fichier csv pour google agenda
	write("Subject, Start Date, Start Time, End Date, End Time, Description, Location"),nl,
	printcsv([[Matiere, Salle, Creneau, ID_Jour, Prof]|List]).
