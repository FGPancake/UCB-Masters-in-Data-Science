# MIDS 266 Final Project
NLP final project for DATASCI 266

## Project Overview
This project explores the NLP task of next-line generation for hip-hop lyrics, which is characterized by challenges related to rhyme, rhythm, slang, and creative phrasing. Models including GPT-2, Llama-3.2, and FLAN-T5 were evaluated with baselines, training, and fine-tuning to improve performance on a set of metrics including: BLEU, ROUGE, BERTScore, SBERT similarity, rhyme rate, syllable similarity, and word diversity. For the fine-tuned versions of the models, FLAN-T5 performed best and was used for further experiments.

Experiments on the FLAN-T5 model included prompt-engineering, additional layers for syllable and rhyme, while experiments into additional input lines, and backwards generation led to significant improvements over the fine-tuned model. These results demonstrate that encoder-decoder models with bidirectional attention and targeted input strategies are more effective for creative generation in a constrained domain such as hip-hop lyrics.