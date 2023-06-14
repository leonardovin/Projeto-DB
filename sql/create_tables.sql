\c projeto_db

-- Inserções na tabela "Usuario"
INSERT INTO Usuario (CPF, nome, email, senha, tipo, data_nasc, endereco, telefone, idioma1, idioma2, url_foto_perfil, cartao_cred_nro, cartao_cred_validade, cartao_cred_cvv, cartao_cred_cpf, cartao_cred_titular, status, data_ultimo_acesso, data_ultima_edicao)
VALUES
('12345678901', 'João Silva', 'joao.silva@example.com', 'senha123', 'Aluno', '1990-01-01', 'Rua das Flores, 123', '987654321', 'Português', 'Inglês', 'https://example.com/foto.jpg', '1234567890123456', '12/25', '123', '12345678901', 'João Silva', 'Ativo', '2022-06-01 10:00:00', '2022-06-10 15:30:00'),
('23456789012', 'Maria Santos', 'maria.santos@example.com', 'senha456', 'Tutor', '1985-05-15', 'Avenida dos Anjos, 456', '987654321', 'Português', NULL, 'https://example.com/foto.jpg', NULL, NULL, NULL, NULL, NULL, 'Ativo', '2022-06-02 09:00:00', '2022-06-11 14:45:00');

-- Inserções na tabela "Aluno"
INSERT INTO Aluno (usuario, assinante)
VALUES
('12345678901', true),
('23456789012', true);

-- Inserções na tabela "Interesse"
INSERT INTO Interesse (aluno, interesse)
VALUES
('12345678901', 'Matemática'),
('23456789012', 'Inglês');

-- Inserção na tabela "Administrador"
INSERT INTO Administrador (usuario, nivel_acesso)
VALUES
('34567890123', 1);

-- Inserção na tabela "AdministradorAtividade"
INSERT INTO AdministradorAtividade (administrador, log, data_hora)
VALUES
('34567890123', 'Atividade realizada', '2022-06-03 08:00:00');

-- Inserção na tabela "Tutor"
INSERT INTO Tutor (usuario, tipo, cadastrado_por)
VALUES
('23456789012', 'Tutor', '34567890123');

-- Inserção na tabela "TutorHabilidade"
INSERT INTO TutorHabilidade (tutor, habilidade)
VALUES
('23456789012', 'Matemática');

-- Inserção na tabela "TutorAvaliacao"
INSERT INTO TutorAvaliacao (tutor, aluno, avaliacao, data_hora)
VALUES
('23456789012', '12345678901', 4, '2022-06-04 07:00:00');

-- Inserção na tabela "Voluntario"
INSERT INTO Voluntario (tutor, motivacao)
VALUES
('23456789012', 'Gosto de ajudar os outros');

-- Inserção na tabela "Especialista"
INSERT INTO Especialista (tutor, taxa, curriculo_academico, conta_nro_banco, conta_agencia, conta_nro)
VALUES
('23456789012', 50.00, 'Mestrado em Física', '12345678', '001', '987654321');

-- Inserções na tabela "AtividadePraticaResposta"
INSERT INTO AtividadePraticaResposta (aluno, questao, alternativa)
VALUES
('12345678901', 1, 'A'),
('12345678901', 2, 'B');

-- Inserções na tabela "Mensagem"
INSERT INTO Mensagem (aluno1, aluno2, data_hora, conteudo)
VALUES
('12345678901', '23456789012', '2022-06-05 06:00:00', 'Olá, tudo bem?'),
('23456789012', '12345678901', '2022-06-05 06:01:00', 'Olá! Estou bem, obrigado!');

-- Inserções na tabela "Videotutorial"
INSERT INTO Videotutorial (recurso_curso, recurso_nome, duracao)
VALUES
('ABC123', 'Introdução à Matemática', '00:30:00'),
('DEF456', 'Conversação em Inglês', '00:20:00');

-- Inserções na tabela "Guia"
INSERT INTO Guia (recurso_curso, recurso_nome, formato)
VALUES
('ABC123', 'Guia de Estudos de Matemática', 'PDF'),
('DEF456', 'Guia de Vocabulário em Inglês', 'PDF');

-- Inserções na tabela "Questao"
INSERT INTO Questao (atividade_pratica_curso, atividade_pratica_nome, nro, pergunta, alt1, alt2, alt3, alt4, alt_correta)
VALUES
('XYZ789', 'Atividade Prática de Física', 1, 'Qual é a fórmula da velocidade média?', 'a) v = d/t', 'b) v = t/d', NULL, NULL, 'a'),
('XYZ789', 'Atividade Prática de Física', 2, 'Qual é a unidade de medida da força?', 'a) Watt', 'b) Ampère', 'c) Newton', 'd) Joule', 'c');

-- Inserções na tabela "AtividadePratica"
INSERT INTO AtividadePratica (recurso_pago_curso, recurso_pago_nome, duracao, assunto)
VALUES
('XYZ789', 'Atividade Prática de Física', '01:00:00', 'Cinemática'),
('LMN012', 'Atividade Prática de Programação', '02:00:00', 'Introdução ao Python');

-- Inserções na tabela "Agendamento"
INSERT INTO Agendamento (aluno, especialista, data_hora, tutoria_personalizada_curso, tutoria_personalizada_nome)
VALUES
('12345678901', '23456789012', '2022-06-06 05:00:00', 'TUV345', 'Tutoria Personalizada de Matemática'),
('12345678901', '23456789012', '2022-06-07 10:00:00', 'TUV345', 'Tutoria Personalizada de Matemática');

-- Inserções na tabela "TutoriaPersonalizada"
INSERT INTO TutoriaPersonalizada (recurso_pago_curso, recurso_pago_nome, assunto)
VALUES
('TUV345', 'Tutoria Personalizada de Matemática', 'Álgebra Linear'),
('TUV345', 'Tutoria Personalizada de Matemática', 'Cálculo Diferencial');

-- Inserções na tabela "AlunoAcessoRecursoPago"
INSERT INTO AlunoAcessoRecursoPago (aluno, recurso_pago_curso, recurso_pago_nome)
VALUES
('12345678901', 'XYZ789', 'Atividade Prática de Física'),
('12345678901', 'LMN012', 'Atividade Prática de Programação');

-- Inserções na tabela "RecursoPago"
INSERT INTO RecursoPago (recurso_curso, recurso_nome, preco_unico, tipo)
VALUES
('XYZ789', 'Atividade Prática de Física', 29.99, 'Atividade Prática'),
('LMN012', 'Atividade Prática de Programação', 39.99, 'Atividade Prática');

-- Inserções na tabela "AdministraRecurso"
INSERT INTO AdministraRecurso (recurso_curso, recurso_nome, especialista)
VALUES
('XYZ789', 'Atividade Prática de Física', '23456789012'),
('LMN012', 'Atividade Prática de Programação', '23456789012');

-- Inserções na tabela "Recurso"
INSERT INTO Recurso (curso, nome, descricao, tipo)
VALUES
('ABC123', 'Matemática Básica', 'Curso introdutório de matemática', 'Curso'),
('DEF456', 'Inglês Intermediário', 'Curso de conversação em inglês', 'Curso');

-- Inserções na tabela "AlunoCursa"
INSERT INTO AlunoCursa (aluno, curso, avaliacao, nota, data_hora)
VALUES
('12345678901', 'ABC123', 4, 80, '2022-06-08 04:00:00'),
('12345678901', 'DEF456', 5, 95, '2022-06-09 11:00:00');

-- Inserções na tabela "Tutoria"
INSERT INTO Tutoria (curso, voluntario)
VALUES
('ABC123', '23456789012'),
('DEF456', '23456789012');

-- Inserção na tabela "Curso"
INSERT INTO Curso (codigo, titulo, categoria, descricao, nivel_dificuldade, media_aval, criado_por)
VALUES
('ABC123', 'Matemática Básica', 'Matemática', 'Curso introdutório de matemática', 1, 4.5, '34567890123'),
('DEF456', 'Inglês Intermediário', 'Idiomas', 'Curso de conversação em inglês', 2, 4.8, '34567890123');
