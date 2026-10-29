# Operations Research vs Machine Learning

> Source basis: Ling, Wang & Wang 2024 (AAAI-24, HYGRO) — strongest ML+OR piece; Nevat & Mughal 2022 (*Atmosphere* 13, surrogate models); Doostmohammadian et al. 2024 (arXiv survey, distributed MAS allocation); Yao 2023 (real vs simulated data validation); Ishimatsu et al. 2013 (LP optimality guarantee). See [[Summary of the Algorithmic Approach]].

**The two cultures.** OR starts from a stated model (variables, objective, constraints) and computes the **best** decision. ML starts from data and learns a **predictive** mapping. The corpus contains no essay contrasting them — but it contains something better: **four working integrations**, each showing what each side is good for.

## The contrast the corpus actually draws

| | OR (optimization) | ML (learning) |
|---|---|---|
| Output | A decision (optimal allocation) | A prediction or policy |
| Guarantee | Optimality, provable: "if solved, the solution is guaranteed to be optimal" (Ishimatsu et al. 2013, on LP) | Statistical performance on test distribution — no guarantee |
| Demands | Model must be written down (objective, constraints known) | Data must exist; model structure can be implicit |
| Failure mode | Intractable (NP-hard — see [[Algorithmic Bottlenecks and NP-Hard Problems]]) | Wrong on out-of-distribution inputs |
| Corpus instances | LP/MILP transfer and location models | Cut-stop policy; surrogate models; multi-agent allocation policies |

**The division of labour for the archipelagic model:** OR computes the allocation given the need index; ML **estimates the need index** from data and **tunes solver internals**. Neither replaces the other.

## Integration 1: ML inside the solver (HYGRO)

**Ling, Wang & Wang (AAAI-24)** — reinforcement learning decides when to stop cut generation in branch-and-cut:

> "Cutting planes (cuts) play an important role in solving mixed-integer linear programs (MILPs), as they significantly tighten the dual bounds and improve the solving performance. A key problem for cuts is when to stop cuts generation, which is important for the efficiency of solving MILPs. However, many modern MILP solvers employ hard-coded heuristics to tackle this problem, which tends to neglect underlying patterns among MILPs from certain applications."

> "Recently, using machine learning (ML) to improve the cutting plane method in modern MILP solvers has been an active topic of significant interest."

> "we formulate the cuts generation stopping problem as a reinforcement learning problem and propose a novel hybrid graph representation model (HYGRO) to learn effective stopping strategies."

Result: "achieving up to 31% improvement, on six challenging MILP problem benchmarks compared to eight competitive baselines" (incorporated into open-source SCIP).

**Lesson:** ML does not replace the exact solver — it **makes it faster**. The optimality guarantee is preserved by keeping the solver in charge; the ML only picks a stopping point. For a public transfer formula this is the acceptable kind of ML use: **the output is still computed by a verifiable algorithm.**

## Integration 2: ML as a surrogate for an intractable model

**Nevat & Mughal (2022)** need closed-form equations to make their spatial allocation framework tractable, so they replace the underlying physics with a learned model:

> "In order to be able to develop such a tractable mathematical framework for resource allocation, we need to be able to express the OTC equations in closed form. This can be obtained by using a machine learning technique known as surrogate models. Surrogate models refers to a model of a model; that is, instead of using the original model, we replace it by a simpler and mathematically tractable one."

**Lesson:** when the true model (climate-exposure response surface) cannot be written as constraints, learn a tractable surrogate and optimize over **that**. This is the credible route for the climate layer of the archipelagic model (Rijoly et al.'s connectivity/agglomeration channels — [[Federation Research/Tradeoff With The Federation Resources Planning]]), where the underlying relationships are empirical, not axiomatic.

## Integration 3: Learning + distributed optimization in multi-agent systems

**Doostmohammadian et al. (2024)** survey distributed resource allocation over multi-agent systems, where the optimization is convex and agents reach the optimum via consensus/dual methods:

> "For convex objective functions, it is proved that the optimal solution x* = [x*_1; ...; x*_n] to problem (2) satisfies ... with 1_n representing the vector of all 1s ... This directly follows from the well-known Karush-Kahn-Tucker (KKT) condition and the method of Lagrange multipliers."

**Lesson:** distributed optimization keeps exactness while removing the central node — cf. Trdlička & Hanzálek's distributed MCNF routing where "each node only needs to know the flow which it is supposed to send or receive". In federal terms: **provinces can compute their own optimal local plans given shadow prices (dual variables) broadcast by the centre** — the LP dual is the theoretical basis for decentralized-but-coordinated planning. (The related corpus RL papers — UAV allocation, weapon-target assignment, smart-grid MAS — are telecom/control applications with no LP formulation; they show learning-based allocation exists but are not used as methodological sources here.)

## Integration 4: Data validation discipline

**Yao (2023)** states the standard the field expects:

> "validated in optimization solvers with either real-world data or simulated data"

**Lesson:** OR and ML share the same empirical discipline — a model is only believed after it runs on real or honestly-synthesized instances ([[Synthetic Data Generation]]).

## The synthesis rule for this vault

```
   political design                data layer                solver layer
  (Federation Research)  →  (ML: need/cost estimation)  →  (OR: LP/MILP allocation)
                              surrogate models              PuLP/CBC, Gurobi
                              (Nevat & Mughal)             (Bearman et al.; van Willigen)
                                                                      ↑
                                              ML inside solver (Ling et al. HYGRO)
```

1. **Politics sets the objective and the hard constraints** — [[Federation Research/Translating Political Constraints to Algorithmic Rules]]
2. **ML estimates the inputs** (cost-of-provision index, climate exposure) via surrogate models
3. **OR computes the allocation** — guaranteeing feasibility and optimality *given the estimates*
4. **ML optionally tunes solver behaviour** (HYGRO) — transparent, performance-only role

**The honesty point:** because the final allocation is an LP output, it remains **replicable** — rerunning with the same inputs reproduces the result (unlike a stochastic GA policy, cf. [[Heuristics and Genetic Algorithms]]). That distinction carries the paper's transparency claim.

## Related notes
- [[Algorithmic Bottlenecks and NP-Hard Problems]] — what ML inside solvers is attacking
- [[Mixed-Integer Linear Programming]] — the solver pipeline ML is improving
- [[Synthetic Data Generation]] — shared empirical discipline
- [[Federation Research/Translating Political Constraints to Algorithmic Rules]] — the politics-to-model chain
