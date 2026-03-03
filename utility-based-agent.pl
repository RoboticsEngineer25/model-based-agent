% utility-based-agent.pl
% Utility-Based Agent for Loan Approval
% This agent computes expected utility for each action and selects the best one.

:- dynamic income/1.
:- dynamic credit_score/1.
:- dynamic employment_status/1.
:- dynamic dti/1. % Debt-to-Income ratio

% Update predicates
update_income(Value) :-
    retractall(income(_)),
    assertz(income(Value)).

update_credit_score(Value) :-
    retractall(credit_score(_)),
    assertz(credit_score(Value)).

update_employment_status(Value) :-
    retractall(employment_status(_)),
    assertz(employment_status(Value)).

update_dti(Value) :-
    retractall(dti(_)),
    assertz(dti(Value)).

% Utility factors (simple example weights)
credit_metric_utility(CreditScore, U) :-
    U is (CreditScore - 300) / 550. % Normalize 300-850 to 0-1

employment_factor_utility(employed, 1.0).
employment_factor_utility(unemployed, 0.2).
employment_factor_utility(student, 0.5).
employment_factor_utility(self_employed, 0.7).
employment_factor_utility(_, 0.5). % Default

dti_utility(DTI, U) :-
    (DTI < 0.35 -> U = 1.0 ; DTI < 0.5 -> U = 0.7 ; U = 0.3).

profit_expectation_utility(CreditScore, U) :-
    (CreditScore >= 700 -> U = 1.0 ; CreditScore >= 600 -> U = 0.7 ; U = 0.3).

% Probability of repayment (simple model)
prob_repay(CreditScore, employed, DTI, P) :-
    credit_metric_utility(CreditScore, CU),
    employment_factor_utility(employed, EU),
    dti_utility(DTI, DU),
    P is 0.5*CU + 0.3*EU + 0.2*DU.
prob_repay(CreditScore, Status, DTI, P) :-
    credit_metric_utility(CreditScore, CU),
    employment_factor_utility(Status, EU),
    dti_utility(DTI, DU),
    P is 0.5*CU + 0.3*EU + 0.2*DU.

% Utility for each action
utility(approve_loan, U) :-
    credit_score(CS), employment_status(ES), dti(DTI),
    prob_repay(CS, ES, DTI, P),
    profit_expectation_utility(CS, ProfitU),
    U is P * ProfitU.

utility(reject_loan, 0.1). % Small utility for being cautious
utility(request_more_info, 0.2). % Utility for gathering more info

% Decide best action
utility_based_decide(Action) :-
    findall(U-A, utility(A, U), UAList),
    sort(UAList, Sorted),
    reverse(Sorted, [BestU-BestA|_]),
    Action = BestA.

% Example usage:
% ?- update_income(4000).
% ?- update_credit_score(720).
% ?- update_employment_status(employed).
% ?- update_dti(0.3).
% ?- utility_based_decide(Action).
