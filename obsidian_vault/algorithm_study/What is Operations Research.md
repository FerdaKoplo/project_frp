# What is Operations Research

> Source basis: Goemans 2015 (MIT 18.310A); MIT 15.053 tutorial (2013); Swanson & Woolsey (INFORMS Education Series); Goldberg, Tardos & Tarjan 1990; de Steiguer et al. 2003 (USDA NE-307); Open University M373 (2009). See [[Summary of the Algorithmic Approach]].

**Operations research (OR)** is the discipline that formalizes decisions as mathematical models — an objective to maximize or minimize, a set of constraints that limit the choices — and then solves them with algorithms. It began as a wartime practice and became the mathematical backbone of planning in government, industry, and logistics.
## Origins: from war to planning

The discipline's birth is military. **de Steiguer et al. (2003)**, annotating multi-criteria decision models in natural resources, locate the origin:

> "First developed during World War II by the U.S. military for strategic decisionmaking, operations research involves the use of quantitative analytical techniques to optimize the allocation of scarce resources."

The same period produced the core solver: **"In 1947, George B. Dantzig developed a technique to solve linear programs.This technique is referred to as the simplex method"** (Goemans 2015).

## The three element structure of any OR problem

Every OR model, regardless of domain, has the same three parts. **MIT 15.053 (2013)** states the canonical version:

> "Each optimization problem consists of three elements: decision variables: describe our choices that are under our control; objective function: describes a criterion that we wish to minimize (e.g., cost) or maximize (e.g., profit); constraints: describe the limitations that restrict our choices for decision variables."

This three-part structure is the bridge between the political science in [[What is Resources Planning]] and the mathematics in this vault: **expenditure assignment and revenue assignment are constraints; equalization and service capacity are objectives; transfer instruments are decision variables.**

## What counts as a "real" OR problem

The MIT tutorial gives the two-part test that separated OR from the rest of applied mathematics, applicability and solvability:

> "Linear programming is a central topic in optimization.LP has attracted most of its attention in optimization during the last six decades for two main reasons: Applicability: There are many real-world applications that can be modeled as linear programming; Solvability: There are theoretically and practically efficient techniques for solving large-scale problems."

A problem is an OR problem when it can be **modeled** (objective + constraints written down) **and solved** (an algorithm terminates in practical time). The second condition is not guaranteed. See [[Algorithmic Bottlenecks and NP-Hard Problems]].

## Where the corpus's OR lives

**Goemans (2015)** states LP's double role — practical solver and theoretical tool:

> "Linear Programming deals with the problem of optimizing a linear objective function subject to linear equality and inequality constraints on the decision variables. Linear programming has many practical applications (in transportation, production planning). It is also the building block for combinatorial optimization. One aspect of linear programming which is often forgotten is the fact that it is also a useful proof technique."

**Goldberg, Tardos & Tarjan (1990)** locate network flows at OR's center:

> "Network flow problems are central problems in operations research, computer science, and engineering and they arise in many real world applications."

**Swanson & Woolsey** (INFORMS Education Series) capture the educational posture of the corpus — OR as a skill to be transmitted, with special structure exploited for speed:

> "Network flow algorithms have been developed to handle a special class of linear programming problems. These problems may each be described by a network whose links carry flow. Network algorithms take advantage of this special structure to produce an optimal solution much more quickly, with less storage required, and with virtually no round off error in comparison with general linear programming codes."

## OR is about *doing less and gaining more*

The MIT tutorial's framing is the discipline's own self-description:

> "Optimization is an important and fascinating area of management science and operations research. It helps to do less work, but gain more."

That is the exact claim this vault tests against archipelagic federal resource planning: the equalization formula in [[Translating Political Constraints to Algorithmic Rules]] is an OR model of a political problem, and the corpus's OR half supplies the modeling discipline the political half needs.

## Sub-fields covered in this vault

| Sub-field               | Note                                                                                   | Corpus strength                                       |
| ----------------------- | -------------------------------------------------------------------------------------- | ----------------------------------------------------- |
| Linear programming      | [[Mixed-Integer Linear Programming\|LP basics]] (in MILP note)                         | STRONG (Goemans, Open University M373, MIT 15.053)    |
| Network flows           | [[Spatial and Location-Allocation Models]] flows + MILP note                           | STRONG (Goldberg, Tardos, Tarjan, CME 305, Ishimatsu) |
| Integer & combinatorial | [[Mixed-Integer Linear Programming]], [[Algorithmic Bottlenecks and NP-Hard Problems]] | STRONG (Vielma 2015, Floudas & Lin 2005)              |
| Heuristics              | [[Heuristics and Genetic Algorithms]]                                                  | STRONG (Gonçalves et al., Khasnabis & Mathew)         |
| Location science        | [[Spatial and Location-Allocation Models]]                                             | STRONG (p-median/spopt, day-care, forestry MCDM)      |
| OR + ML                 | [[Operations Research vs Machine Learning]]                                            | WEAK–MODERATE                                         |

## Related notes
- [[Mixed-Integer Linear Programming]] : the workhorse model class
- [[Summary of the Algorithmic Approach]] : how this vault's OR maps onto the federal problem
- [[What is Resources Planning]] : the policy chain that the models formalize
