-- Selecionar média de avaliação de tutores de cursos que contenham recurso pago vídeo tutorial e sejam cursados por mais de 5 alunos. Selecionar também a média de avaliação dos cursos
SELECT COUNT(*) AS "Agendamentos", COUNT(DISTINCT agendamento.aluno) AS "Alunos atendidos"
FROM agendamento
JOIN especialista ON especialista.tutor = agendamento.especialista
WHERE agendamento.data_hora >= '2023-01-01' AND agendamento.data_hora <= '2023-12-31'
GROUP BY agendamento.especialista;

-- Selecionar média de avaliação de tutores de cursos que contenham recurso pago vídeo tutorial e sejam cursados por mais de 5 alunos. Selecionar também a média de avaliação dos cursos

SELECT AVG(TA.avaliacao) AS "Média de Avaliação dos Tutores", AVG(C.media_aval) AS "Média de Avaliação dos Cursos"
FROM tutor_avaliacao AS TA
JOIN tutor AS T ON TA.tutor = t.usuario
JOIN voluntario AS V ON T.usuario = V.tutor
JOIN tutoria AS TR ON TR.voluntario = V.tutor
JOIN curso AS C ON C.codigo = TR.curso
JOIN aluno_cursa AS AC ON C.codigo = AC.curso
JOIN recurso_pago AS RP ON C.codigo = RP.recurso_curso AND RP.tipo = 'tutoria_personalizada'
GROUP BY C.codigo
HAVING COUNT(AC.aluno) > 5;

-- Selecionar a dificuldade média de todos os cursos, e se houver, média das avaliações dos cursos por categoria, assim como a idade média dos alunos que cursam esses cursos

SELECT C.categoria AS "Categoria", TO_CHAR(AVG(C.nivel_dificuldade), 'FM999999999.00') AS "Dificuldade Média",  TO_CHAR(AVG(AGE(CURRENT_DATE, U.data_nasc)), 'YY') AS "Idade Média", TO_CHAR(AVG(C.media_aval), 'FM999999999.00') AS "Média de Avaliações"
FROM usuario AS U
JOIN aluno AS A ON U.cpf = A.usuario
LEFT JOIN aluno_cursa AS AC ON A.usuario = AC.aluno
RIGHT JOIN curso as C ON AC.curso = C.codigo
GROUP BY C.categoria
HAVING AVG(C.nivel_dificuldade) < 5
ORDER BY C.categoria;
