 prufer_decode(Prufer, Tree) :- length(Prufer, Length), Lgth is Length + 2, create(Lgth, [], List), create_tree(List, Prufer, [], Tree), !.

 create(0, Acc, Acc).
 create(Length, Acc, List) :- NewLength is Length - 1, create(NewLength, [Length|Acc], List).

 create_tree([], [], Acc, Acc).
 create_tree(List, [H|T], Acc, Tree) :- find_min_prufer(List, [H|T], -1, Min), delete_from_list(List, Min, [], NewList), 
    create_tree(NewList, T, [(Min, H)|Acc], Tree).
 create_tree([H|T], [], Acc, Tree) :- get_head(T, Head), create_tree([], [], [(H,Head)|Acc], Tree).

 find_min_prufer([], _, Min, Min).
 find_min_prufer([H|T], Prufer, Temp, Min) :- memberchk(H, Prufer) ->  find_min_prufer(T, Prufer, Temp, Min); find_min_prufer([], Prufer, H, Min).

 delete_from_list([], _, Acc, Acc).
 delete_from_list([H|T], Elem, Acc, NewList) :- H = Elem, append(Acc, T, Temp), delete_from_list([], Elem, Temp, NewList).
 delete_from_list([H|T], Elem, Acc, NewList) :- H \= Elem, append(Acc, [H], Temp), delete_from_list(T, Elem, Temp, NewList).
  
 get_head([H|_], H).