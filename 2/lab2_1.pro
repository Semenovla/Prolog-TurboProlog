database
	parent(symbol, symbol)
	pol(symbol, symbol)
domains
	name = symbol
predicates
	upload()
	save_file()
	add_parent(name, name)
	add_pol(name, name)
	delete_people(name)
	delete_parent(name, name)
	delete_pol(name)
	nondeterm change(name, name)
	nondeterm run
	nondeterm main
	nondeterm menu(name)

	nondeterm man(name)
	nondeterm woman(name)
	nondeterm father(name)
	nondeterm mother(name)
	nondeterm son(name)
	nondeterm daughter(name)
	nondeterm brother(name, name)
	nondeterm sister(name, name)
	nondeterm grandfather(name, name)
	nondeterm grandmother(name, name)
	nondeterm uncle(name, name)
	nondeterm aunt(name, name)
	nondeterm nephew(name, name)
	nondeterm niece(name, name)
	nondeterm offspring(name, name)
	nondeterm ancestor(name, name)
	nondeterm generation(name, name)
	nondeterm child(name)
	nondeterm adult(name)
	nondeterm grand(name, name).
	nondeterm extreme(name, name).
	nondeterm extreme_(name, name).
clauses
	upload() :- consult("C:/Users/neket/Desktop/data.txt").	%��������� � ���� �� ����� �� �����
	add_parent(X, Y) :- not(parent(X, Y)), asserta(parent(X, Y)).	%���� ����� parent ���, ��������� � ��
	add_pol(X, Y) :- not(pol(X, Y)), asserta(pol(X, Y)).		%���� ����� pol ���, ��������� � ��
	save_file():- save("C:/Users/neket/Desktop/data.txt").	%��������� ���� �� � ����
	
	delete_people(X) :- retractall(parent(X, _)), retractall(parent(_, X)), retractall(pol(X, _)).	%������� ��� �����, ��������� � ��������� � �� ��
	delete_parent(X, Y) :- retractall(parent(X, Y)).						%������� ���� parent(X, Y) �� ��
	delete_pol(X) :- retractall(pol(X,_)).								%������� ���� pol(X) �� ��
	
	/*������ ��� � �� � �� ���� ������ ����� ��*/
	change(X, Y):- parent(X, Z), pol(X, W), delete_parent(X, Z), add_parent(Y, Z), add_pol(Y, W), change(X, Y).
	change(X, Y):- parent(Z, X), delete_parent(Z, X), add_parent(Z, Y), change(X, Y).
	change(X, _):- not(parent(X, _)), not(parent(_, X)), delete_pol(X), !.
	
	run :- write("������� ������ �������!\npol - �������� ���� pol(X,Y)X-�������, Y-���\nparent - �������� ���� parent(X,Y) X-������, Y-��������\ndel_pol - ������� ���� pol(X)\ndel_par - ������� ���� parent(X,Y)\n"),
	write("del_pep - ������� ��� ����� � �������� X\nrename - ������������� � � �\nupload - ��������� �� �� �����\nsave - ��������� �� � ����\n"),
	main.
	
	main :- write("*************************\n"), readln(Com), menu(Com).

	menu("pol") :- readln(X), readln(Y), add_pol(X, Y), main.
	menu("parent") :- readln(X), readln(Y), add_parent(X, Y), main.
	menu("del_pep") :- readln(X), delete_people(X), main.
	menu("del_pol") :- readln(X), delete_pol(X), main.
	menu("del_par") :- readln(X), readln(Y), delete_parent(X, Y), main.
	menu("rename") :- readln(X), readln(Y), change(X, Y), main.
	menu("upload") :- upload(), main.
	menu("save") :- save_file(), main.
	menu(_) :- write("�� ��������!\n"), !.
	
	
	man(X) :- pol(X, m).
	woman(X) :- pol(X, f).
	father(X) :- parent(_, X), pol(X, m).
	mother(X) :- parent(_, X), pol(X, f).
	son(X) :- parent(X, _), pol(X, m).
	daughter(X) :- parent(X, _), pol(X, f).
	brother(X, Y) :- parent(X, Z), parent(Y, Z), man(X), X<>Y.
	sister(X, Y) :- parent(X, Z), parent(Y, Z), woman(X), X<>Y.
	grandfather(X, Y) :- man(X), parent(Y, Z), parent(Z, X), X<>Y.
	grandmother(X, Y) :- woman(X), parent(Y, Z), parent(Z, X), X<>Y.
	grand(X, Y) :- parent(Y, Z), parent(Z, X), X<>Y.
	uncle(X, Y) :- parent(Y, Z), brother(X, Z).
	aunt(X, Y) :- parent(Y, Z), sister(X, Z).
	nephew(X, Y) :- man(X), parent(X, Z), parent(Z, W), parent(Y, W), Z<>Y.
	niece(X, Y) :- woman(X), parent(X, Z), parent(Z, W), parent(Y, W), Z<>Y.
	offspring(Y, X) :- parent(Y, X).
	ancestor(X, Y) :- parent(X, Y).
	ancestor(X, Y) :- parent(X, Z), parent(Z, Y).
	generation(X, Y) :- extreme(X, Y), X<>Y .
	generation(X, Y) :- extreme_(X, Y), X<>Y.
	extreme(X, Y) :- parent(X, Z), parent(Y, Z); parent(X, W), parent(Y, A), extreme(W, A).
	extreme_(X, Y) :- parent(Z, X), parent(Z, Y).
	extreme_(X, Y) :- parent(W, X), parent(A, Y), extreme_(W, A).
	child(X) :- parent(X, _), not(parent(_, X)).
	adult(X) :- parent(_, X).
goal
	run.
	
	
	