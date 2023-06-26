CREATE TYPE status AS ENUM ('ativo', 'inativo');

CREATE TYPE usuario_tipo AS ENUM ('aluno', 'tutor', 'administrador');

/*
 Usuário = { CPF, nome*, email*, senha*, tipo*, data_nasc*, endereço*, telefone*, idioma1*, idioma2, url_foto_perfil,
 cartão_cred_nro, cartão_cred_validade, cartão_cred_cvv, cartão_cred_cpf, cartão_cred_titular,
 status*, data_último_acesso, data_última_edição }
 */
CREATE TABLE usuario (
  cpf CHAR(14),
  nome VARCHAR(50) NOT NULL,
  email VARCHAR(50) NOT NULL,
  senha VARCHAR(30) NOT NULL,
  tipo usuario_tipo NOT NULL,
  data_nasc DATE NOT NULL,
  endereco VARCHAR(255) NOT NULL,
  telefone VARCHAR(14) NOT NULL,
  idioma1 VARCHAR(20) NOT NULL,
  idioma2 VARCHAR(20),
  url_foto_perfil VARCHAR(255),
  cartao_cred_nro CHAR(16),
  cartao_cred_validade VARCHAR(7),
  cartao_cred_cvv VARCHAR(3),
  cartao_cred_cpf CHAR(14),
  cartao_cred_titular VARCHAR(50),
  status status NOT NULL,
  data_ultimo_acesso TIMESTAMP,
  data_ultima_edicao TIMESTAMP,
  CONSTRAINT pk_usuario PRIMARY KEY (cpf),
  CONSTRAINT cpf_formato CHECK (
    cartao_cred_cpf ~ '^[0-9]{3}\.[0-9]{3}\.[0-9]{3}\-[0-9]{2}$'
  ),
  CONSTRAINT cartao_cred_cpf_formato CHECK (
    cartao_cred_cpf ~ '^[0-9]{3}\.[0-9]{3}\.[0-9]{3}\-[0-9]{2}$'
  ),
  CONSTRAINT email_formato CHECK (
    email ~ '^[A-Za-z0-9\._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$'
  ),
  CONSTRAINT cartao_cred_val_formato CHECK (cartao_cred_validade ~ '^[0-9]{2}/[0-9]{4}$'),
  CONSTRAINT telefone_formato CHECK (telefone ~ '^\([0-9]{2}\) [0-9]{4,5}\-[0-9]{4}$'),
  CONSTRAINT data_nasc_validate CHECK (
    data_nasc < CURRENT_DATE
    AND data_nasc > '1900-01-01'
  )
);

/*Aluno = { usuário, assinante* }*/
CREATE TABLE aluno (
  usuario CHAR(14),
  assinante BOOLEAN NOT NULL,
  CONSTRAINT pk_aluno PRIMARY KEY (usuario),
  CONSTRAINT fk_aluno_usuario FOREIGN KEY (usuario) REFERENCES usuario(cpf)
);

/*Administrador = { usuário, nível_acesso* }*/
CREATE TABLE administrador (
  usuario CHAR(14),
  nivel_acesso INTEGER NOT NULL,
  CONSTRAINT pk_administrador PRIMARY KEY (usuario),
  CONSTRAINT fk_administrador_usuario FOREIGN KEY (usuario) REFERENCES usuario(cpf)
);

CREATE TYPE tipo_tutor as ENUM ('voluntario', 'especialista');

/*Tutor = { usuário, tipo*, cadastrado_por* }*/
CREATE TABLE tutor (
  usuario CHAR(14) NOT NULL,
  tipo tipo_tutor NOT NULL,
  cadastrado_por CHAR(14) NOT NULL,
  CONSTRAINT pk_tutor PRIMARY KEY (usuario),
  CONSTRAINT fk_tutor_usuario FOREIGN KEY (usuario) REFERENCES usuario(cpf),
  CONSTRAINT fk_tutor_cadastrado_por FOREIGN KEY (cadastrado_por) REFERENCES administrador(usuario)
);

/*Interesse = { aluno, interesse }*/
CREATE TABLE interesse (
  aluno CHAR(14),
  interesse VARCHAR(50) NOT NULL,
  CONSTRAINT pk_interesse PRIMARY KEY (aluno, interesse),
  CONSTRAINT fk_interesse_aluno FOREIGN KEY (aluno) REFERENCES aluno(usuario)
);

/*AdministradorAtividade = { administrador, log*,  data_hora* }*/
CREATE TABLE administrador_atividade (
  administrador CHAR(14),
  log TEXT,
  data_hora TIMESTAMP NOT NULL,
  CONSTRAINT pk_administrador_atividade PRIMARY KEY (administrador, data_hora),
  CONSTRAINT fk_administrador_atividade_administrador FOREIGN KEY (administrador) REFERENCES administrador(usuario)
);

/*TutorHabilidade = { tutor, habilidade }*/
CREATE TABLE tutor_habilidade (
  tutor CHAR(14),
  habilidade VARCHAR(50) NOT NULL,
  CONSTRAINT pk_tutor_habilidade PRIMARY KEY (tutor, habilidade),
  CONSTRAINT fk_tutor_habilidade_tutor FOREIGN KEY (tutor) REFERENCES tutor(usuario)
);

/*TutorAvaliação = { tutor, aluno, avaliação*, data_hora* }*/
CREATE TABLE tutor_avaliacao (
  tutor CHAR(14),
  aluno CHAR(14),
  avaliacao INTEGER NOT NULL,
  data_hora TIMESTAMP NOT NULL,
  CONSTRAINT pk_tutor_avaliacao PRIMARY KEY (tutor, aluno, data_hora),
  CONSTRAINT fk_tutor_avaliacao_tutor FOREIGN KEY (tutor) REFERENCES tutor(usuario),
  CONSTRAINT fk_tutor_avaliacao_aluno FOREIGN KEY (aluno) REFERENCES aluno(usuario)
);

/*Voluntário = { tutor, motivação }*/
CREATE TABLE voluntario (
  tutor CHAR(14),
  motivacao TEXT,
  CONSTRAINT pk_voluntario PRIMARY KEY (tutor),
  CONSTRAINT fk_voluntario_tutor FOREIGN KEY (tutor) REFERENCES tutor(usuario)
);

/*Especialista = { tutor, taxa*, currículo_acadêmico*, conta_nro_banco*, conta_agência*, conta_nro* }*/
CREATE TABLE especialista (
  tutor CHAR(14),
  taxa DECIMAL(10, 2) NOT NULL,
  curriculo_academico TEXT,
  conta_nro_banco VARCHAR(20),
  conta_agencia VARCHAR(20),
  conta_nro VARCHAR(20),
  CONSTRAINT pk_especialista PRIMARY KEY (tutor),
  CONSTRAINT fk_especialista_tutor FOREIGN KEY (tutor) REFERENCES tutor(usuario)
);

/*AtividadePráticaResposta = { aluno, questão, alternativa }*/
CREATE TABLE atividade_pratica_resposta (
  aluno CHAR(14),
  questao INTEGER NOT NULL,
  alternativa char(1),
  CONSTRAINT pk_atividade_pratica_resposta PRIMARY KEY (aluno, questao),
  CONSTRAINT fk_atividade_pratica_resposta_aluno FOREIGN KEY (aluno) REFERENCES aluno(usuario)
);

/*Mensagem = { aluno1, aluno2, data_hora, conteudo }*/
CREATE TABLE mensagem (
  aluno1 CHAR(14),
  aluno2 CHAR(14),
  data_hora TIMESTAMP NOT NULL,
  conteudo TEXT,
  CONSTRAINT pk_mensagem PRIMARY KEY (aluno1, aluno2, data_hora),
  CONSTRAINT fk_mensagem_aluno1 FOREIGN KEY (aluno1) REFERENCES aluno(usuario),
  CONSTRAINT fk_mensagem_aluno2 FOREIGN KEY (aluno2) REFERENCES aluno(usuario)
);

/*Curso = { código, título*, categoria*, descrição*, nível_dificuldade*, média_aval, criado_por* }*/
CREATE TABLE curso (
  codigo CHAR(10),
  titulo VARCHAR(100) NOT NULL,
  categoria CHAR(30) NOT NULL,
  descricao TEXT,
  nivel_dificuldade INTEGER,
  media_aval DECIMAL(2, 1),
  criado_por VARCHAR(14),
  CONSTRAINT pk_curso PRIMARY KEY (codigo),
  CONSTRAINT fk_curso_criado_por FOREIGN KEY (criado_por) REFERENCES administrador(usuario),
  CONSTRAINT chk_nivel_dificuldade CHECK (
    nivel_dificuldade BETWEEN 1
    AND 10
  )
);

CREATE TYPE recurso_tipo as ENUM ('pago', 'comum');

/*Recurso = { curso, nome, descrição, tipo* }*/
CREATE TABLE recurso (
  curso CHAR(10),
  nome VARCHAR(50),
  descricao TEXT,
  tipo recurso_tipo NOT NULL,
  CONSTRAINT pk_recurso PRIMARY KEY (curso, nome),
  CONSTRAINT fk_recurso_curso FOREIGN KEY (curso) REFERENCES curso(codigo)
);

CREATE TYPE recurso_pago_tipo as ENUM ('videotutorial', 'atividade_pratica');

/*RecursoPago = { recurso_curso, recurso_nome, preço_único*, tipo* }*/
CREATE TABLE recurso_pago (
  recurso_curso CHAR(10),
  recurso_nome VARCHAR(50),
  preco_unico DECIMAL(10, 2) NOT NULL,
  tipo recurso_pago_tipo NOT NULL,
  CONSTRAINT pk_recurso_pago PRIMARY KEY (recurso_curso, recurso_nome),
  CONSTRAINT fk_recurso_pago_recurso foreign key (recurso_curso, recurso_nome) references recurso(curso, nome)
);

/*Vídeotutorial = { recurso_curso, recurso_nome, duração* }*/
CREATE TABLE videotutorial (
  recurso_curso CHAR(10),
  recurso_nome VARCHAR(50),
  duracao INTERVAL NOT NULL,
  CONSTRAINT pk_videotutorial PRIMARY KEY (recurso_curso, recurso_nome),
  CONSTRAINT fk_videdotutorial_recurso foreign key (recurso_curso, recurso_nome) REFERENCES recurso(curso, nome)
);

/*Guia = { recurso_curso, recurso_nome, formato* }*/
CREATE TABLE guia (
  recurso_curso char(10),
  recurso_nome VARCHAR(50),
  formato char(3) NOT NULL,
  CONSTRAINT pk_guia PRIMARY KEY (recurso_curso, recurso_nome),
  CONSTRAINT fk_guia_recurso_curso foreign key (recurso_curso, recurso_nome) REFERENCES recurso(curso, nome)
);

/*AtividadePrática = { recurso_pago_curso, recurso_pago_nome, duração, assunto*  }*/
CREATE TABLE atividade_pratica (
  recurso_pago_curso CHAR(10),
  recurso_pago_nome VARCHAR(50),
  duracao INTERVAL,
  assunto VARCHAR(50) NOT NULL,
  CONSTRAINT pk_atividade_pratica PRIMARY KEY (recurso_pago_curso, recurso_pago_nome),
  CONSTRAINT fk_atividade_pratica_recurso_pago FOREIGN KEY (recurso_pago_curso, recurso_pago_nome) REFERENCES recurso_pago(recurso_curso, recurso_nome)
);

/*Questão = { id, atividade_prática_curso, atividade_prática_nome, nro, pergunta*, alt1*, alt2*, alt3, alt4, alt_correta* }*/
CREATE TABLE questao (
  id SERIAL,
  atividade_pratica_curso char(10),
  atividade_pratica_nome VARCHAR(50),
  nro INTEGER NOT NULL,
  pergunta TEXT NOT NULL,
  alt1 TEXT NOT NULL,
  alt2 TEXT NOT NULL,
  alt3 TEXT,
  alt4 TEXT,
  alt_correta VARCHAR(1) NOT null,
  CONSTRAINT pk_questao PRIMARY KEY (id),
  CONSTRAINT fk_questao_atividade_pratica FOREIGN KEY (atividade_pratica_curso, atividade_pratica_nome) REFERENCES atividade_pratica(recurso_pago_curso, recurso_pago_nome)
);

/*TutoriaPersonalizada = { recurso_pago_curso, recurso_pago_nome, assunto* }*/
CREATE TABLE tutoria_personalizada (
  recurso_pago_curso char(10),
  recurso_pago_nome VARCHAR(50),
  assunto VARCHAR(50) NOT NULL,
  CONSTRAINT pk_tutoria_personalizada PRIMARY KEY (recurso_pago_curso, recurso_pago_nome),
  CONSTRAINT fk_tutoria_personalizada_pk foreign key (recurso_pago_curso, recurso_pago_nome) references recurso_pago(recurso_curso, recurso_nome)
);

/*Agendamento = { aluno, especialista, data_hora, tutoria_personalizada_curso*, tutoria_personalizada_nome* }*/
CREATE TABLE agendamento (
  aluno CHAR(14),
  especialista CHAR(14),
  data_hora TIMESTAMP NOT NULL,
  tutoria_personalizada_curso CHAR(10),
  tutoria_personalizada_nome VARCHAR(50),
  CONSTRAINT pk_agendamento PRIMARY KEY (aluno, especialista, data_hora),
  CONSTRAINT fk_agendamento_aluno FOREIGN KEY (aluno) REFERENCES aluno(usuario),
  CONSTRAINT fk_agendamento_especialista FOREIGN KEY (especialista) REFERENCES especialista(tutor),
  CONSTRAINT fk_agendamento_tutoria_personalizada FOREIGN KEY (
    tutoria_personalizada_curso,
    tutoria_personalizada_nome
  ) REFERENCES tutoria_personalizada(recurso_pago_curso, recurso_pago_nome)
);

/*AlunoAcessoRecursoPago = { aluno, recurso_pago_curso, recurso_pago_nome }*/
CREATE TABLE aluno_acesso_recurso_pago (
  aluno CHAR(14),
  recurso_pago_curso CHAR(10),
  recurso_pago_nome VARCHAR(50),
  CONSTRAINT pk_aluno_acesso_recurso_pago PRIMARY KEY (aluno, recurso_pago_curso, recurso_pago_nome),
  CONSTRAINT fk_aluno_acesso_recurso_pago_aluno FOREIGN KEY (aluno) REFERENCES aluno(usuario),
  CONSTRAINT fk_aluno_acesso_recurso_pago_recurso_pago FOREIGN KEY (recurso_pago_curso, recurso_pago_nome) REFERENCES recurso_pago(recurso_curso, recurso_nome)
);

/*AdministraRecurso = { recurso_curso, recurso_nome, especialista }*/
CREATE TABLE administra_recurso (
  recurso_curso CHAR(10),
  recurso_nome VARCHAR(50),
  especialista CHAR(14),
  CONSTRAINT pk_administra_recurso PRIMARY KEY (recurso_curso, recurso_nome, especialista),
  CONSTRAINT fk_administra_recurso_recurso FOREIGN KEY (recurso_curso, recurso_nome) REFERENCES recurso(curso, nome),
  CONSTRAINT fk_administra_recurso_especialista FOREIGN KEY (especialista) REFERENCES especialista(tutor)
);

/*AlunoCursa = { aluno, curso, avaliação, nota, data_hora* }*/
CREATE TABLE aluno_cursa (
  aluno CHAR(14),
  curso char(10),
  avaliacao INTEGER,
  nota INTEGER,
  data_hora TIMESTAMP NOT NULL,
  CONSTRAINT pk_aluno_cursa PRIMARY KEY (aluno, curso),
  CONSTRAINT fk_aluno_cursa_aluno FOREIGN KEY (aluno) REFERENCES aluno(usuario),
  CONSTRAINT fk_aluno_cursa_curso FOREIGN KEY (curso) REFERENCES curso(codigo)
);

/*Tutoria = { curso, voluntário }*/
CREATE TABLE tutoria (
  curso CHAR(10),
  voluntario CHAR(14),
  CONSTRAINT pk_tutoria PRIMARY KEY (curso, voluntario),
  CONSTRAINT fk_tutoria_curso FOREIGN KEY (curso) REFERENCES curso(codigo),
  CONSTRAINT fk_tutoria_voluntario FOREIGN KEY (voluntario) REFERENCES voluntario(tutor)
);