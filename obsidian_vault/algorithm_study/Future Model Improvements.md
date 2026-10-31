# Future Model Improvements

> Known evidence gaps and next collection targets for the Model Research half. Written from the algorithm corpus profile's 16-topic coverage assessment (42 files). Counterpart: [[Federation Research/Future Improvement]].

## Gap 1: Three corpus-ABSENT topics (integration layer)

| Topic | Status | Action |
|---|---|---|
| **Graph Modeling with NetworkX** | ABSENT as library; graph *math* is strong (CME 305, Goldberg–Tardos–Tarjan, Ishimatsu) | Verify NetworkX API externally; decide whether sea-lane shortest paths replace Euclidean ×1.2 distances |
| **Go Integration Strategy** | ABSENT | Decide in-paper scope. Honest option: declare Python-only, move Go to future work |
| **Svelte Visualization Data Contract** | ABSENT | Contract schema is corpus-anchored and defensible; Svelte itself is external and out of scope unless an application becomes a deliverable |

**Principle applied in this vault:** none of the three is load-bearing in the paper's argument. The model, the formula, and the solver stack are all corpus-anchored; deployment technology is not.

## Gap 2: LSP is undefined here

The only "LSP" in the corpus is a **Lunar South Pole node label** (Ishimatsu et al. 2013). The note ([[What is LP, Why is That Matter]]) disambiguates toward **LSCP (Location Set Covering Problem)** on one-letter proximity and topical fit, with "Large-Scale (Linear) Programming" as second reading. **External verification required** before the paper commits to either.

## Gap 3: No fiscal-federalism application of OR in the corpus

No corpus paper models equalization grants, shared taxes, or transfer formulas as such. The bridge in [[Modeling Federal Constraints & Penalties]] stands on four analogues:

- Israel & Lund (1999) — water-rights priorities as LP penalties (**strongest**)
- Khasnabis & Mathew (2006) — transit fleet with federal 20% match
- Trivella et al. (2021) — soft transit-time penalties
- Yao (2023) — hard/soft constraint translation rule

**Collect:** OR applications to intergovernmental fiscal design — budget-allocation MILPs in multi-tier governments, optimization of grant formulas, spatial optimization of public spending. If none exist, the paper's bridge is itself a contribution (stated as such, not hidden).

## Gap 4: No measured cost-of-provision index

The synthesis formula's core innovation — a need index carrying dispersion, connectivity, climate exposure — has **no measured implementation** anywhere in the corpus. Van Willigen (2023) provides the *construction method* (documented constants, detour factors) but for freight, not public service cost.

**Collect:**
- Real cost-of-service studies for archipelagic/small-island service delivery (health, education logistics)
- Connection to the Federation Research side's Gap 4 (Australia CGC methodology) — the two vaults share this gap

## Gap 5: Empirical validation infrastructure

The model currently runs only on synthetic instances ([[Synthetic Data Generation]]). What would make it empirical:

- **Indonesian DAU/HKPD data** — the 8 archipelagic provinces' actual own-source revenue, expenditure need, transfers (source: Anisyah et al. 2026's dataset or Indonesian Ministry of Finance publications). Would let the formula be back-tested: does the computed `T_i` track the actual DAU allocation, and where does it differ and why?
- **Coverage data** — which islands have which facilities (ports, clinics, schools)
- **Transport cost observations** — actual inter-island freight rates to validate the 1.2 detour factor and €/km constants

## Gap 6: Multi-objective method choice is open

The corpus offers three incompatible routes for the α-weight problem:
1. **Weighted-sum LP** — simple, deterministic, one α at a time (AIMMS; the synthesis formula)
2. **Pareto frontier enumeration** — Luna Rojas & Flores de la Mota (2022), political choice from the frontier
3. **AHP/entropy-weighted GA** — Yan et al. (2026), weights computed rather than chosen

The paper must pick and defend one — currently the weighted-sum LP on determinism/replicability grounds — **or show the sweep across α as the deliverable**. The α-sweep maps to Simandjuntak's water-weight simulations (Federation Research: raising the water weight redistributes between archipelagic and terrestrial provinces — the same zero-sum structure, measured).

## Gap 7: Solver-scale evidence for the full model

Corpus evidence is small-scale (Bearman et al.: 19 students × 38 schools in 0.2 s; van Willigen: Dutch city instances). The combined transfer + facility model at national archipelagic scale (hundreds of islands, multi-year horizon, multi-commodity services) is unsized.

**Action:** build the instance size sweep with Ling et al.'s benchmark discipline; report CBC vs Gurobi scaling; mark the NP-hard regime boundary — cf. Karsten et al.'s observation that one extra constraint class flipped polynomial to NP-hard.

## Gap 8: Citation verification (carried from corpus profile)

Marked "identification uncertain" in the inventory — venues/authors not resolvable from the extracted text:
- `3.4buildingsimplex.txt` (slides), `3.txt` (CME 305 lecture), `attendance5-1.txt` (lecture notes), `c1de066...txt` (MIT 15.053 tutorial) — cite as course materials
- `Analysis-of-Optimizing-Regional-Economic...txt` (Chu — venue not stated)
- `E00-2096080927.txt` (Juedes et al. — report number only)
- `Hanzalek10_172685.txt` (Trdlička & Hanzálek — reprint reference, venue not in extraction)

Verify before these carry weight in the final paper.

## Done in this vault

All 16 stub notes filled (17 with the added [[Network Flow Algorithms]] — the strongest corpus topic had no stub). Corpus profile: `.ars-pipeline` profile + `/tmp/algotxt/` extraction cache.

## Priority order

1. Indonesian DAU/HKPD data for back-testing (closes Gap 5 — largest credibility gain)
2. Decide α-weight method (Gap 6)
3. Verify LSP (Gap 2) and uncertain citations (Gap 8)
4. Size the full model (Gap 7)
5. External verification for NetworkX/Go/Svelte only if the paper includes an application (Gap 1)

## Related notes
- [[Summary of the Algorithmic Approach]] — what is complete
- [[Federation Research/Future Improvement]] — the policy-side gaps
- [[Synthetic Data Generation]] — the current validation route
