-- Consulta 1: Listar os alunos que estão matriculados em todos os cursos disponíveis
SELECT
  u.cpf,
  u.nome
FROM
  usuario u
  JOIN aluno a ON u.cpf = a.usuario
WHERE
  NOT EXISTS (
    SELECT
      c.codigo
    FROM
      curso c
    WHERE
      NOT EXISTS (
        SELECT
          *
        FROM
          matricula m
        WHERE
          m.aluno = a.usuario
          AND m.curso = c.codigo
      )
  );

/*
 Explicação: Essa consulta retorna os alunos que estão matriculados em todos os cursos disponíveis. Ela utiliza a cláusula NOT EXISTS para verificar se não existe nenhuma matrícula para um aluno em algum curso. Os alunos que não possuem nenhuma matrícula são considerados como estando matriculados em todos os cursos.
 */
-- Consulta 2: Listar os tutores que possuem uma média de avaliação superior a 4.5
SELECT
  u.cpf,
  u.nome
FROM
  usuario u
  JOIN tutor t ON u.cpf = t.usuario
WHERE
  (
    SELECT
      AVG(avaliacao)
    FROM
      tutor_avaliacao
    WHERE
      tutor = u.cpf
  ) > 4.5;

/*
 Explicação: Essa consulta retorna os tutores que possuem uma média de avaliação superior a 4.5. Ela calcula a média de avaliação para cada tutor usando uma subconsulta e retorna apenas aqueles que possuem uma média superior a 4.5.
 */
-- Consulta 3: Listar os cursos que possuem mais de 2 alunos matriculados
SELECT
  c.codigo,
  c.titulo
FROM
  curso c
  JOIN (
    SELECT
      curso,
      COUNT(*) AS total_alunos
    FROM
      matricula
    GROUP BY
      curso
    HAVING
      COUNT(*) > 2
  ) m ON c.codigo = m.curso;

/*
 Explicação: Essa consulta retorna os cursos que possuem mais de 100 alunos matriculados. Ela utiliza uma subconsulta para contar o número de alunos matriculados em cada curso e retorna apenas os cursos que possuem mais de 100 alunos matriculados.
 */
-- Consulta 4: Listar os alunos que já participaram de todas as tutorias ministradas por um tutor específico
SELECT
  u.cpf,
  u.nome
FROM
  usuario u
  JOIN aluno a ON u.cpf = a.usuario
WHERE
  NOT EXISTS (
    SELECT
      t.codigo
    FROM
      tutoria t
    WHERE
      NOT EXISTS (
        SELECT
          *
        FROM
          participacao p
        WHERE
          p.aluno = a.usuario
          AND p.tutoria = t.codigo
      )
      AND t.tutor = 'CPF_DO_TUTOR'
  );

/*
 Explicação: Essa consulta retorna os alunos que já participaram de todas as tutorias ministradas por um tutor específico. Ela utiliza a cláusula NOT EXISTS para verificar se um aluno não participou de alguma tutoria ministrada por um tutor específico. Os alunos que não possuem nenhuma participação são considerados como tendo participado de todas as tutorias.
 */
-- Consulta 5: Listar os alunos que realizaram pelo menos uma compra de recurso pago em cada curso que estão matriculados
SELECT
  u.cpf,
  u.nome
FROM
  usuario u
  JOIN aluno a ON u.cpf = a.usuario
WHERE
  NOT EXISTS (
    SELECT
      c.codigo
    FROM
      curso c
    WHERE
      NOT EXISTS (
        SELECT
          *
        FROM
          compra co
        WHERE
          co.aluno = a.usuario
          AND co.curso = c.codigo
          AND co.recurso_pago = TRUE
      )
  );

/*
 Explicação: Essa consulta retorna os alunos que realizaram pelo menos uma compra de recurso pago em cada curso que estão matriculados. Ela utiliza a cláusula NOT EXISTS para verificar se um aluno não realizou nenhuma compra de recurso pago em algum curso que está matriculado. Os alunos que não possuem nenhuma compra são considerados como tendo realizado pelo menos uma compra em cada curso.
 */