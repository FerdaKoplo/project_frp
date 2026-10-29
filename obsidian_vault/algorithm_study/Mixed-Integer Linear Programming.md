# Mixed-Integer Linear Programming

> Source basis: Vielma 2015, *SIAM Review* 57(1) (BEST SOURCE); Nordström 2024, SLOPPY'24 tutorial; Floudas & Lin 2005, *Annals of Operations Research* 139; Ling, Wang & Wang 2024, AAAI-24; Yao 2023, Wageningen MSc; van Willigen 2023, Wageningen MSc; Ling et al. form quote. See [[Summary of the Algorithmic Approach]].

**Mixed-Integer Linear Programming (MILP/MIP)** is the workhorse model class of this vault: a linear objective, linear constraints, and the requirement that **some** decision variables take integer (usually 0/1) values. The integer variables encode *decisions* — open or closed, assigned or not, built or skipped — which is exactly what public planning needs.

## The standard form

**Ling, Wang & Wang (AAAI-24)** state it compactly:

> "A standard MILP takes the form of min_x {c^T x | Ax <= b, x_j in Z, for all j in I}"

Read against the federal problem in [[Federation Research/What is Resources Planning]]: `x` collects the planning instruments (transfer amounts, facility openings, assignment indicators), `c^T x` is the disparity or cost objective, `Ax <= b` holds the budget, capacity, and constitutional constraints, and the integrality subset `I` marks which instruments are discrete decisions.

## Why MILP dominates practical planning

**Floudas & Lin (2005)** give the reason scheduling and allocation became MILP territory:

> "Mathematical programming, especially Mixed Integer Linear Programming (MILP), because of its rigorousness, flexibility and extensive modeling capability, has become one of the most widely explored methods for process scheduling problems."

And they are blunt about what the integer variables buy — and cost:

> "These process scheduling problems are inherently combinatorial in nature because of the many discrete decisions involved, such as equipment assignment and task allocation over time. They belong to the set of NP-complete problems (Garey and Johnson, 1979), which means that the solution time scales exponentially as the problem size increases in the worst case."

## Formulation quality is the whole game

The corpus's central methodological lesson, from **Vielma (2015)** — the strongest single source in this vault:

> "A wide range of problems can be modeled as Mixed Integer Linear Programming (MIP) problems using standard formulation techniques. However, in some cases the resulting MIP can be either too weak or too large to be effectively solved by state of the art solvers. In this survey we review advanced MIP formulation techniques that result in stronger and/or smaller formulations for a wide class of problems."

Two properties decide whether a formulation solves:

> "there are two aspects of an MIP formulation that usually have a strong impact on both simple branch-and-bound algorithms and state-of-the-art solvers: the size and strength of the LP relaxation, and the effect of branching on the formulation."

**LP relaxation** — drop the integrality requirement; solve the remaining LP:

> "The first step in solving MIP formulation (2.7) with a branch-and-bound algorithm is to solve the LP relaxation of (2.7) obtained by dropping all integrality requirements. The resulting LP problem ... is known as the root LP relaxation and can be solved efficiently both in theory and in practice."

**Sharp formulations** — the best possible relaxation bound:

> "Jeroslow and Lowe [90, 113] denoted those formulations that achieve this best possible LP relaxation bound as sharp."

**Why this matters for the paper:** the same real-world system can be written as a solvable MILP or an unsolvable one depending purely on *how* the modeller writes the constraints. Two analysts modelling the same equalization rule can get one model that solves in seconds and another that never finishes. Formulation skill is not an implementation detail; it is part of the science. See [[Algorithmic Bottlenecks and NP-Hard Problems]].

## How a modern solver actually works

**Nordström (SLOPPY'24, 2024)** gives the four-stage pipeline — and it is *not* pure branch-and-bound:

> "MIP Solving at a High Level: 1 Preprocessing (called presolving); 2 Linear programming + branch-and-bound; 3 Add cutting planes ruling out infeasible LP-solutions (branch-and-cut method going back to [Gom58]); 4 Heuristics for quickly finding good feasible solutions."

The solver landscape he describes:

> "E.g., CPLEX [CPL] (historically), Gurobi [Gur], and FICO Xpress [FIC]; Academic solvers like SCIP [SCI] and HiGHS [HiG] are excellent but not as good."

Corpus reality check: every applied paper in this vault uses exactly these — Gurobi (`gurobipy`, van Willigen 2023; Bearman et al. 2023 stack), FICO Xpress (Yao 2023), CBC via PuLP (Bearman et al. 2023), LINGO (Luna Rojas & Flores de la Mota 2022), MATLAB `cplexlp` (Ishimatsu et al. 2013).

## MILP in this corpus: three applied templates

| Application | Integer decision | Source |
|---|---|---|
| University timetabling — "two objectives and 21 constraints", FICO Xpress | assignment of courses to rooms/timeslots | Yao 2023 |
| Multi-commodity capacitated location-allocation — "The uncapacitated facility location problems (UFLP) are NP-hard, and thus the model used in this thesis is also NP-hard since it includes the UFLP" | open a facility or not | van Willigen 2023 |
| Capacitated p-median school placement — solved with PuLP/CBC in 0.2 s for 19 students × 38 schools | `Y_j = 1 if school j selected`, `X_ij = 1 if student i assigned to j` | Bearman et al. 2023 |

Yao (2023) states the hard/soft translation rule that public-sector MILP lives by:

> "the hard constraints of a timetabling problem are transformed into the constraints in the mathematical integer programming model, while the soft constraints are usually embedded in the objective function in that model (MirHassani & Habibi, 2013)."

That rule — **hard constraints as constraints, soft preferences as penalty terms in the objective** — is the direct bridge to [[Modeling Federal Constraints & Penalties]].

## Where MILP meets its limit, and ML lends a hand

**Ling, Wang & Wang (AAAI-24)** document the newest crack in the pipeline — *when to stop adding cutting planes* — and the ML fix:

> "Cutting planes (cuts) play an important role in solving mixed-integer linear programs (MILPs), as they significantly tighten the dual bounds and improve the solving performance. A key problem for cuts is when to stop cuts generation ... many modern MILP solvers employ hard-coded heuristics to tackle this problem, which tends to neglect underlying patterns among MILPs from certain applications."

> "we formulate the cuts generation stopping problem as a reinforcement learning problem and propose a novel hybrid graph representation model (HYGRO) ... achieving up to 31% improvement, on six challenging MILP problem benchmarks compared to eight competitive baselines" (integrated in SCIP).

See [[Operations Research vs Machine Learning]] for the full discussion.

## Related notes
- [[What is Operations Research]] — the discipline MILP sits inside
- [[Algorithmic Bottlenecks and NP-Hard Problems]] — why integrality costs
- [[Resource Allocation with PuLP]] — the open-source implementation route
- [[Modeling Federal Constraints & Penalties]] — hard/soft constraint translation
