\c projeto_db

CREATE TABLE Usuario (
  CPF VARCHAR(11) PRIMARY KEY,
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

CREATE TABLE Aluno (
  usuario VARCHAR(11) PRIMARY KEY REFERENCES Usuario(CPF),
  assinante BOOLEAN NOT NULL
);

CREATE TABLE Interesse (
  aluno VARCHAR(11) REFERENCES Aluno(usuario),
  interesse VARCHAR(255) NOT NULL
);

CREATE TABLE Administrador (
  usuario VARCHAR(11) PRIMARY KEY REFERENCES Usuario(CPF),
  nivel_acesso INTEGER NOT NULL
);

CREATE TABLE AdministradorAtividade (
  administrador VARCHAR(11) REFERENCES Administrador(usuario),
  log TEXT,
  data_hora TIMESTAMP NOT NULL
);

CREATE TABLE Tutor (
  usuario VARCHAR(11) PRIMARY KEY REFERENCES Usuario(CPF),
  tipo VARCHAR(255) NOT NULL,
  cadastrado_por VARCHAR(11) REFERENCES Administrador(usuario)
);

CREATE TABLE TutorHabilidade (
  tutor VARCHAR(11) REFERENCES Tutor(usuario),
  habilidade VARCHAR(255) NOT NULL
);

CREATE TABLE TutorAvaliacao (
  tutor VARCHAR(11) REFERENCES Tutor(usuario),
  aluno VARCHAR(11) REFERENCES Aluno(usuario),
  avaliacao INTEGER NOT NULL,
  data_hora TIMESTAMP NOT NULL
);

CREATE TABLE Voluntario (
  tutor VARCHAR(11) REFERENCES Tutor(usuario),
  motivacao TEXT
);

CREATE TABLE Especialista (
  tutor VARCHAR(11) REFERENCES Tutor(usuario),
  taxa DECIMAL(10,2) NOT NULL,
  curriculo_academico TEXT,
  conta_nro_banco VARCHAR(20),
  conta_agencia VARCHAR(20),
  conta_nro VARCHAR(20)
);

CREATE TABLE AtividadePraticaResposta (
  aluno VARCHAR(11) REFERENCES Aluno(usuario),
  questao INTEGER NOT NULL,
  alternativa VARCHAR(1)
);

CREATE TABLE Mensagem (
  aluno1 VARCHAR(11) REFERENCES Aluno(usuario),
  aluno2 VARCHAR(11) REFERENCES Aluno(usuario),
  data_hora TIMESTAMP NOT NULL,
  conteudo TEXT
);

CREATE TABLE Videotutorial (
  recurso_curso VARCHAR(255) REFERENCES RecursoPago(recurso_curso),
  recurso_nome VARCHAR(255),
  duracao INTERVAL NOT NULL
);

CREATE TABLE Guia (
  recurso_curso VARCHAR(255) REFERENCES RecursoPago(recurso_curso),
  recurso_nome VARCHAR(255),
  formato VARCHAR(255) NOT NULL
);

CREATE TABLE Questao (
  id SERIAL PRIMARY KEY,
  atividade_pratica_curso VARCHAR(255) REFERENCES AtividadePratica(recurso_pago_curso),
  atividade_pratica_nome VARCHAR(255),
  nro INTEGER NOT NULL,
  pergunta TEXT NOT NULL,
  alt1 TEXT NOT NULL,
  alt2 TEXT NOT NULL,
  alt3 TEXT,
  alt4 TEXT,
  alt_correta VARCHAR(1) NOT NULL
);

CREATE TABLE AtividadePratica (
  recurso_pago_curso VARCHAR(255) REFERENCES RecursoPago(recurso_curso),
  recurso_pago_nome VARCHAR(255),
  duracao INTERVAL,
  assunto VARCHAR(255) NOT NULL
);

CREATE TABLE Agendamento (
  aluno VARCHAR(11) REFERENCES Aluno(usuario),
  especialista VARCHAR(11) REFERENCES Especialista(tutor),
  data_hora TIMESTAMP NOT NULL,
  tutoria_personalizada_curso VARCHAR(255) REFERENCES TutoriaPersonalizada(recurso_pago_curso),
  tutoria_personalizada_nome VARCHAR(255)
);

CREATE TABLE TutoriaPersonalizada (
  recurso_pago_curso VARCHAR(255) REFERENCES RecursoPago(recurso_curso),
  recurso_pago_nome VARCHAR(255),
  assunto VARCHAR(255) NOT NULL
);

CREATE TABLE AlunoAcessoRecursoPago (
  aluno VARCHAR(11) REFERENCES Aluno(usuario),
  recurso_pago_curso VARCHAR(255) REFERENCES RecursoPago(recurso_curso),
  recurso_pago_nome VARCHAR(255)
);

CREATE TABLE RecursoPago (
  recurso_curso VARCHAR(255) REFERENCES Recurso(curso),
  recurso_nome VARCHAR(255),
  preco_unico DECIMAL(10,2) NOT NULL,
  tipo VARCHAR(255) NOT NULL
);

CREATE TABLE AdministraRecurso (
  recurso_curso VARCHAR(255) REFERENCES Recurso(curso),
  recurso_nome VARCHAR(255),
  especialista VARCHAR(11) REFERENCES Especialista(tutor)
);

CREATE TABLE Recurso (
  curso VARCHAR(255) REFERENCES Curso(codigo),
  nome VARCHAR(255),
  descricao TEXT,
  tipo VARCHAR(255) NOT NULL
);

CREATE TABLE AlunoCursa (
  aluno VARCHAR(11) REFERENCES Aluno(usuario),
  curso VARCHAR(255) REFERENCES Curso(codigo),
  avaliacao INTEGER,
  nota INTEGER,
  data_hora TIMESTAMP NOT NULL
);

CREATE TABLE Tutoria (
  curso VARCHAR(255) REFERENCES Curso(codigo),
  voluntario VARCHAR(11) REFERENCES Tutor(usuario)
);

CREATE TABLE Curso (
  codigo VARCHAR(255) PRIMARY KEY,
  titulo VARCHAR(255) NOT NULL,
  categoria VARCHAR(255),
  descricao TEXT,
  nivel_dificuldade INTEGER,
  media_aval DECIMAL(2,1),
  criado_por VARCHAR(11) REFERENCES Administrador(usuario)
);
