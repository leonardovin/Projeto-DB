CREATE TABLE usuario (
  cpf VARCHAR(11) PRIMARY KEY,
  nome VARCHAR(255) NOT NULL,
  email VARCHAR(255) NOT NULL,
  senha VARCHAR(255) NOT NULL,
  tipo VARCHAR(255) NOT NULL,
  data_nasc DATE NOT NULL,
  endereco VARCHAR(255) NOT NULL,
  telefone VARCHAR(20) NOT NULL,
  idioma1 VARCHAR(255) NOT NULL,
  idioma2 VARCHAR(255),
  url_foto_perfil VARCHAR(255),
  cartao_cred_nro VARCHAR(16),
  cartao_cred_validade VARCHAR(7),
  cartao_cred_cvv VARCHAR(4),
  cartao_cred_cpf VARCHAR(11),
  cartao_cred_titular VARCHAR(255),
  status VARCHAR(255) NOT NULL,
  data_ultimo_acesso TIMESTAMP,
  data_ultima_edicao TIMESTAMP
);

CREATE TABLE aluno (
  usuario VARCHAR(11) PRIMARY KEY REFERENCES usuario(cpf),
  assinante BOOLEAN NOT NULL
);

CREATE TABLE interesse (
  aluno VARCHAR(11) REFERENCES aluno(usuario),
  interesse VARCHAR(255) NOT NULL,
  PRIMARY KEY (aluno, interesse)
);

CREATE TABLE administrador (
  usuario VARCHAR(11) PRIMARY KEY REFERENCES usuario(cpf),
  nivel_acesso INTEGER NOT NULL
);

CREATE TABLE administrador_atividade (
  administrador VARCHAR(11) REFERENCES administrador(usuario),
  log TEXT,
  data_hora TIMESTAMP NOT NULL,
  PRIMARY KEY (administrador, data_hora)
);

CREATE TABLE tutor (
  usuario VARCHAR(11) PRIMARY KEY REFERENCES usuario(cpf),
  tipo VARCHAR(255) NOT NULL,
  cadastrado_por VARCHAR(11) REFERENCES administrador(usuario)
);

CREATE TABLE tutor_habilidade (
  tutor VARCHAR(11) REFERENCES tutor(usuario),
  habilidade VARCHAR(255) NOT NULL,
  PRIMARY KEY (tutor, habilidade)
);

CREATE TABLE tutor_avaliacao (
  tutor VARCHAR(11) REFERENCES tutor(usuario),
  aluno VARCHAR(11) REFERENCES aluno(usuario),
  avaliacao INTEGER NOT NULL,
  data_hora TIMESTAMP NOT NULL,
  PRIMARY KEY (tutor, aluno, data_hora)
);

CREATE TABLE voluntario (
  tutor VARCHAR(11) REFERENCES tutor(usuario),
  motivacao TEXT,
  PRIMARY KEY (tutor)
);

CREATE TABLE especialista (
  tutor VARCHAR(11) PRIMARY KEY REFERENCES tutor(usuario),
  taxa DECIMAL(10,2) NOT NULL,
  curriculo_academico TEXT,
  conta_nro_banco VARCHAR(20),
  conta_agencia VARCHAR(20),
  conta_nro VARCHAR(20)
);

CREATE TABLE atividade_pratica_resposta (
  aluno VARCHAR(11) REFERENCES aluno(usuario),
  questao INTEGER NOT NULL,
  alternativa VARCHAR(1),
  PRIMARY KEY (aluno, questao)
);

CREATE TABLE mensagem (
  aluno1 VARCHAR(11) REFERENCES aluno(usuario),
  aluno2 VARCHAR(11) REFERENCES aluno(usuario),
  data_hora TIMESTAMP NOT NULL,
  conteudo TEXT,
  PRIMARY KEY (aluno1, aluno2, data_hora)
);

CREATE TABLE curso (
  codigo VARCHAR(255) PRIMARY KEY,
  titulo VARCHAR(255) NOT NULL,
  categoria VARCHAR(255),
  descricao TEXT,
  nivel_dificuldade INTEGER,
  media_aval DECIMAL(2,1),
  criado_por VARCHAR(11) REFERENCES administrador(usuario)
);

CREATE TABLE recurso (
  curso VARCHAR(255) PRIMARY KEY REFERENCES curso(codigo),
  nome VARCHAR(255),
  descricao TEXT,
  tipo VARCHAR(255) NOT NULL
);

CREATE TABLE recurso_pago (
  recurso_curso VARCHAR(255),
  recurso_nome VARCHAR(255),
  preco_unico DECIMAL(10,2) NOT NULL,
  tipo VARCHAR(255) NOT NULL,
  PRIMARY KEY (recurso_curso),
  FOREIGN KEY (recurso_curso) REFERENCES recurso(curso)
);

CREATE TABLE videotutorial (
  recurso_curso VARCHAR(255) REFERENCES recurso_pago(recurso_curso),
  recurso_nome VARCHAR(255),
  duracao INTERVAL NOT NULL,
  PRIMARY KEY (recurso_curso)
);

CREATE TABLE guia (
  recurso_curso VARCHAR(255) REFERENCES recurso_pago(recurso_curso),
  recurso_nome VARCHAR(255),
  formato VARCHAR(255) NOT NULL,
  PRIMARY KEY (recurso_curso)
);

CREATE TABLE atividade_pratica (
  recurso_pago_curso VARCHAR(255) REFERENCES recurso_pago(recurso_curso),
  recurso_pago_nome VARCHAR(255),
  duracao INTERVAL,
  assunto VARCHAR(255) NOT NULL,
  PRIMARY KEY (recurso_pago_curso)
);

CREATE TABLE questao (
  id SERIAL PRIMARY KEY,
  atividade_pratica_curso VARCHAR(255) REFERENCES atividade_pratica(recurso_pago_curso),
  atividade_pratica_nome VARCHAR(255),
  nro INTEGER NOT NULL,
  pergunta TEXT NOT NULL,
  alt1 TEXT NOT NULL,
  alt2 TEXT NOT NULL,
  alt3 TEXT,
  alt4 TEXT,
  alt_correta VARCHAR(1) NOT NULL
);

CREATE TABLE tutoria_personalizada (
  recurso_pago_curso VARCHAR(255) REFERENCES recurso_pago(recurso_curso),
  recurso_pago_nome VARCHAR(255),
  assunto VARCHAR(255) NOT NULL,
  PRIMARY KEY (recurso_pago_curso)
);


CREATE TABLE agendamento (
  aluno VARCHAR(11) REFERENCES aluno(usuario),
  especialista VARCHAR(11),
  data_hora TIMESTAMP NOT NULL,
  tutoria_personalizada_curso VARCHAR(255),
  tutoria_personalizada_nome VARCHAR(255),
  FOREIGN KEY (especialista) REFERENCES especialista(tutor),
  FOREIGN KEY (tutoria_personalizada_curso, tutoria_personalizada_nome) REFERENCES tutoria_personalizada(recurso_pago_curso, recurso_pago_nome),
  PRIMARY KEY (aluno, especialista, data_hora)
);



CREATE TABLE aluno_acesso_recurso_pago (
  aluno VARCHAR(11) REFERENCES aluno(usuario),
  recurso_pago_curso VARCHAR(255) REFERENCES recurso_pago(recurso_curso),
  recurso_pago_nome VARCHAR(255),
  PRIMARY KEY (aluno, recurso_pago_curso)
);

CREATE TABLE administra_recurso (
  recurso_curso VARCHAR(255) REFERENCES recurso(curso),
  recurso_nome VARCHAR(255),
  especialista VARCHAR(11) REFERENCES especialista(tutor),
  PRIMARY KEY (recurso_curso)
);

CREATE TABLE aluno_cursa (
  aluno VARCHAR(11) REFERENCES aluno(usuario),
  curso VARCHAR(255) REFERENCES curso(codigo),
  avaliacao INTEGER,
  nota INTEGER,
  data_hora TIMESTAMP NOT NULL,
  PRIMARY KEY (aluno, curso)
);

CREATE TABLE tutoria (
  curso VARCHAR(255) REFERENCES curso(codigo),
  voluntario VARCHAR(11) REFERENCES tutor(usuario),
  PRIMARY KEY (curso, voluntario)
);
