# Math Vision

O Math Vision é um app destinado ao auxilio do ensino de matemática para alunos do fundamental e ensino médio, fornecendo uma ferrementa divertida e dinâmica ao aprendizado. A proposta do aplicativo é fornecer resolução de contas e expressões matemáticas utilizando a câmera do SmartPhone, escaneando os digitos mostrados em papel ou lousa e apresentando o resultado em tempo real para os usuários.

## Escopo do MVP

A versão atual, que será apresentada como entrega da disciplina, se concentra nos seguintes pontos:

+ Acesso a câmera
+ Modelo de classificação de digitos (com apresentação do digito identificado em tela)

## Model e Base de dados

+Treinado a partir do MINST Dataset através da ferramenta Google Colaboratory: 

https://colab.research.google.com/github/tensorflow/examples/blob/master/lite/codelabs/digit_classifier/ml/step2_train_ml_model.ipynb


## Limitações 

+ Modelo treinado a partir de imagens em escala de cinza, apresentando inconsistências na detecção em papel ou lousa.

## Trabalhos Futuros

+ Aprimorar o modelo a partir do treinamento com fotos coloridas e algarismos escritos papel ou lousa.
+ Adicionar os simbolos das quatro operações básicas
+ Identificar expressões mais longas permitindo a realização das operações básicas.