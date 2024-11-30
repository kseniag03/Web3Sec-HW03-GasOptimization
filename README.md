# Web3Sec-HW03-GasOptimization

## Tools
- Foundry
- [Gas optimization quizz](https://github.com/mysteryon88/gas-optimization-quizz.git)

## Install
```bash
forge install
forge build
```

## Testing
```bash
forge test --gas-report
forge test --match-contract {contract} --gas-report -vvv
```

## Testing results
<details>
<summary>Task №1. ArithmeticOperators </summary>
Addition & Subtraction

| Ordinary          |                 |      |        |      |         |
|----------------------------------------------------|-----------------|------|--------|------|---------|
| Deployment Cost                                   | Deployment Size |       |        |       |         |
| 118979                                            | 235             |       |        |       |         |
| Function Name                                     | min             | avg   | median | max   | # calls |
| addition                                          | 26505           | 26505 | 26505  | 26505 | 1       |

| Optimized |                 |      |        |      |         |
|-------------------------------------------------------------|-----------------|------|--------|------|---------|
| Deployment Cost                                            | Deployment Size |       |        |       |         |
| 107543                                                     | 182             |       |        |       |         |
| Function Name                                              | min             | avg   | median | max   | # calls |
| addition                                                   | 26412           | 26412 | 26412  | 26412 | 1       |

Division

| Ordinary          |                 |      |        |      |         |
|----------------------------------------------------|-----------------|------|--------|------|---------|
| Deployment Cost                                   | Deployment Size |     |        |     |         |
| 105659                                            | 272             |     |        |     |         |
| Function Name                                     | min             | avg | median | max | # calls |
| divisionBy128                                     | 317             | 317 | 317    | 317 | 1       |
| divisionBy2                                       | 339             | 339 | 339    | 339 | 1       |

| Optimized |                 |      |        |      |         |
|-------------------------------------------------------------|-----------------|------|--------|------|---------|
| Deployment Cost                                            | Deployment Size |     |        |     |         |
| 93391                                                      | 214             |     |        |     |         |
| Function Name                                              | min             | avg | median | max | # calls |
| divisionBy128                                              | 241             | 241 | 241    | 241 | 1       |
| divisionBy2                                                | 263             | 263 | 263    | 263 | 1       |


</details>

<details>
<summary>Task №2. ArrayLength </summary>

| Ordinary          |                 |      |        |      |         |
|----------------------------------------------------|-----------------|------|--------|------|---------|
| Deployment Cost                              | Deployment Size |      |        |      |         |
| 362090                                       | 487             |      |        |      |         |
| Function Name                                | min             | avg  | median | max  | # calls |
| callFor                                      | 3694            | 3694 | 3694   | 3694 | 1       |

| Optimized |                 |      |        |      |         |
|-------------------------------------------------------------|-----------------|------|--------|------|---------|
| Deployment Cost                                       | Deployment Size |     |        |     |         |
| 343552                                                | 400             |     |        |     |         |
| Function Name                                         | min             | avg | median | max | # calls |
| callFor                                               | 98              | 98  | 98     | 98  | 1       |

</details>

<details>
<summary>Task №3. CalldataMemory </summary>

| Ordinary          |                 |      |        |      |         |
|----------------------------------------------------|-----------------|------|--------|------|---------|
| Deployment Cost                                    | Deployment Size |      |        |      |         |
| 160323                                             | 527             |      |        |      |         |
| Function Name                                      | min             | avg  | median | max  | # calls |
| add                                                | 3186            | 3186 | 3186   | 3186 | 1       |

| Optimized |                 |      |        |      |         |
|-------------------------------------------------------------|-----------------|------|--------|------|---------|
| Deployment Cost                                             | Deployment Size |      |        |      |         |
| 127293                                                      | 374             |      |        |      |         |
| Function Name                                               | min             | avg  | median | max  | # calls |
| add                                                         | 1662            | 1662 | 1662   | 1662 | 1       |

</details>

<details>
<summary>Task №4. Loops </summary>

| Ordinary          |                 |      |        |      |         |
|----------------------------------------------------|-----------------|------|--------|------|---------|
| Deployment Cost                  | Deployment Size |      |        |      |         |
| 127197                           | 374             |      |        |      |         |
| Function Name                    | min             | avg  | median | max  | # calls |
| loopDoWhile                      | 1946            | 1946 | 1946   | 1946 | 1       |
| loopFor                          | 2641            | 2641 | 2641   | 2641 | 1       |
| loopWhile                        | 2069            | 2069 | 2069   | 2069 | 1       |

| Optimized |                 |      |        |      |         |
|-------------------------------------------------------------|-----------------|------|--------|------|---------|
| Deployment Cost                           | Deployment Size |      |        |      |         |
| 98989                                     | 240             |      |        |      |         |
| Function Name                             | min             | avg  | median | max  | # calls |
| loopDoWhile                               | 586             | 586  | 586    | 586  | 1       |
| loopFor                                   | 1281            | 1281 | 1281   | 1281 | 1       |
| loopWhile                                 | 709             | 709  | 709    | 709  | 1       |

</details>

<details>
<summary>Task №5. PackVariables </summary>

| Ordinary          |                 |      |        |      |         |
|----------------------------------------------------|-----------------|------|--------|------|---------|
| Deployment Cost                                  | Deployment Size |        |        |        |         |
| 178533                                           | 611             |        |        |        |         |
| Function Name                                    | min             | avg    | median | max    | # calls |
| setValues                                        | 150861          | 150861 | 150861 | 150861 | 1       |

| Optimized |                 |      |        |      |         |
|-------------------------------------------------------------|-----------------|------|--------|------|---------|
| Deployment Cost                                           | Deployment Size |        |        |        |         |
| 181485                                                    | 625             |        |        |        |         |
| Function Name                                             | min             | avg    | median | max    | # calls |
| setValues                                                 | 128987          | 128987 | 128987 | 128987 | 1       |

</details>

<details>
<summary>Task №6. Errors </summary>

| Ordinary          |                 |      |        |      |         |
|----------------------------------------------------|-----------------|------|--------|------|---------|
| Deployment Cost                    | Deployment Size |      |        |      |         |
| 119420                             | 249             |      |        |      |         |
| Function Name                      | min             | avg  | median | max  | # calls |
| call                               | 2357            | 2357 | 2357   | 2357 | 1       |

| Optimized |                 |      |        |      |         |
|-------------------------------------------------------------|-----------------|------|--------|------|---------|
| Deployment Cost                             | Deployment Size |      |        |      |         |
| 108452                                      | 198             |      |        |      |         |
| Function Name                               | min             | avg  | median | max  | # calls |
| call                                        | 2303            | 2303 | 2303   | 2303 | 1       |

</details>

<details>
<summary>Task №7. Swap </summary>

| Ordinary          |                 |      |        |      |         |
|----------------------------------------------------|-----------------|------|--------|------|---------|
| Deployment Cost                | Deployment Size |     |        |     |         |
| 111969                         | 302             |     |        |     |         |
| Function Name                  | min             | avg | median | max | # calls |
| swap                           | 547             | 547 | 547    | 547 | 1       |

| Optimized |                 |      |        |      |         |
|-------------------------------------------------------------|-----------------|------|--------|------|---------|
| Deployment Cost                         | Deployment Size |     |        |     |         |
| 90367                                   | 200             |     |        |     |         |
| Function Name                           | min             | avg | median | max | # calls |
| swap                                    | 282             | 282 | 282    | 282 | 1       |

</details>

<details>
<summary>Task №8. ArrayType </summary>

| Ordinary          |                 |      |        |      |         |
|----------------------------------------------------|-----------------|------|--------|------|---------|
| Deployment Cost                          | Deployment Size |         |         |         |         |
| 91651                                    | 206             |         |         |         |         |
| Function Name                            | min             | avg     | median  | max     | # calls |
| initArray                                | 4499618         | 4499618 | 4499618 | 4499618 | 1       |


| Optimized |                 |      |        |      |         |
|-------------------------------------------------------------|-----------------|------|--------|------|---------|
| Deployment Cost                                   | Deployment Size |     |        |     |         |
| 4491967                                           | 194             |     |        |     |         |
| Function Name                                     | min             | avg | median | max | # calls |
| initArray                                         | 98              | 98  | 98     | 98  | 1       |

</details>

<details>
<summary>Task №9. NestedIf </summary>

| Ordinary          |                 |      |        |      |         |
|----------------------------------------------------|-----------------|------|--------|------|---------|
| Deployment Cost                        | Deployment Size |     |        |     |         |
| 97909                                  | 235             |     |        |     |         |
| Function Name                          | min             | avg | median | max | # calls |
| call                                   | 346             | 353 | 356    | 357 | 4       |


| Optimized |                 |      |        |      |         |
|-------------------------------------------------------------|-----------------|------|--------|------|---------|
| Deployment Cost                                 | Deployment Size |     |        |     |         |
| 94243                                           | 218             |     |        |     |         |
| Function Name                                   | min             | avg | median | max | # calls |
| call                                            | 303             | 324 | 330    | 333 | 4       |

</details>

<details>
<summary>Task №10. MultiSigWallet </summary>

| Ordinary          |                 |      |        |      |         |
|----------------------------------------------------|-----------------|------|--------|------|---------|
| Deployment Cost                                    | Deployment Size |       |        |        |         |
| 886258                                             | 4222            |       |        |        |         |
| Function Name                                      | min             | avg   | median | max    | # calls |
| confirmTransaction                                 | 31243           | 86628 | 77008  | 124410 | 8       |
| executeTransaction                                 | 31287           | 31287 | 31287  | 31287  | 1       |
| getConfirmations                                   | 12041           | 12041 | 12041  | 12041  | 1       |
| getTransactionCount                                | 326             | 326   | 326    | 326    | 1       |
| owners                                             | 2604            | 3270  | 2604   | 4604   | 3       |
| receive                                            | 0               | 0     | 0      | 0      | 8       |
| required                                           | 2361            | 2361  | 2361   | 2361   | 1       |
| submitTransaction                                  | 31476           | 92750 | 102951 | 103023 | 7       |
| transactions                                       | 1299            | 1299  | 1299   | 1299   | 4       |


| Optimized |                 |      |        |      |         |
|-------------------------------------------------------------|-----------------|------|--------|------|---------|
| Deployment Cost                                             | Deployment Size |       |        |       |         |
| 879012                                                      | 3891            |       |        |       |         |
| Function Name                                               | min             | avg   | median | max   | # calls |
| confirmTransaction                                          | 23711           | 77056 | 75041  | 97812 | 8       |
| executeTransaction                                          | 23755           | 23755 | 23755  | 23755 | 1       |
| getConfirmations                                            | 3868            | 3868  | 3868   | 3868  | 1       |
| getTransactionCount                                         | 381             | 381   | 381    | 381   | 1       |
| owners                                                      | 2447            | 2447  | 2447   | 2447  | 3       |
| receive                                                     | 0               | 0     | 0      | 0     | 8       |
| required                                                    | 2383            | 2383  | 2383   | 2383  | 1       |
| submitTransaction                                           | 23944           | 84067 | 94076  | 94148 | 7       |
| transactions                                                | 1040            | 1040  | 1040   | 1040  | 4       |

</details>
