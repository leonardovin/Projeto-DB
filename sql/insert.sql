-- Insert entries for "Usuário" table
INSERT INTO
  Usuario (
    CPF,
    nome,
    email,
    senha,
    tipo,
    data_nasc,
    endereço,
    telefone,
    idioma1,
    idioma2,
    url_foto_perfil,
    cartão_cred_nro,
    cartão_cred_validade,
    cartão_cred_cvv,
    cartão_cred_cpf,
    cartão_cred_titular,
    status,
    data_último_acesso,
    data_última_edição
  )
VALUES
  (
    '12345678901',
    'John Doe',
    'johndoe@example.com',
    'password1',
    'tipo1',
    '2000-01-01',
    '123 Main St',
    '1234567890',
    'English',
    'Spanish',
    'https://example.com/profile1.jpg',
    '1234567890123456',
    '2025-12',
    '123',
    '12345678901',
    'John Doe',
    'ativo',
    '2023-06-20',
    '2023-06-20'
  );

INSERT INTO
  Usuario (
    CPF,
    nome,
    email,
    senha,
    tipo,
    data_nasc,
    endereço,
    telefone,
    idioma1,
    idioma2,
    url_foto_perfil,
    cartão_cred_nro,
    cartão_cred_validade,
    cartão_cred_cvv,
    cartão_cred_cpf,
    cartão_cred_titular,
    status,
    data_último_acesso,
    data_última_edição
  )
VALUES
  (
    '98765432109',
    'Jane Smith',
    'janesmith@example.com',
    'password2',
    'tipo2',
    '1995-05-10',
    '456 Oak St',
    '9876543210',
    'French',
    NULL,
    'https://example.com/profile2.jpg',
    '9876543210987654',
    '2024-09',
    '456',
    '98765432109',
    'Jane Smith',
    'ativo',
    '2023-06-19',
    '2023-06-19'
  );

-- Insert entries for "Mensagem" table
INSERT INTO
  mensagem (
    Curso,
    título,
    categoria,
    descrição,
    nível_dificuldade,
    média_aval,
    criado_por
  )
VALUES
  (
    'curso1',
    'título1',
    'categoria1',
    'descrição1',
    'fácil',
    4.5,
    'usuario1'
  );

INSERT INTO
  mensagem (
    Curso,
    título,
    categoria,
    descrição,
    nível_dificuldade,
    média_aval,
    criado_por
  )
VALUES
  (
    'curso2',
    'título2',
    'categoria2',
    'descrição2',
    'médio',
    3.8,
    'usuario2'
  );

-- Insert entries for "Recurso" table
INSERT INTO
  recurso (curso, nome, descrição, tipo)
VALUES
  ('curso1', 'recurso1', 'descrição1', 'tipo1');

INSERT INTO
  recurso (curso, nome, descrição, tipo)
VALUES
  ('curso2', 'recurso2', 'descrição2', 'tipo2');

-- Insert entries for "RecursoPago" table
INSERT INTO
  recurso_pago (recurso_curso, recurso_nome, preço_único, tipo)
VALUES
  ('curso1', 'recurso1', 10.99, 'tipo1');

INSERT INTO
  recurso_pago (recurso_curso, recurso_nome, preço_único, tipo)
VALUES
  ('curso2', 'recurso2', 19.99, 'tipo2');

-- Insert entries for "Vídeotutorial" table
INSERT INTO
  vídeotutorial (recurso_curso, recurso_nome, duração)
VALUES
  ('curso1', 'recurso1', '1 hour');

INSERT INTO
  vídeotutorial (recurso_curso, recurso_nome, duração)
VALUES
  ('curso2', 'recurso2', '45 minutes');

-- Insert entries for "Guia" table
INSERT INTO
  guia (recurso_curso, recurso_nome, formato)
VALUES
  ('curso1', 'recurso1', 'PDF');

INSERT INTO
  guia (recurso_curso, recurso_nome, formato)
VALUES
  ('curso2', 'recurso2', 'eBook');

-- Insert entries for "AtividadePrática" table
INSERT INTO
  atividadeprática (
    recurso_pago_curso,
    recurso_pago_nome,
    duração,
    assunto
  )
VALUES
  ('curso1', 'recurso1', '2 hours', 'assunto1');

INSERT INTO
  atividadeprática (
    recurso_pago_curso,
    recurso_pago_nome,
    duração,
    assunto
  )
VALUES
  ('curso2', 'recurso2', '1.5 hours', 'assunto2');

-- Insert entries for "Questão" table
INSERT INTO
  questão (
    id,
    atividade_prática_curso,
    atividade_prática_nome,
    nro,
    pergunta,
    alt1,
    alt2,
    alt3,
    alt4,
    alt_correta
  )
VALUES
  (
    1,
    'curso1',
    'recurso1',
    1,
    'pergunta1',
    'opção1',
    'opção2',
    'opção3',
    'opção4',
    'opção1'
  );

INSERT INTO
  questão (
    id,
    atividade_prática_curso,
    atividade_prática_nome,
    nro,
    pergunta,
    alt1,
    alt2,
    alt3,
    alt4,
    alt_correta
  )
VALUES
  (
    2,
    'curso2',
    'recurso2',
    1,
    'pergunta2',
    'opção1',
    'opção2',
    'opção3',
    'opção4',
    'opção3'
  );

-- Insert entries for "TutoriaPersonalizada" table
INSERT INTO
  tutoriapersonalizada (recurso_pago_curso, recurso_pago_nome, assunto)
VALUES
  ('curso1', 'recurso1', 'assunto1');

INSERT INTO
  tutoriapersonalizada (recurso_pago_curso, recurso_pago_nome, assunto)
VALUES
  ('curso2', 'recurso2', 'assunto2');

-- Insert entries for "Agendamento" table
INSERT INTO
  agendamento (
    aluno,
    especialista,
    data_hora,
    tutoria_personalizada_curso,
    tutoria_personalizada_nome
  )
VALUES
  (
    'usuario1',
    'especialista1',
    '2023-06-21 10:00:00',
    'curso1',
    'recurso1'
  );

INSERT INTO
  agendamento (
    aluno,
    especialista,
    data_hora,
    tutoria_personalizada_curso,
    tutoria_personalizada_nome
  )
VALUES
  (
    'usuario2',
    'especialista2',
    '2023-06-21 11:00:00',
    'curso2',
    'recurso2'
  );

-- Insert entries for "AlunoAcessoRecursoPago" table
INSERT INTO
  aluno_acesso_recurso_pago (aluno, recurso_pago_curso, recurso_pago_nome)
VALUES
  ('usuario1', 'curso1', 'recurso1');

INSERT INTO
  aluno_acesso_recurso_pago (aluno, recurso_pago_curso, recurso_pago_nome)
VALUES
  ('usuario2', 'curso2', 'recurso2');

-- Insert entries for "AdministraRecurso" table
INSERT INTO
  administra_recurso (recurso_curso, recurso_nome, especialista)
VALUES
  ('curso1', 'recurso1', 'especialista1');

INSERT INTO
  administra_recurso (recurso_curso, recurso_nome, especialista)
VALUES
  ('curso2', 'recurso2', 'especialista2');

-- Insert entries for "AlunoCursa" table
INSERT INTO
  aluno_cursa (aluno, curso, avaliação, nota, data_hora)
VALUES
  (
    'usuario1',
    'curso1',
    'avaliação1',
    4.5,
    '2023-06-20 14:00:00'
  );

INSERT INTO
  aluno_cursa (aluno, curso, avaliação, nota, data_hora)
VALUES
  (
    'usuario2',
    'curso2',
    'avaliação2',
    3.8,
    '2023-06-19 15:00:00'
  );

-- Insert entries for "Tutoria" table
INSERT INTO
  tutoria (curso, voluntário)
VALUES
  ('curso1', 'tutor1');

INSERT INTO
  tutoria (curso, voluntário)
VALUES
  ('curso2', 'tutor2');