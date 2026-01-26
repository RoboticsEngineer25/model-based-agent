
#Model-definition for internal state
:- dynamic income/1.
:- dynamic credit_score/1.
:- dynamic employment_status/1.

update_income(Value) :-
    retractall(income(_)),
    assertz(income(Value)).

update_credit_score(Value) :-
    retractall(credit_score(_)),
    assertz(credit_score(Value)).

update_employment_status :-
    retractall(employment_status(_)),
    assertz(employment_status(Value)).


approve_loan :-
    income(I)
    employment_status(employed)
    credit_score(C)
    I >= 3000
    C >= 670


reject_loan :-
    credit_score(C)
    C < 670
    

request_more_info :-
    \+ credit_score(_)


decide(Action) :-
    approve_loan,
    Action = approve_loan,
    !.

decide(Action) :-
    reject_loan,
    Action= reject_loan,
    !.

decide(Action) :-
    request_more_info,
    Action = request_more_info.


?- update_income(4000)
?- update_employment_status(employed)
?- decide(Action).