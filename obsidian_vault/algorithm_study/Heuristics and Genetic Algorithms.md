# Heuristics and Genetic Algorithms

> Source basis: Gonçalves, Mendes & Resende (AT&T Labs, RCMPSP); Khasnabis & Mathew 2006 (transit fleet, federal funds); Sawant 2011 (SJSU, VM scheduling); Pirozmand et al. 2021 (cloud task scheduling); Yan et al. 2026 (ICIIS, water resources); Chu (regional economy GA); Juedes et al. (simulated annealing, hill-climbing, first-fit); Yao 2023 (timetabling, FICO Xpress). See [[Summary of the Algorithmic Approach]].

When the problem is NP-hard (see [[Algorithmic Bottlenecks and NP-Hard Problems]]) and exact solvers choke, heuristics trade guaranteed optimality for speed and feasibility. The genetic algorithm (GA) is the corpus's dominant metaheuristic.

## The GA cycle, stated canonically

**Sawant (2011)** gives the four-step loop the whole corpus runs:

> "1. [Start] produce random population of n chromosomes...; 2. [Fitness] calculate the fitness value f(x) of every chromosome in the given population.; 3.1 [Selection] select two parent individuals from the population according to the fitness value.; 3.2 [Crossover] by using crossover probability, generate the new offspring by reforming the parents.; 3.3 [Mutation] with the probability of mutation, mutate the new child at some positions."

Every GA application in this vault is this loop with a different encoding and fitness function.

## Encoding: the random-key trick

**Gonçalves, Mendes & Resende** (resource-constrained multi-project scheduling) use random keys — the encoding that makes GA work on scheduling:

> "The genetic algorithm is responsible for evolving the chromosomes which represent priorities of the activities, delay times, and release dates... the mutation procedure guarantees that, if a sufficiently large number of generations are carried out, the genetic algorithm will sample the entire hypercube and consequently find the best set of random keys."

Random keys map real-valued chromosomes to schedules indirectly (sort by key → build schedule), so **every chromosome decodes to a feasible solution**. For federal planning this matters: an encoding that never produces an infeasible transfer plan is worth more than a cleverer operator that does.

## GA plus penalty functions — the exact template this vault needs

**Khasnabis & Mathew (2006)** is the closest corpus analogue to the federal allocation problem, and it combines both mechanisms:

> "The model is formulated as a non-linear optimization problem of minimizing the total weighted average remaining life of the fleet subject to the budgetary constraints. The constrained problem is transformed into an equivalent unconstrained one using the penalty function method and solved using genetic algorithm. The proposed model could act as a decision-support system for optimal resource allocation."

Their model even carries a **federal funding structure** — the closest thing in the algorithm corpus to fiscal federalism:

> "In the US, the Federal Government provides a bulk of the capital funds needed to replace the aging transit fleet, with the requirement of a minimum matching support (usually 20%) from non-federal sources."

**Why this is the template:** budget constraint (fixed pool), federal share + local match (the vertical gap in [[Federation Research/Mechanisms of Federal Resource Distribution]]), penalty-function encoding of soft rules, GA to solve. Swap "fleet remaining life" for "service-capacity equalization across islands" and the structure is the archipelagic planning model.

## Multi-objective GA: handling competing goals without pre-committing weights

**Pirozmand et al. (2021)** (multi-objective hybrid GA for cloud scheduling) and **Yan et al. (2026)** (multi-objective GA for regional water resources, with AHP and entropy weighting) handle several objectives simultaneously — the algorithmic counterpart of the seven trade-offs in [[Federation Research/Tradeoff With The Federation Resources Planning]]. Yan et al. (2026) couple GA with AHP/entropy weighting to fix objective weights objectively rather than by political assertion.

## Non-GA heuristics in the corpus

**Juedes et al.** (real-time distributed systems) cover the classical local-search family:

- **Simulated annealing** — accepts worsening moves with decreasing probability to escape local optima
- **Hill-climbing** — greedy improvement, fast and myopic
- **First-fit** — place each item in the first feasible slot; no optimization at all

**When to use which:** first-fit and hill-climbing are baselines (fast, weak); simulated annealing and GA are metaheuristics (slower, much stronger). For a transfer formula that must be **legislable and replicable** — cf. the "any official or private citizen must be able to easily duplicate calculations" rule in [[Federation Research/Translating Political Constraints to Algorithmic Rules]] — randomness-based metaheuristics are a liability: they give different answers on reruns. **The exact-formula branch (PuLP/CBC, polynomial LP) is the default for the transfer allocation itself; GA is the fallback for the combinatorial facility-location layer.**

## GA applications in this corpus

| Application | Encoding / fitness | Source |
|---|---|---|('.')|
| Resource-constrained multi-project scheduling (NP-hard) | Random keys for priorities, delay times, release dates | Gonçalves, Mendes & Resende |
| Transit fleet allocation with budget constraints | Penalty function + GA; federal 20% match | Khasnabis & Mathew 2006 |
| Cloud VM scheduling (tree encoding) | Tree-structured chromosomes | Sawant 2011 | Sawant 2011 |
| Cloud task scheduling, energy-aware, NP-hard | Multi-objective hybrid GA | Pirozmand et al. 2021 |
| Regional water resources | Improved GA + AHP + entropy weight | Yan et al. 2026 |
| Regional economic resource allocation | GA on allocation efficiency | Chu |

## Why heuristics matter — and why they don't replace formulas

**The case for heuristics:** NP-hard problems don't shrink; a good GA finds near-optimal solutions on instances where exact branch-and-bound fails (Floudas & Lin 2005; Gonçalves et al.).

**The case against (for the federal core):** the corpus's own federal design rules — transparency, replicability, simplicity — are properties of **deterministic formulas**, not of stochastic search. A transfer amount that changes with a random seed is not a law; it is a negotiation. The paper should therefore split the computation:

- **Formula layer** (transfer amounts): deterministic, open, legislated — LP or closed form
- **Combinatorial layer** (facility siting, assignment): GA where NP-hardness forces it

That split is stated in [[Summary of the Algorithmic Approach]] and applied in [[Federation Research/Translating Political Constraints to Algorithmic Rules]].

## Related notes
- [[Algorithmic Bottlenecks and NP-Hard Problems]] — why heuristics are needed
- [[Modeling Federal Constraints & Penalties]] — the penalty-function method
- [[Federation Research/Translating Political Constraints to Algorithmic Rules]] — where the deterministic/GA split lands in the design
