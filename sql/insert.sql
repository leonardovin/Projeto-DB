/*
 Usuário = { CPF, nome*, email*, senha*, tipo*, data_nasc*, endereço*, telefone*, idioma1*, idioma2, url_foto_perfil,
 cartão_cred_nro, cartão_cred_validade, cartão_cred_cvv, cartão_cred_cpf, cartão_cred_titular,
 status*, data_último_acesso, data_última_edição }
 */
INSERT INTO
  usuario
VALUES
  (
    '123.456.789-01',
    'João da Silva',
    'example@gmail.com',
    '123456',
    'aluno',
    '1990-01-01',
    'Rua dos Bobos, 0',
    '(12) 1345-6789',
    'Português',
    'Inglês',
    'http://example.com',
    '1234567890123456',
    '01/2022',
    '123',
    '123.456.789-01',
    'João da Silva',
    'ativo',
    '2018-01-01',
    '2018-01-01'
  ),
  (
    '123.456.789-02',
    'Maria da Silva',
    'admin@gmail.com',
    '123456',
    'administrador',
    '1990-01-01',
    'Rua dos Bobos, 0',
    '(12) 91345-6789',
    'Português',
    'Inglês',
    'exemple.com',
    '1234567890123456',
    '01/2022',
    '123',
    '123.456.789-02',
    'Maria da Silva',
    'ativo',
    '2018-01-01',
    '2018-01-01'
  ),
  (
    '123.456.789-03',
    'José da Silva',
    'exemplao@gmail.com',
    '123456',
    'tutor',
    '1990-01-01',
    'Rua dos Bobos, 0',
    '(12) 91345-8789',
    'Português',
    'Inglês',
    'exemple.com',
    '1234567890123456',
    '01/2022',
    '123',
    '123.456.789-03',
    'José da Silva',
    'ativo',
    '2018-01-01',
    '2018-01-01'
  ),
  (
    '123.456.789-04',
    'José da Silva',
    'exassaasa@gmail.com',
    '123456',
    'tutor',
    '1990-01-01',
    'Rua dos Bobos, 0',
    '(12) 91345-8789',
    'Português',
    'Inglês',
    'exemple.com',
    '1234567890123456',
    '01/2022',
    '123',
    '123.456.789-04',
    'Jotaro da Silva',
    'ativo',
    '2018-01-01',
    '2018-01-01'
  ),
  (
    '123.456.789-05',
    'Jolyne da Silva',
    'asdfasdf@gmail.com',
    '123456',
    'aluno',
    '1990-01-01',
    'Rua dos Bobos, 0',
    '(12) 91345-8789',
    'Português',
    'Inglês',
    'exemple.com',
    '1234567890123456',
    '01/2022',
    '123',
    '123.456.789-05',
    'José da Silva',
    'ativo',
    '2018-01-01',
    '2018-01-01'
  ),
  (
    '123.456.789-06',
    'Josias da Silva',
    'asdfasdfasd@gmail.com',
    '123456',
    'administrador',
    '1990-01-01',
    'Rua dos Bobos, 0',
    '(12) 91345-8789',
    'Português',
    'Inglês',
    'exemple.com',
    '1234567890123456',
    '01/2022',
    '123',
    '123.456.789-06',
    'Josias da Silva',
    'ativo',
    '2018-01-01',
    '2018-01-01'
  ),
  (
    '123.456.789-07',
    'Joseph da Silva',
    'ficaca@gmail.com',
    '123456',
    'tutor',
    '1990-01-01',
    'Rua dos Bobos, 0',
    '(12) 91345-8789',
    'Português',
    'Inglês',
    'exemple.com',
    '1234567890123456',
    '01/2022',
    '123',
    '123.456.789-07',
    'Joseph da Silva',
    'ativo',
    '2018-01-01',
    '2018-01-01'
  ),
  (
    '123.456.789-08',
    'Joana da Silva',
    'jsshfh@gmail.com',
    '123456',
    'tutor',
    '1990-01-01',
    'Rua dos Bobos, 0',
    '(12) 91345-8789',
    'Português',
    'Inglês',
    'exemple.com',
    '1234567890123456',
    '01/2022',
    '123',
    '123.456.789-08',
    'Joana da Silva',
    'ativo',
    '2018-01-01',
    '2018-01-01'
  );

/*Aluno = { usuário, assinante* }*/
INSERT INTO
  aluno
VALUES
  ('123.456.789-01', 'TRUE'),
  ('123.456.789-05', 'FALSE');

/*Administrador = { usuário, nível_acesso* }*/
INSERT INTO
  administrador
VALUES
  ('123.456.789-02', '1'),
  ('123.456.789-06', '2');

-- tutor voluntario e especialista
/*Tutor = { usuário, tipo*, cadastrado_por* }*/
INSERT INTO
  tutor
VALUES
  ('123.456.789-07', 'voluntario', '123.456.789-06'),
  ('123.456.789-03', 'voluntario', '123.456.789-02'),
  (
    '123.456.789-04',
    'especialista',
    '123.456.789-02'
  ),
  (
    '123.456.789-08',
    'especialista',
    '123.456.789-06'
  );

/*Voluntário = { tutor, motivação }*/
INSERT INTO
  voluntario
VALUES
  (
    '123.456.789-07',
    'Quero ajudar as pessoas a aprenderem a usar o WhatsApp'
  ),
  (
    '123.456.789-03',
    'Quero ajudar as pessoas a aprenderem a usar o Facebook'
  );

/*Especialista = { tutor, taxa*, currículo_acadêmico*, conta_nro_banco*, conta_agência*, conta_nro* }*/
INSERT INTO
  especialista
VALUES
  (
    '123.456.789-04',
    '100',
    'Sou formado em Engenharia de Software',
    '123456',
    '1234',
    '123456789'
  ),
  (
    '123.456.789-08',
    '100',
    'Sou formado em Engenharia de Software',
    '123456',
    '1234',
    '123456789'
  );

--interesse
INSERT INTO
  interesse
VALUES
  ('123.456.789-01', 'Whatsapp'),
  ('123.456.789-01', 'Facebook'),
  ('123.456.789-01', 'Programação'),
  ('123.456.789-01', 'Stands'),
  ('123.456.789-05', 'Whatsapp'),
  ('123.456.789-05', 'Facebook'),
  ('123.456.789-05', 'Programação'),
  ('123.456.789-05', 'Stands');

--AdministradorAtividade
INSERT INTO
  administrador_atividade
VALUES
  (
    '123.456.789-02',
    'Criou o tutor José da Silva',
    '2018-01-01:00:00:10'
  ),
  (
    '123.456.789-02',
    'Criou o tutor Jotaro da Silva',
    '2018-01-01:00:00:20'
  );

--TutorHabilidade
INSERT INTO
  tutor_habilidade
VALUES
  ('123.456.789-03', 'Whatsapp'),
  ('123.456.789-03', 'Facebook'),
  ('123.456.789-04', 'Programação'),
  ('123.456.789-04', 'Stands');

--TutorAvaliação
INSERT INTO
  tutor_avaliacao
VALUES
  (
    '123.456.789-03',
    '123.456.789-01',
    '5',
    '2018-01-01:00:00:10'
  ),
  (
    '123.456.789-04',
    '123.456.789-01',
    '4',
    '2018-01-01:00:00:20'
  );

/*Voluntário = { tutor, motivação }*/
INSERT INTO
  voluntario
VALUES
  (
    '123.456.789-07',
    'Quero ajudar as pessoas a aprenderem a usar o WhatsApp'
  ),
  (
    '123.456.789-03',
    'Quero ajudar as pessoas a aprenderem a usar o Facebook'
  );

/*Especialista = { tutor, taxa*, currículo_acadêmico*, conta_nro_banco*, conta_agência*, conta_nro* }*/
INSERT INTO
  especialista
VALUES
  (
    '123.456.789-04',
    '100',
    'Sou formado em Engenharia de Software',
    '123456',
    '1234',
    '123456789'
  ),
  (
    '123.456.789-08',
    '100',
    'Sou formado em Engenharia de Software',
    '123456',
    '1234',
    '123456789'
  );

/*Mensagem = { aluno1, aluno2, data_hora, conteudo }*/
INSERT INTO
  mensagem
VALUES
  (
    '123.456.789-01',
    '123.456.789-05',
    '2018-01-01:00:00:10',
    'Olá, tudo bem?'
  ),
  (
    '123.456.789-05',
    '123.456.789-01',
    '2018-01-01:00:00:20',
    'Td e vc?'
  );

/*Curso = { código, título*, categoria*, descrição*, nível_dificuldade*, média_aval, criado_por* }*/
INSERT INTO
  curso
VALUES
  (
    'CELIN-WA01',
    'Curso de WhatsApp',
    'Celular e Internet',
    'Curso de WhatsApp para  iniciantes',
    '1',
    '7',
    '123.456.789-04'
  ),
  (
    'CELIN-FB01',
    'Curso de Facebook',
    'Celular e Internet',
    'Curso de Facebook no Celular para  iniciantes',
    '1',
    '7',
    '123.456.789-04'
  );

/*Tutoria = { curso, voluntário }*/
INSERT INTO
  tutoria
VALUES
  ('CELIN-WA01', '123.456.789-03'),
  ('CELIN-FB01', '123.456.789-03');

/*Recurso = { curso, nome, descrição, tipo* }*/
INSERT INTO
  recurso
VALUES
  (
    'CELIN-WA01',
    'Grupo de WhatsApp',
    'Grupo de WhatsApp para tirar dúvidas',
    'comum'
  ),
  (
    'CELIN-WA01',
    'Video de WhatsApp',
    'Video de WhatsApp para tirar dúvidas',
    'comum'
  ),
  (
    'CELIN-FB01',
    'Grupo de Facebook',
    'Grupo de Facebook para tirar dúvidas',
    'comum'
  ),
  (
    'CELIN-FB01',
    'Video de Facebook',
    'Video de Facebook para tirar dúvidas',
    'comum'
  ),
  (
    'CELIN-WA01',
    'Tutoria Personalizada WhatsApp',
    'Tutoria de whatsapp',
    'pago'
  ),
  (
    'CELIN-WA01',
    'Atividade de WhatsApp - Conceitos Iniciais',
    'Atividade de WhatsApp - Conceitos Iniciais',
    'pago'
  ),
  (
    'CELIN-FB01',
    'Tutoria de Facebook',
    'Tutoria de Facebook',
    'pago'
  ),
  (
    'CELIN-FB01',
    'Atividade de Facebook - Conceitos Iniciais',
    'Atividade de Facebook - Conceitos Iniciais',
    'pago'
  );

/*RecursoPago = { recurso_curso, recurso_nome, preço_único*, tipo* }*/
INSERT INTO
  recurso_pago
VALUES
  (
    'CELIN-WA01',
    'Atividade de WhatsApp - Conceitos Iniciais',
    '10',
    'atividade_pratica'
  ),
  (
    'CELIN-WA01',
    'Tutoria Personalizada WhatsApp',
    '10',
    'tutoria_personalizada'
  ),
  (
    'CELIN-FB01',
    'Atividade de Facebook - Conceitos Iniciais',
    '10',
    'atividade_pratica'
  ),
  (
    'CELIN-FB01',
    'Tutoria de Facebook',
    '10',
    'tutoria_personalizada'
  );

/*Vídeotutorial = { recurso_curso, recurso_nome, url*, duração* }*/
INSERT INTO
  videotutorial
VALUES
  (
    'CELIN-WA01',
    'Video de WhatsApp',
    'https://www.youtube.com/watch?v=1',
    '10'
  ),
  (
    'CELIN-FB01',
    'Video de Facebook',
    'https://www.youtube.com/watch?v=2',
    '10'
  );

/*Guia = { recurso_curso, recurso_nome, formato*, url }*/
INSERT INTO
  guia
VALUES
  (
    'CELIN-WA01',
    'Grupo de WhatsApp',
    'txt',
    'https://www.google.com'
  ),
  (
    'CELIN-FB01',
    'Grupo de Facebook',
    'txt',
    'https://www.google.com'
  );

/*AtividadePrática = { recurso_pago_curso, recurso_pago_nome, duração, assunto*  }*/
INSERT INTO
  atividade_pratica
VALUES
  (
    'CELIN-WA01',
    'Atividade de WhatsApp - Conceitos Iniciais',
    '10',
    'Conceitos Iniciais'
  ),
  (
    'CELIN-FB01',
    'Atividade de Facebook - Conceitos Iniciais',
    '10',
    'Conceitos Iniciais'
  );

/*Questão = { id, atividade_prática_curso, atividade_prática_nome, nro, pergunta*, alt1*, alt2*, alt3, alt4, alt_correta* }*/
INSERT INTO
  questao
VALUES
  (
    '1',
    'CELIN-WA01',
    'Atividade de WhatsApp - Conceitos Iniciais',
    '1',
    'O que é o WhatsApp?',
    'Um aplicativo de mensagem',
    'Um aplicativo de musica',
    'Um aplicativo de video',
    'Um aplicativo de taxi',
    'a'
  ),
  (
    '2',
    'CELIN-FB01',
    'Atividade de Facebook - Conceitos Iniciais',
    '1',
    'O que é o Facebook?',
    'Uma rede social',
    'Um aplicativo de musica',
    'Um aplicativo de video',
    'Um aplicativo de taxi',
    'a'
  );

/*AtividadePráticaResposta = { aluno, questão, alternativa }*/
INSERT INTO
  atividade_pratica_resposta
VALUES
  ('123.456.789-01', '1', 'a'),
  ('123.456.789-01', '2', 'b');

/*TutoriaPersonalizada = { recurso_pago_curso, recurso_pago_nome, assunto* }*/
INSERT INTO
  tutoria_personalizada
VALUES
  (
    'CELIN-WA01',
    'Tutoria Personalizada WhatsApp',
    'Conceitos Iniciais'
  ),
  (
    'CELIN-FB01',
    'Tutoria de Facebook',
    'Conceitos Iniciais'
  );

/*Agendamento = { aluno, especialista, data_hora, tutoria_personalizada_curso*, tutoria_personalizada_nome* }*/
INSERT INTO
  agendamento
VALUES
  (
    '123.456.789-01',
    '123.456.789-04',
    '2021-01-01 10:00:00',
    'CELIN-WA01',
    'Tutoria Personalizada WhatsApp'
  ),
  (
    '123.456.789-01',
    '123.456.789-04',
    '2021-01-01 10:30:00',
    'CELIN-FB01',
    'Tutoria de Facebook'
  );

/*AlunoAcessoRecursoPago = { aluno, recurso_pago_curso, recurso_pago_nome }*/
INSERT INTO
  aluno_acesso_recurso_pago
VALUES
  (
    '123.456.789-01',
    'CELIN-WA01',
    'Atividade de WhatsApp - Conceitos Iniciais'
  ),
  (
    '123.456.789-01',
    'CELIN-WA01',
    'Tutoria Personalizada WhatsApp'
  ),
  (
    '123.456.789-01',
    'CELIN-FB01',
    'Atividade de Facebook - Conceitos Iniciais'
  ),
  (
    '123.456.789-01',
    'CELIN-FB01',
    'Tutoria de Facebook'
  );

/*AdministraRecurso = { recurso_curso, recurso_nome, especialista }*/
INSERT INTO
  administra_recurso
VALUES
  (
    'CELIN-WA01',
    'Atividade de WhatsApp - Conceitos Iniciais',
    '123.456.789-04'
  ),
  (
    'CELIN-WA01',
    'Tutoria Personalizada WhatsApp',
    '123.456.789-04'
  ),
  (
    'CELIN-FB01',
    'Atividade de Facebook - Conceitos Iniciais',
    '123.456.789-04'
  ),
  (
    'CELIN-FB01',
    'Tutoria de Facebook',
    '123.456.789-04'
  );

/*AlunoCursa = { aluno, curso, avaliação, nota, data_hora* }*/
INSERT INTO
  aluno_cursa
VALUES
  (
    '123.456.789-01',
    'CELIN-WA01',
    '10',
    '10',
    '2021-01-01 10:00:00'
  ),
  (
    '123.456.789-01',
    'CELIN-FB01',
    '10',
    '10',
    '2021-01-01 10:00:00'
  );