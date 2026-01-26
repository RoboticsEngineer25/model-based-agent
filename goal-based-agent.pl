% Define the goal state
goal_state(low_risk_portfolio).

% Actions the agent can take
possible_action(approve_immediately).
possible_action(approve_with_cosigner).
possible_action(approve_with_collateral).
possible_action(reject).

% Check if action achieves goal
achieves_goal(Name, approve_immediately, low_risk_portfolio) :-
    applicant(Name, Income, CreditScore, LoanAmount, employed),
    CreditScore >= 720,
    debt_to_income_ratio(Income, LoanAmount, DTI),
    DTI =< 40.

achieves_goal(Name, approve_with_cosigner, low_risk_portfolio) :-
    applicant(Name, _, CreditScore, _, employed),
    CreditScore >= 650,
    CreditScore < 720.

achieves_goal(Name, approve_with_collateral, low_risk_portfolio) :-
    applicant(Name, Income, CreditScore, LoanAmount, employed),
    CreditScore >= 600,
    debt_to_income_ratio(Income, LoanAmount, DTI),
    DTI =< 50.

achieves_goal(Name, reject, low_risk_portfolio) :-
    applicant(Name, _, CreditScore, _, unemployed),
    CreditScore < 700.

achieves_goal(Name, reject, low_risk_portfolio) :-
    applicant(Name, _, CreditScore, _, _),
    CreditScore < 600.

% Goal-based decision: find action that achieves goal
goal_based_agent(Name, Action) :-
    goal_state(Goal),
    possible_action(Action),
    achieves_goal(Name, Action, Goal),
    !. % Take first action that achieves goal

% Test goal-based agent
test_goal_based :-
    write('===== GOAL-BASED AGENT ====='), nl,
    write('Goal: Build low-risk loan portfolio'), nl,
    write('Plans actions to achieve goal'), nl, nl,
    applicant(Name, _, Score, _, Emp),
    (   goal_based_agent(Name, Action)
    ->  format('~w (Score:~w, Job:~w) -> ~w~n', [Name, Score, Emp, Action])
    ;   format('~w -> no_safe_action~n', [Name])
    ),
    fail.
test_goal_based :- nl.
