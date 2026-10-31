# Synthetic Data Generation

> Source basis: van Willigen 2023 (Wageningen MSc, location-allocation); Bearman et al. 2023 (anonymised sample); Gonçalves, Mendes & Resende (randomly generated RCMPSP instances); Yao 2023 (real-or-simulated validation standard); Ling et al. 2024 (six MILP benchmarks); Juedes et al. (simulation evaluation). See [[Summary of the Algorithmic Approach]].

Before a model can be trusted it must run on something. For the archipelagic model there is no ready dataset, so **instance generation is part of the methodology** : and this corpus contains a fully documented method for doing it honestly.

## The corpus's master example: van Willigen (2023)

Building instances for a multi-commodity capacitated location-allocation model with no prior dataset, van Willigen documents every construction choice:

**Data created because the model is new:**

> "This model with the inclusion of production lines is not earlier used in research. Therefore, new data sets are specifically made for the tests. The data is based on geographical information focused on the Netherlands. The data sets are created and fine tuned by trial and error with short test runs with the Gurobi solver. Aiming to achieve 70% production costs and 30% transport costs."

Note both the *geographic grounding* (e.g. real Netherlands coordinates) and the *calibration loop* (solver test runs feeding back into instance design, targeting a realistic 70/30 cost split).

**Demand seeded on real geography : with a distributional mechanism:**

> "Assumed is that facilities can be opened in large Dutch cities, e.g. if the dataset contains I = 20 the geographical coordinates (latitude and longitude) of the 20 largest cities in the Netherlands are retrieved from the Central Bureau of Statistics and used (CBS, 2022). To create the coordinates for clients... a list is created for every municipality in the Netherlands with the number of Albert Heijn's (AH, 2023), a major supermarket chain, the more Albert Heijn's the higher the chance of that municipality being picked, thereby preserving a distribution."

**The honest trick:** supermarket counts are used as a **proxy for population density**, clients are sampled where people actually live, so instances carry realistic spatial structure without personal data. For the archipelagic model the analogue is direct: sample island demand proportional to a real proxy (village counts, port calls, census households).

**Cost synthesis with a calibration factor:**

> "To create the C_ij and CC_qr parameters the Euclidean distance is calculated and multiplied by a factor of 1,2 to compensate for the fact that streets are not straight lines between locations... The cost per kilometer is €0,35 and a truck has to return so the distance is doubled. Additionally, a fixed cost of €50 is added to drive the truck."

Every constant is documented and defensible: detour factor 1.2, €/km, doubling for return legs, fixed cost per trip. **This is the standard the archipelagic instance generation must meet** — each parameter justified, none hidden.

## Generation as a first-class research object

Other corpus sources show the discipline is normal practice:

**Gonçalves, Mendes & Resende** : benchmark generation as part of algorithm publication: "a set of randomly generated problems".

**Yao (2023)** : the community's validation standard: "validated in optimization solvers with either real-world data or simulated data".

**Ling, Wang & Wang (AAAI-24)** : ML-for-solvers work rests on **six MILP problem benchmarks**, i.e. standardized instance suites that make results comparable across papers.

**Juedes et al.** : heuristic algorithms "evaluated via simulation" generated scenarios as the testbench.

## The archipelagic analogue : generation plan

Combining van Willigen's method with the federal formula's needs (`need`, `capacity`, `effort`, dispersion, connectivity):

| Input                            | Proxy / synthesis method                                                                             | Corpus anchor                                      |
| -------------------------------- | ---------------------------------------------------------------------------------------------------- | -------------------------------------------------- |
| Island coordinates               | real coordinates of inhabited islands (statistical agency)                                           | van Willigen: CBS city coordinates                 |
| Population/demand on each island | sampling weighted by a real density proxy (port calls, village count)                                | van Willigen: Albert Heijn-weighted sampling       |
| Transport cost `c_ij`            | Euclidean × detour factor (≈1.2 for sea routes), × €/km, ×2 for return, + fixed port cost            | van Willigen cost synthesis                        |
| Own-revenue capacity             | correlated with population + noise (agglomeratio, tax base Anisyah et al.'s mechanism)               | Federation Research: Anisyah et al. 2026           |
| `Need` index                     | population + dispersion index + connectivity cost (validated ranges from Rijoly et al.'s parameters) | Federation Research: Rijoly et al. 2026            |
| Instance size sweep              | small (5–10 islands, LP-feasible), large (50+ islands, NP-hard regime)                               | Ling et al. benchmarks; van Willigen's size series |
| Calibration loop                 | short solver runs; target realistic cost shares (van Willigen's 70/30)                               | van Willigen                                       |

**Why this matters for the paper's credibility:** the model is a policy proposal. A synthetic but **documented and calibrated** instance set lets reviewers rerun everything, the same replicability standard Haque et al. Box 11 demands of real formulas ("any official or private citizen must be able to easily duplicate calculations"). Synthetic data is not a weakness in this design; **documented synthetic data with real geographic grounding is the honest substitute for unavailable national fiscal microdata.**
## Confidentiality pattern

**Bearman et al. (2023)** : the companion approach, real data confidential (student locations), so an **anonymised and randomised sample** is released:

> "A sample data set will be provided with anonymised and randomised data which can be used to demonstrate the usefulness of the app and library developments."

Together: van Willigen shows how to *build* synthetic instances; Bearman et al. show how to *release* alongside confidential real data.

## Honest limits

- Synthetic results **do not estimate real-world magnitudes** : they test internal consistency, scalability, and mechanism behaviour, not policy outcomes. The paper must state this (see [[Federation Research/Future Improvement]] Gap 4: cost-of-provision measurement remains an empirical gap).
- Calibration against real aggregate statistics (total budget, population totals, known disparities e.g. Anisyah et al.'s coefficient-of-variation figures) is the mitigating discipline.

## Related notes
- [[Spatial and Location-Allocation Models]] — the models the instances feed
- [[Resource Allocation with PuLP]] — the solver pipeline
- [[Vector Math with NumPy]] — the numerical layer for generation
- [[Federation Research/Future Improvement]] — where the empirical gap is registered
