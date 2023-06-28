-- esse script foi desenvolvida para melhorar os resultados das consultas de media-alta complexidade
INSERT INTO
  usuario
VALUES
  (
    '123.456.789-09',
    'Tutor 1',
    'tutor1@gmail.com',
    '123456',
    'tutor',
    '1990-01-01',
    'Rua dos Tutor 1, 1',
    '(12) 3456-7890',
    'Português',
    'Inglês',
    'http://example.com',
    '1234567890123456',
    '01/2022',
    '123',
    '123.456.789-09',
    'Tutor 1',
    'ativo',
    '2018-01-01',
    '2018-01-01'
  ),
  (
    '123.456.789-10',
    'Tutor 2',
    'tutor2@gmail.com',
    '123456',
    'tutor',
    '1990-01-01',
    'Rua dos Tutor 2, 2',
    '(12) 3456-7890',
    'Português',
    'Inglês',
    'http://example.com',
    '1234567890123456',
    '01/2022',
    '123',
    '123.456.789-10',
    'Tutor 2',
    'ativo',
    '2018-01-01',
    '2018-01-01'
  ),
  (
    '123.456.789-11',
    'Tutor 3',
    'tutor3@gmail.com',
    '123456',
    'tutor',
    '1990-01-01',
    'Rua dos Tutor 3, 3',
    '(12) 3456-7890',
    'Português',
    'Inglês',
    'http://example.com',
    '1234567890123456',
    '01/2022',
    '123',
    '123.456.789-11',
    'Tutor 3',
    'ativo',
    '2018-01-01',
    '2018-01-01'
  ),
  (
    '123.456.789-12',
    'Tutor 4',
    'tutor4@gmail.com',
    '123456',
    'tutor',
    '1990-01-01',
    'Rua dos Tutor 4, 4',
    '(12) 3456-7890',
    'Português',
    'Inglês',
    'http://example.com',
    '1234567890123456',
    '01/2022',
    '123',
    '123.456.789-12',
    'Tutor 4',
    'ativo',
    '2018-01-01',
    '2018-01-01'
  ),
  (
    '123.456.789-13',
    'Tutor 5',
    'tutor5@gmail.com',
    '123456',
    'tutor',
    '1990-01-01',
    'Rua dos Tutor 5, 5',
    '(12) 3456-7890',
    'Português',
    'Inglês',
    'http://example.com',
    '1234567890123456',
    '01/2022',
    '123',
    '123.456.789-13',
    'Tutor 5',
    'ativo',
    '2018-01-01',
    '2018-01-01'
  ),
  (
    '123.456.789-14',
    'Tutor 6',
    'tutor6@gmail.com',
    '123456',
    'tutor',
    '1990-01-01',
    'Rua dos Tutor 6, 6',
    '(12) 3456-7890',
    'Português',
    'Inglês',
    'http://example.com',
    '1234567890123456',
    '01/2022',
    '123',
    '123.456.789-14',
    'Tutor 6',
    'ativo',
    '2018-01-01',
    '2018-01-01'
  ),
  (
    '123.456.789-15',
    'Tutor 7',
    'tutor7@gmail.com',
    '123456',
    'tutor',
    '1990-01-01',
    'Rua dos Tutor 7, 7',
    '(12) 3456-7890',
    'Português',
    'Inglês',
    'http://example.com',
    '1234567890123456',
    '01/2022',
    '123',
    '123.456.789-15',
    'Tutor 7',
    'ativo',
    '2018-01-01',
    '2018-01-01'
  ),
  (
    '123.456.789-16',
    'Tutor 8',
    'tutor8@gmail.com',
    '123456',
    'tutor',
    '1990-01-01',
    'Rua dos Tutor 8, 8',
    '(12) 3456-7890',
    'Português',
    'Inglês',
    'http://example.com',
    '1234567890123456',
    '01/2022',
    '123',
    '123.456.789-16',
    'Tutor 8',
    'ativo',
    '2018-01-01',
    '2018-01-01'
  ),
  (
    '123.456.789-17',
    'Tutor 9',
    'tutor9@gmail.com',
    '123456',
    'tutor',
    '1990-01-01',
    'Rua dos Tutor 9, 9',
    '(12) 3456-7890',
    'Português',
    'Inglês',
    'http://example.com',
    '1234567890123456',
    '01/2022',
    '123',
    '123.456.789-17',
    'Tutor 9',
    'ativo',
    '2018-01-01',
    '2018-01-01'
  ),
  (
    '123.456.789-18',
    'Tutor 10',
    'tutor10@gmail.com',
    '123456',
    'tutor',
    '1990-01-01',
    'Rua dos Tutor 10, 10',
    '(12) 3456-7890',
    'Português',
    'Inglês',
    'http://example.com',
    '1234567890123456',
    '01/2022',
    '123',
    '123.456.789-18',
    'Tutor 10',
    'ativo',
    '2018-01-01',
    '2018-01-01'
  );

/*Tutor = { usuário, tipo*, cadastrado_por* }*/
INSERT INTO
  tutor
VALUES
  (
    '123.456.789-09',
    'especialista',
    '123.456.789-02'
  ),
  (
    '123.456.789-10',
    'especialista',
    '123.456.789-06'
  ),
  (
    '123.456.789-11',
    'especialista',
    '123.456.789-02'
  ),
  (
    '123.456.789-12',
    'especialista',
    '123.456.789-06'
  ),
  (
    '123.456.789-13',
    'especialista',
    '123.456.789-02'
  ),
  ('123.456.789-14', 'voluntario', '123.456.789-06'),
  ('123.456.789-15', 'voluntario', '123.456.789-02'),
  ('123.456.789-16', 'voluntario', '123.456.789-06'),
  ('123.456.789-17', 'voluntario', '123.456.789-02'),
  ('123.456.789-18', 'voluntario', '123.456.789-06');

/*Voluntário = { tutor, motivação }*/
INSERT INTO
  voluntario
VALUES
  ('123.456.789-14', 'Motivação 1'),
  ('123.456.789-15', 'Motivação 2'),
  ('123.456.789-16', 'Motivação 3'),
  ('123.456.789-17', 'Motivação 4'),
  ('123.456.789-18', 'Motivação 5');

/*Especialista = { tutor, taxa*, currículo_acadêmico*, conta_nro_banco*, conta_agência*, conta_nro* }*/
INSERT INTO
  especialista
VALUES
  (
    '123.456.789-09',
    10.0,
    'Currículo 1',
    '1234567890123456',
    '1234',
    '123456'
  ),
  (
    '123.456.789-10',
    10.0,
    'Currículo 2',
    '1234567890123456',
    '1234',
    '123456'
  ),
  (
    '123.456.789-11',
    10.0,
    'Currículo 3',
    '1234567890123456',
    '1234',
    '123456'
  ),
  (
    '123.456.789-12',
    10.0,
    'Currículo 4',
    '1234567890123456',
    '1234',
    '123456'
  ),
  (
    '123.456.789-13',
    10.0,
    'Currículo 5',
    '1234567890123456',
    '1234',
    '123456'
  );

-- insert a curso for each especialista above
/*Curso = { código, título*, categoria*, descrição*, nível_dificuldade*, média_aval, criado_por* }*/
-- codigo is something like: CELIN-WA01
INSERT INTO
  curso
VALUES
  (
    'CELIN-WA02',
    'Curso 1',
    'Categoria 1',
    'Descrição 1',
    1,
    0.0,
    '123.456.789-09'
  ),
  (
    'CELIN-WA03',
    'Curso 2',
    'Categoria 2',
    'Descrição 2',
    5,
    0.0,
    '123.456.789-10'
  ),
  (
    'CELIN-WA04',
    'Curso 3',
    'Categoria 3',
    'Descrição 3',
    4,
    0.0,
    '123.456.789-11'
  ),
  (
    'CELIN-WA05',
    'Curso 4',
    'Categoria 4',
    'Descrição 4',
    4,
    0.0,
    '123.456.789-12'
  ),
  (
    'CELIN-WA06',
    'Curso 5',
    'Categoria 5',
    'Descrição 5',
    3,
    0.0,
    '123.456.789-13'
  );

-- have all the voluntarios above be inserted into tutoria
/*Tutoria = { curso, voluntário }*/
INSERT INTO
  tutoria
VALUES
  ('CELIN-WA02', '123.456.789-14'),
  ('CELIN-WA03', '123.456.789-15'),
  ('CELIN-WA04', '123.456.789-16'),
  ('CELIN-WA05', '123.456.789-17'),
  ('CELIN-WA06', '123.456.789-18');