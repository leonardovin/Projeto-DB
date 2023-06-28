-- Selecionar média de avaliação de tutores de cursos que contenham recurso pago vídeo tutorial e sejam cursados por mais de 5 alunos. Selecionar também a média de avaliação dos cursos

SELECT AVG(ta.avaliacao) AS "Média de Avaliação dos Tutores", AVG(c.media_aval) AS "Média de Avaliação dos Cursos"
FROM tutor_avaliacao ta
JOIN tutor t ON ta.tutor = t.usuario
JOIN voluntario v ON t.usuario = v.tutor
JOIN tutoria tr ON tr.voluntario = v.tutor
JOIN curso c ON c.codigo = tr.curso
JOIN recurso_pago rp ON c.codigo = rp.recurso_curso AND rp.tipo = 'tutoria_personalizada'
GROUP BY c.codigo
HAVING COUNT(DISTINCT tr.curso) > 5;
