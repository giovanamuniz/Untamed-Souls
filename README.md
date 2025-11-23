# Untamed Souls

## Projeto Integrado - 6º Semestre de Ciência da Computação > Jogos e Experiência: Inovação, Narrativa e Tecnologia Interativa

## Sobre o Jogo
**Untamed Souls** é um jogo de aventura e ação em plataforma **2.5D** onde o jogador controla um pequeno macaco tentando escapar de caçadores ilegais na floresta brasileira.

Misturando leveza visual e emoção na jogabilidade, o jogo busca conscientizar sobre o tráfico de animais selvagens (ODS 15 da ONU), proporcionando uma experiência nostálgica inspirada em clássicos como 
Donkey Kong Country.

## Controles

| Tecla | Ação |
| :---: | :--- |
| **A / D** ou **Setas** | Mover para Esquerda / Direita |
| **Espaço** | Pular |
| **ESC** | Pausar / Voltar |

## Tecnologias e Implementações Acadêmicas

Este projeto foi desenvolvido para integrar conhecimentos de quatro disciplinas chaves:

### 1. Gamificação & Game Design
* **Narrativa:** Aplicação da *Jornada do Herói* (Fuga, Provação e Liberdade).
* **Core Loop:** Movimentação fluida, coleta de recursos (vidas) e desafios de plataforma.
* **Documentação:** Projeto estruturado com base em GDD (Game Design Document) completo.

### 2. Computação Gráfica
* **Estilo Visual:** Modelagem 3D Low Poly (Blender) integrada em ambiente 2.5D.
* **Integração:** Importação e manipulação de assets 3D, texturas e materiais na Godot Engine.

### 3. Compiladores & IDEs
* **DSL (Domain Specific Language):** Implementação de um interpretador de scripts customizado.
* **Análise Léxica e Sintática:** O sistema lê arquivos de texto externos para modificar parâmetros do jogo em tempo real (ex: gravidade, velocidade, debug), aplicando conceitos de tokenização e parsing.

### 4. Matemática Discreta
* **Lógica Booleana:** Utilizada no sistema de gatilhos, puzzles e condições de vitória/derrota.
* **Teoria dos Conjuntos:** Organização lógica de grupos de entidades (Coletáveis, Inimigos, Cenário) para otimização de colissões e interações.

## Estrutura do Projeto

Untamed-Souls/
├── Assets/          # Modelos 3D, Texturas e Sons
├── Scenes/          # Cenas (.tscn) de Fases e Menus
├── Scripts/         # Lógica do jogo (GDScript)
└── project.godot    # Configuração principal

## Equipe de Desenvolvimento

Giovana Muniz dos Santos - Programação e Integração

Betânia Amâncio Pereira - Programação (Fase 1 e Mecânicas)

Luis Fernando Menezes Ferreira Leite - Programação (Boss Fight)

Luis Gabriel Brito Felicio - Modelagem 3D 

Gabriel Meneghetti Zanardo - Modelagem 3D 

## Como Executar o Projeto

Certifique-se de ter o Godot Engine 4.4+ instalado.

Clone este repositório:

git clone https://github.com/giovanamuniz/Untamed-Souls.git

Abra o Godot, clique em Import e selecione o arquivo project.godot na pasta do projeto.

Pressione F5 para jogar!

## Licença
Este projeto foi desenvolvido para fins educacionais no curso de Ciência da Computação da UNIFEOB.
