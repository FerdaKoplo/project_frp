# Modeling Federal Constraints & Penalties

> Source basis: Israel & Lund 1999 (*J. Water Res. Plan. Manage.*, Truckee-Carson) — BEST source; Trivella et al. 2021 (*TR-E* 150, soft transit-time constraints); Khasnabis & Mathew 2006 (federal 20% match + penalty method); Yao 2023 (hard/soft constraint rule); Luna Rojas & Flores de la Mota 2022 (public-sector budget constraints); Floudas & Lin 2005; AIMMS Modeling Guide (LP tricks). See [[Summary of the Algorithmic Approach]].

**Constraint modelling is where politics enters the algorithm.** The federal equalization design in [[Federation Research/Translating Political Constraints to Algorithmic Rules]] must decide, for every rule, whether it is **hard** (a constraint: violates → infeasible) or **soft** (a penalty in the objective: violates → costly but allowed). This note collects the corpus's constraint/penalty modelling techniques.

## The hard/soft distinction — the foundational rule

**Yao (2023)** states the translation rule for public-sector problems:

> "These requirements are classified into two categories: hard constraints and soft constraints (Babaei, Karimpour & Hadidi, 2015). Hard constraints cannot be violated to deliver a feasible solution. ... Soft constraints shall be satisfied as much as possible to ensure the quality of a timetable... Then, the hard constraints of a timetabling problem are transformed into the constraints in the mathematical integer programming model, while the soft constraints are usually embedded in the objective function in that model (MirHassani & Habibi, 2013)."

**Hard → written as constraints. Soft → moved into the objective as penalty terms.** For the archipelagic transfer model this is the most consequential design decision:

| Federal rule | Hard or soft? | Consequence of the choice |
|---|---|---|
| Total transfer pool is fixed (budget envelope) | **Hard** | Infeasibility if need exceeds pool — true in practice |
| Every province receives a positive share | **Hard** | Easy to impose; politically essential |
| transfers ≥ own-revenue-effort floor | **Hard** | Anti-dependence rule from Ter-Minassian |
| Full service-cost equalization across islands | **Soft** | Hard constraint would be infeasible (fixed pool); penalty keeps it aspirational — exactly the "affirmation vs. capacity" tension in Said et al. |
| Connectivity investment share | **Soft** | Portfolio trade-off with resilience/protection (Rijoly et al.) — must trade off, not be enforced |

## Soft constraints with penalty functions — the liner-shipping lesson

**Trivella et al. (2021)** make the case for penalty encoding over hard deadlines in distribution network design:

> "In practical contexts, however, these hard limits may fail to provide sufficient flexibility since routes with even tiny delays would be discarded."

> "we study an MCNF generalization where transit time restrictions are modeled as soft constraints, in which delays are discouraged using penalty functions of transit time. Similarly, early commodity arrivals can receive a discount in cost."

> "Ideally, we do not want to exclude a priori longer routes but instead punish them using a penalty which is a function of the delay, i.e., the extra time taken to route a commodity with respect to the target transit time established for that commodity. The larger the delay, the more costly the route will be, reflecting e.g. increased inventory costs or decreased customer satisfaction."

> "Extensive numerical experiments conducted on realistic liner shipping instances reveal that the explicit consideration of penalty functions can lead to significant cost reductions compared to hard transit time deadlines."

**Direct federal translation:** "hard deadline → infeasible" is the formula that ignores island cost realities; "delay penalty in the objective" is the formula that keeps all provinces feasible while pushing funding toward the under-served. Trivella et al. measured real savings from the change; the same structure carries the archipelagic cost-of-provision index.

## The masterpiece in this corpus: priority-preserving unit penalties

**Israel & Lund (1999)** solved the problem nearest to fiscal-federal design: encode a **legal priority hierarchy** (western US water rights) into LP cost coefficients. Their system:

The governing principle:

> "The overarching principle for setting unit penalties for priority-based operations is that senior unit penalties must exceed the combined junior unit penalties for any feasible competing space-time path through the system for any unit of water potentially available at the senior location."

Translation to fiscal language: **the penalty for under-serving a high-priority (high-need) jurisdiction must exceed the summed penalties for all lower-priority competitors that could take its resources** — otherwise the optimizer will rationally sacrifice the senior claim, and the "priority" is fiction.

This is a *lexicographic-approximation* device: it makes the LP respect a hierarchy of claims without solving a sequence of problems, purely through cost coefficients.

### The scaling danger — crucial for federal formulas

Israel & Lund also document the failure mode that fiscal formulas must avoid:

> "In simple systems with few water users, assigning unit cost coefficients that preserve priority rank may appear to be a relatively straightforward task. However, even in these simple systems, the unit cost coefficient c_k for water use k must satisfy several conditions if true system priorities are to be guaranteed under variety of system configurations and flow conditions. Intuitive rules such as c1 << c2 << c3 may not always work. Selecting arbitrarily large values, potentially resulting in a large range in the unit cost coefficients, also may induce scaling problems in some optimization algorithms."

**Warnings that map one-to-one onto equalization weights:**
- Naive weight ladders (need tier 1 ≫ tier 2 ≫ tier 3) **do not always work**
- Arbitrarily large weights **break the solver numerically** — extreme coefficient ranges cause scaling problems (cf. Open University M373 on badly scaled systems)
- The weights must be **computed by a verifiable algorithm, not hand-tuned**

### The algorithm

Israel & Lund make the rule an LP itself:

> "The algorithm is valid for any network flow or linear programming based model. The algorithm is first presented conceptually in the form of rules and then as a linear program (LP) that serves as a preprocessor to an NFP model. Following an example application to the Truckee Carson system, the formulation is then generalized based on a system connectivity matrix and vector of use priorities."

**A preprocessor LP that computes the penalty coefficients for the main model.** For the federal application: an auxiliary LP computes defensible equalization weights from the connectivity matrix (which islands can trade with which) and the priority vector (legislated need ranking). This is a **two-stage formula construction** and it is fully replicable — matching Haque et al.'s Box 11 rule that "any official or private citizen must be able to easily duplicate calculations" (see [[Federation Research/Translating Political Constraints to Algorithmic Rules]]).

## Penalty functions combined with genetic algorithms

**Khasnabis & Mathew (2006)** show the standard way to handle budget constraints inside a GA:

> "The constrained problem is transformed into an equivalent unconstrained one using the penalty function method and solved using genetic algorithm."

With the federal funding structure written into the constraint set:

> "In the US, the Federal Government provides a bulk of the capital funds needed to replace the aging transit fleet, with the requirement of a minimum matching support (usually 20%) from non-federal sources."

**The "20% match" is the own-revenue-effort floor in miniature** — the anti-dependence rule from [[Federation Research/Systemic Risks & Failure Modes in Developing Federations]] (F5) modeled as a hard budget-share constraint.

## LP tricks that implement policy patterns

From the **AIMMS Modeling Guide** — standard reformulations for policy-shaped objectives:

- **Absolute values** (fairness as deviation-minimization): "The presence of absolute values in the objective function means it is not possible to directly apply linear programming. The absolute values can be avoided by replacing each x_j and |x_j| as follows. x_j = x_j^+ - x_j^-; |x_j| = x_j^+ + x_j^-; x_j^+, x_j^- >= 0" — minimizing |deviation from equal per-capita share| becomes an LP. **This is the mathematical form of the equity objective.**
- **Fractional objectives** (efficiency ratios): "In this problem the objective is the ratio of two linear terms... Such problems typically arise in financial planning models. Possible objectives include the rate of return, turnover ratios, accounting ratios and productivity ratios." — Charnes-Cooper transformation returns it to LP; useful when the objective is "spending per unit of need served" rather than raw cost.
- **Goal programming** — multiple targets with deviation penalties; the many-soft-goal case for multi-objective federal planning.

## Time-horizon constraints: discrete vs continuous time

**Floudas & Lin (2005)** classify scheduling models by time representation — "Discrete-time and continuous-time models are presented along with their strengths and limitations" — a direct analogue for multi-year budget planning: discrete budget periods (simple, many periods) vs continuous-time events (compact, harder).

## Synthesis: the federal constraint catalogue

| # | Constraint/penalty | Type | Source | Encoding in the model |
|---|---|---|---|---|
| C1 | Fixed total pool | Hard | Nevat & Mughal (sum_k a_k = 1) | Budget equality constraint |
| C2 | Every province positive share | Hard | assignment constraint (sum_j X_ij = 1) | Positivity constraints |
| C3 | Minimum local match (20%) | Hard | Khasnabis & Mathew (federal funds) | Share-of-budget inequality |
| C4 | Full cost equalization | Soft | Trivella et al. (delay penalties) | Penalty term in objective |
| C5 | Priority hierarchy of need | Soft (via costs) | Israel & Lund (unit penalties) | Preprocessor-LP-generated weights |
| C6 | Connectivity/resilience portfolio balance | Soft | Rijoly et al. (portfolio framing) | Multi-objective / Pareto front |
| C7 | Pool growth with national revenue | Hard (structural) | *(synthesis — see Federation Research)* | Index-linked pool parameter |

**C5 is this vault's distinctive contribution:** Israel & Lund's priority-preserving unit penalties give a replicable, solver-safe way to encode the *need hierarchy* into an LP without hand-tuned weights — the antidote to both the naive ladder and the scaling blow-up.

## Related notes
- [[Federation Research/Translating Political Constraints to Algorithmic Rules]] — the political rules this note encodes
- [[Algorithmic Bottlenecks and NP-Hard Problems]] — why soft encoding can preserve tractability
- [[Heuristics and Genetic Algorithms]] — penalty function method inside GA
- [[Federation Research/Systemic Risks & Failure Modes in Developing Federations]] — what happens when the constraint set is wrong
