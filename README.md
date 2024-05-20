# Be the Bot

> Visit my [Blog](http://pete.rai.org.uk) to get in touch 

## Overview

_Try out OpenAI's GPT assessment pack for yourself_

This simple project turns OpenAI's GPT assessment pack into an interactive quiz for humans.

The pack itself can be found here: https://github.com/openai/simple-evals

There are six evaluation methods used - but for now, I have only used the MMLU pack.

* __MMLU__: Measuring Massive Multitask Language Understanding
* __MATH__: Measuring Mathematical Problem Solving With the MATH Dataset
* __GPQA__: A Graduate-Level Google-Proof Q&A Benchmark
* __DROP__: A Reading Comprehension Benchmark Requiring Discrete Reasoning Over Paragraphs
* __MGSM__: Multilingual Grade School Math Benchmark (MGSM), Language Models are Multilingual Chain-of-Thought Reasoners
* __HumanEval__: Evaluating Large Language Models Trained on Code

## Installation

First download the MMLU CSV file:

```
cd raw
wget https://openaipublic.blob.core.windows.net/simple-evals/mmlu.csv
```

Then generate the SQL file:

```
cd db
python mmlu.py
```

This generates the file `db/sql/mmlu.sql`

Next create the database:

```
cd db
mysql -u root
source schema.sql
```

Finally, start a web-server in the root directory.

_– [Pete Rai](http://pete.rai.org.uk)_
