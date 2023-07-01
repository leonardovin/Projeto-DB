-- Seleciona número de agendamentos de tutores por período de tempo e o número de alunos atendidos no período
SELECT
  TO_CHAR(A.data_hora, 'Month') AS "Mês",
  TO_CHAR(A.data_hora, 'YYYY') AS "Ano",
  COUNT(*) AS "Agendamentos",
  COUNT(DISTINCT A.aluno) AS "Alunos Atendidos"
FROM
  agendamento AS A
  JOIN especialista AS E ON A.especialista = E.tutor
GROUP BY
  TO_CHAR(A.data_hora, 'Month'),
  TO_CHAR(A.data_hora, 'YYYY'),
  A.especialista;

-- Seleciona a média de avaliação de tutores de cursos que contenham recurso pago tutoria personalizada e sejam cursados por mais de 5 alunos. Seleciona também a média de avaliação dos cursos
SELECT
  AVG(TA.avaliacao) AS "Média de Avaliação dos Tutores",
  AVG(C.media_aval) AS "Média de Avaliação dos Cursos",
  C.codigo AS "Codigo do Curso"
FROM
  tutor_avaliacao AS TA
  JOIN tutor AS T ON TA.tutor = t.usuario
  JOIN voluntario AS V ON T.usuario = V.tutor
  JOIN tutoria AS TR ON TR.voluntario = V.tutor
  JOIN curso AS C ON C.codigo = TR.curso
  JOIN aluno_cursa AS AC ON C.codigo = AC.curso
  JOIN recurso_pago AS RP ON C.codigo = RP.recurso_curso
  AND RP.tipo = 'tutoria_personalizada'
GROUP BY
  C.codigo
HAVING
  COUNT(AC.aluno) > 3;

-- Seleciona a dificuldade média de todos os cursos, e se houver, média das avaliações dos cursos, por categoria, assim como a idade média dos alunos que cursam esses cursos
SELECT
  C.categoria AS "Categoria",
  TO_CHAR(AVG(C.nivel_dificuldade), 'FM999999999.00') AS "Dificuldade Média",
  TO_CHAR(AVG(AGE(CURRENT_DATE, U.data_nasc)), 'YY') AS "Idade Média",
  TO_CHAR(AVG(C.media_aval), 'FM999999999.00') AS "Média de Avaliações"
FROM
  usuario AS U
  JOIN aluno AS A ON U.cpf = A.usuario
  LEFT JOIN aluno_cursa AS AC ON A.usuario = AC.aluno
  RIGHT JOIN curso AS C ON AC.curso = C.codigo
GROUP BY
  C.categoria
HAVING
  AVG(C.nivel_dificuldade) < 5
ORDER BY
  C.categoria;

-- Seleciona a média de avaliação dos cursos avaliados pelo usuário, considerando apenas avaliações com nota entre 3 e 8, e a média de avaliação dos cursos cursados pelo usuário
SELECT
  U.nome AS "Aluno",
  AVG(
    CASE
      WHEN AC.avaliacao BETWEEN 3
      AND 8 THEN AC.avaliacao
    END
  ) AS "Média de Avaliação de Cursos Pelo Usuário",
  AVG(C.media_aval) AS "Média de Avaliação dos Cursos Cursados Pelo Usuário"
FROM
  usuario AS U
  JOIN aluno AS A ON U.cpf = A.usuario
  LEFT JOIN aluno_cursa AS AC ON A.usuario = AC.aluno
  JOIN curso AS C ON AC.curso = C.codigo
GROUP BY
  U.nome
ORDER BY
  U.nome;

-- Seleciona alunos que cursam todos os cursos tutorados pelo tutor voluntário '123.456.789-20'
SELECT A.usuario
FROM aluno AS A
WHERE NOT EXISTS (
  SELECT T.curso
  FROM tutoria AS T
  WHERE T.voluntario = '123.456.789-18'
    AND T.curso NOT IN (
      SELECT AC.curso
      FROM aluno_cursa AS AC
      WHERE AC.aluno = A.usuario
    )
);
