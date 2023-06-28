-- Consulta 1: Listar os alunos que estão matriculados em todos os cursos disponíveis
SELECT
  u.cpf,
  u.nome
FROM
  usuario u
  JOIN aluno a ON u.cpf = a.usuario
  JOIN matricula m ON a.usuario = m.aluno
GROUP BY
  u.cpf, u.nome
HAVING
  COUNT(DISTINCT m.curso) = (SELECT COUNT(*) FROM curso);

-- Consulta 2: Listar os tutores que possuem uma média de avaliação superior a 4.5
SELECT
  u.cpf,
  u.nome
FROM
  usuario u
  JOIN tutor t ON u.cpf = t.usuario
  JOIN tutor_avaliacao ta ON t.usuario = ta.tutor
GROUP BY
  u.cpf, u.nome
HAVING
  AVG(ta.avaliacao) > 4.5;

-- Consulta 3: Listar os cursos que possuem mais de 2 alunos matriculados
SELECT
  c.codigo,
  c.titulo
FROM
  curso c
  JOIN matricula m ON c.codigo = m.curso
GROUP BY
  c.codigo, c.titulo
HAVING
  COUNT(DISTINCT m.aluno) > 2;

-- Consulta 4: Listar os alunos que já participaram de todas as tutorias ministradas por um tutor específico
SELECT
  u.cpf,
  u.nome
FROM
  usuario u
  JOIN aluno a ON u.cpf = a.usuario
  JOIN participacao p ON a.usuario = p.aluno
  JOIN tutoria t ON p.tutoria = t.codigo
WHERE
  t.tutor = 'CPF_DO_TUTOR'
GROUP BY
  u.cpf, u.nome
HAVING
  COUNT(DISTINCT p.tutoria) = (SELECT COUNT(*) FROM tutoria WHERE tutor = 'CPF_DO_TUTOR');

-- Consulta 5: Listar os alunos que realizaram pelo menos uma compra de recurso pago em cada curso que estão matriculados
SELECT
  u.cpf,
  u.nome
FROM
  usuario u
  JOIN aluno a ON u.cpf = a.usuario
  JOIN curso c ON a.usuario = c.aluno
  LEFT JOIN compra co ON a.usuario = co.aluno AND c.codigo = co.curso
WHERE
  co.recurso_pago = TRUE
GROUP BY
  u.cpf, u.nome
HAVING
  COUNT(DISTINCT c.codigo) = (SELECT COUNT(*) FROM curso);
