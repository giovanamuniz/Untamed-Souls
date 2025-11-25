extends Node

# Este script atua como o Interpretador da nossa DSL (Domain Specific Language)

# Caminho padrão do arquivo de regras
const RULES_PATH = "res://rules.txt"

func _ready():
	# Assim que o jogo começa, tentamos ler e executar o script externo
	executar_dsl(RULES_PATH)

func executar_dsl(caminho_arquivo: String):
	if not FileAccess.file_exists(caminho_arquivo):
		print("DSL ERRO: Arquivo não encontrado: ", caminho_arquivo)
		return

	# 1. Abertura do Arquivo (Leitura do Código Fonte)
	var file = FileAccess.open(caminho_arquivo, FileAccess.READ)
	var conteudo = file.get_as_text()
	print("DSL: Lendo arquivo de regras...")
	
	# 2. ANÁLISE LÉXICA (Lexer / Tokenização)
	# Quebramos o texto inteiro em linhas separadas
	var linhas = conteudo.split("\n")
	
	for i in range(linhas.size()):
		var linha_atual = linhas[i].strip_edges() # Remove espaços extras
		
		# Ignora linhas vazias ou comentários (iniciados por #)
		if linha_atual == "" or linha_atual.begins_with("#"):
			continue
			
		# Tokenização: Quebra a linha em palavras (tokens) usando o espaço como separador
		# Exemplo: "SET_SPEED 20" vira ["SET_SPEED", "20"]
		var tokens = linha_atual.split(" ")
		
		# Envia para o analisador sintático processar
		processar_tokens(tokens, i + 1)

# 3. ANÁLISE SINTÁTICA (Parser) E SEMÂNTICA (Execução)
func processar_tokens(tokens: PackedStringArray, numero_linha: int):
	var comando = tokens[0] # O primeiro token é sempre o verbo/comando
	
	match comando:
		"PRINT":
			# Comando simples de saída de texto
			# Reconstrói a frase removendo o comando PRINT
			var mensagem = " ".join(tokens.slice(1)).replace('"', '')
			print("DSL LOG [Linha %d]: %s" % [numero_linha, mensagem])
			
		"SET_SPEED":
			# Sintaxe esperada: SET_SPEED <valor_float>
			if tokens.size() < 2:
				print("DSL ERRO SINTÁTICO [Linha %d]: SET_SPEED espera um argumento." % numero_linha)
				return
				
			var valor = float(tokens[1])
			aplicar_velocidade(valor)
			
		"SET_GRAVITY":
			# Sintaxe esperada: SET_GRAVITY <valor_float>
			if tokens.size() < 2:
				print("DSL ERRO SINTÁTICO [Linha %d]: SET_GRAVITY espera um argumento." % numero_linha)
				return
				
			var valor = float(tokens[1])
			aplicar_gravidade(valor)
			
		_:
			# Caso o comando não seja reconhecido
			print("DSL ERRO: Comando desconhecido na linha %d: %s" % [numero_linha, comando])

# --- Funções Auxiliares que alteram o Jogo ---

func aplicar_velocidade(nova_speed: float):
	# Busca o Player na cena atual usando Grupos
	var player = get_tree().get_first_node_in_group("Player")
	if player:
		# Verifica se a variável existe antes de tentar mudar
		if "speed" in player:
			player.speed = nova_speed
			print("DSL: Velocidade do Player alterada para ", nova_speed)
	else:
		print("DSL AVISO: Player não encontrado na cena atual para aplicar velocidade.")

func aplicar_gravidade(nova_gravity: float):
	var player = get_tree().get_first_node_in_group("Player")
	if player:
		if "gravity" in player:
			player.gravity = nova_gravity
			print("DSL: Gravidade do Player alterada para ", nova_gravity)
	else:
		print("DSL AVISO: Player não encontrado na cena atual para aplicar gravidade.")
