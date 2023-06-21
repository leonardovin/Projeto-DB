/*
 Usuário = { CPF, nome*, email*, senha*, tipo*, data_nasc*, endereço*, telefone*, idioma1*, idioma2, url_foto_perfil,
 cartão_cred_nro, cartão_cred_validade, cartão_cred_cvv, cartão_cred_cpf, cartão_cred_titular,
 status*, data_último_acesso, data_última_edição }
 */
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
  cartao_cred_cvv VARCHAR(3),
  cartao_cred_cpf VARCHAR(11),
  cartao_cred_titular VARCHAR(255),
  status VARCHAR(255) NOT NULL,
  data_ultimo_acesso TIMESTAMP,
  data_ultima_edicao TIMESTAMP
);

/*Aluno = { usuário, assinante* }*/
CREATE TABLE aluno (
  usuario VARCHAR(11) PRIMARY KEY REFERENCES usuario(cpf),
  assinante BOOLEAN NOT NULL
);

/*Interesse = { aluno, interesse }*/
CREATE TABLE interesse (
  aluno VARCHAR(11) REFERENCES aluno(usuario),
  interesse VARCHAR(255) NOT NULL,
  PRIMARY KEY (aluno, interesse)
);

/*Administrador = { usuário, nível_acesso* }*/
CREATE TABLE administrador (
  usuario VARCHAR(11) PRIMARY KEY REFERENCES usuario(cpf),
  nivel_acesso INTEGER NOT NULL
);

/*AdministradorAtividade = { administrador, log*,  data_hora* }*/
CREATE TABLE administrador_atividade (
  administrador VARCHAR(11) REFERENCES administrador(usuario),
  log TEXT,
  data_hora TIMESTAMP NOT NULL,
  PRIMARY KEY (administrador, data_hora)
);

/*Tutor = { usuário, tipo*, cadastrado_por* }*/
CREATE TABLE tutor (
  usuario VARCHAR(11) PRIMARY KEY REFERENCES usuario(cpf),
  tipo VARCHAR(255) NOT NULL,
  cadastrado_por VARCHAR(11) REFERENCES administrador(usuario)
);

/*TutorHabilidade = { tutor, habilidade }*/
CREATE TABLE tutor_habilidade (
  tutor VARCHAR(11) REFERENCES tutor(usuario),
  habilidade VARCHAR(255) NOT NULL,
  PRIMARY KEY (tutor, habilidade)
);

/*TutorAvaliação = { tutor, aluno, avaliação*, data_hora* }*/
CREATE TABLE tutor_avaliacao (
  tutor VARCHAR(11) REFERENCES tutor(usuario),
  aluno VARCHAR(11) REFERENCES aluno(usuario),
  avaliacao INTEGER NOT NULL,
  data_hora TIMESTAMP NOT NULL,
  PRIMARY KEY (tutor, aluno, data_hora)
);

/*Voluntário = { tutor, motivação }*/
CREATE TABLE voluntario (
  tutor VARCHAR(11) REFERENCES tutor(usuario),
  motivacao TEXT,
  PRIMARY KEY (tutor)
);

/*Especialista = { tutor, taxa*, currículo_acadêmico*, conta_nro_banco*, conta_agência*, conta_nro* }*/
CREATE TABLE especialista (
  tutor VARCHAR(11) PRIMARY KEY REFERENCES tutor(usuario),
  taxa DECIMAL(10, 2) NOT NULL,
  curriculo_academico TEXT,
  conta_nro_banco VARCHAR(20),
  conta_agencia VARCHAR(20),
  conta_nro VARCHAR(20)
);

/*AtividadePrática = { recurso_pago_curso, recurso_pago_nome, duração, assunto*  }*/
CREATE TABLE atividade_pratica_resposta (
  aluno VARCHAR(11) REFERENCES aluno(usuario),
  questao INTEGER NOT NULL,
  alternativa VARCHAR(1),
  PRIMARY KEY (aluno, questao)
);

/**/
CREATE TABLE mensagem (
  aluno1 VARCHAR(11) REFERENCES aluno(usuario),
  aluno2 VARCHAR(11) REFERENCES aluno(usuario),
  data_hora TIMESTAMP NOT NULL,
  conteudo TEXT,
  PRIMARY KEY (aluno1, aluno2, data_hora)
);

/*Curso = { código, título*, categoria*, descrição*, nível_dificuldade*, média_aval, criado_por* }*/
CREATE TABLE curso (
  codigo VARCHAR(255) PRIMARY KEY,
  titulo VARCHAR(255) NOT NULL,
  categoria VARCHAR(255),
  descricao TEXT,
  nivel_dificuldade INTEGER,
  media_aval DECIMAL(2, 1),
  criado_por VARCHAR(11) REFERENCES administrador(usuario)
);

/*Recurso = { curso, nome, descrição, tipo* }*/
CREATE TABLE recurso (
  curso VARCHAR(255),
  nome VARCHAR(255),
  descricao TEXT,
  tipo VARCHAR(255) NOT null,
  primary KEY (curso, nome),
  foreign key (curso) references curso(codigo)
);

/*RecursoPago = { recurso_curso, recurso_nome, preço_único*, tipo* }*/
CREATE TABLE recurso_pago (
  recurso_curso VARCHAR(255),
  recurso_nome VARCHAR(255),
  preco_unico DECIMAL(10, 2) NOT NULL,
  tipo VARCHAR(255) NOT NULL,
  PRIMARY KEY (recurso_curso, recurso_nome),
  foreign key (recurso_curso, recurso_nome) references recurso(curso, nome)
);

/*Vídeotutorial = { recurso_curso, recurso_nome, duração* }*/
CREATE TABLE videotutorial (
  recurso_curso VARCHAR(255),
  recurso_nome VARCHAR(255),
  duracao INTERVAL NOT NULL,
  PRIMARY KEY (recurso_curso, recurso_nome),
  foreign key (recurso_curso, recurso_nome) REFERENCES recurso(curso, nome)
);

/*Guia = { recurso_curso, recurso_nome, formato* }*/
CREATE TABLE guia (
  recurso_curso VARCHAR(255),
  recurso_nome VARCHAR(255),
  formato VARCHAR(255) NOT NULL,
  PRIMARY KEY (recurso_curso, recurso_nome),
  foreign key (recurso_curso, recurso_nome) REFERENCES recurso(curso, nome)
);

/*AtividadePrática = { recurso_pago_curso, recurso_pago_nome, duração, assunto*  }*/
CREATE TABLE atividade_pratica (
  recurso_pago_curso VARCHAR(255),
  recurso_pago_nome VARCHAR(255),
  duracao INTERVAL,
  assunto VARCHAR(255) NOT NULL,
  PRIMARY KEY (recurso_pago_curso, recurso_pago_nome),
  foreign key (recurso_pago_curso, recurso_pago_nome) references recurso_pago(recurso_curso, recurso_nome)
);

/*Questão = { id, atividade_prática_curso, atividade_prática_nome, nro, pergunta*, alt1*, alt2*, alt3, alt4, alt_correta* }*/
CREATE TABLE questao (
  id SERIAL PRIMARY KEY,
  atividade_pratica_curso VARCHAR(255),
  atividade_pratica_nome VARCHAR(255),
  nro INTEGER NOT NULL,
  pergunta TEXT NOT NULL,
  alt1 TEXT NOT NULL,
  alt2 TEXT NOT NULL,
  alt3 TEXT,
  alt4 TEXT,
  alt_correta VARCHAR(1) NOT null,
  foreign key (atividade_pratica_curso, atividade_pratica_nome) references atividade_pratica(recurso_pago_curso, recurso_pago_nome)
);

/*TutoriaPersonalizada = { recurso_pago_curso, recurso_pago_nome, assunto* }*/
CREATE TABLE tutoria_personalizada (
  recurso_pago_curso VARCHAR(255),
  recurso_pago_nome VARCHAR(255),
  assunto VARCHAR(255) NOT NULL,
  PRIMARY KEY (recurso_pago_curso, recurso_pago_nome),
  foreign key (recurso_pago_curso, recurso_pago_nome) references recurso_pago(recurso_curso, recurso_nome)
);

/*Agendamento = { aluno, especialista, data_hora, tutoria_personalizada_curso*, tutoria_personalizada_nome* }*/
CREATE TABLE agendamento (
  aluno VARCHAR(11),
  especialista VARCHAR(11),
  data_hora TIMESTAMP NOT NULL,
  tutoria_personalizada_curso VARCHAR(255),
  tutoria_personalizada_nome VARCHAR(255),
  PRIMARY KEY (aluno, especialista, data_hora),
  FOREIGN KEY (aluno) REFERENCES aluno(usuario),
  FOREIGN KEY (especialista) REFERENCES especialista(tutor),
  FOREIGN KEY (
    tutoria_personalizada_curso,
    tutoria_personalizada_nome
  ) REFERENCES tutoria_personalizada(recurso_pago_curso, recurso_pago_nome)
);

/*AlunoAcessoRecursoPago = { aluno, recurso_pago_curso, recurso_pago_nome }*/
CREATE TABLE aluno_acesso_recurso_pago (
  aluno VARCHAR(11),
  recurso_pago_curso VARCHAR(255),
  recurso_pago_nome VARCHAR(255),
  PRIMARY KEY (aluno, recurso_pago_curso, recurso_pago_nome),
  FOREIGN KEY (aluno) REFERENCES aluno(usuario),
  FOREIGN KEY (recurso_pago_curso, recurso_pago_nome) REFERENCES recurso_pago(recurso_curso, recurso_nome)
);

/*AdministraRecurso = { recurso_curso, recurso_nome, especialista }*/
CREATE TABLE administra_recurso (
  recurso_curso VARCHAR(255),
  recurso_nome VARCHAR(255),
  especialista VARCHAR(11),
  PRIMARY KEY (recurso_curso, recurso_nome, especialista),
  FOREIGN KEY (recurso_curso, recurso_nome) REFERENCES recurso(curso, nome),
  FOREIGN KEY (especialista) REFERENCES especialista(tutor)
);

/*AlunoCursa = { aluno, curso, avaliação, nota, data_hora* }*/
CREATE TABLE aluno_cursa (
  aluno VARCHAR(11),
  curso VARCHAR(255),
  avaliacao INTEGER,
  nota INTEGER,
  data_hora TIMESTAMP NOT NULL,
  PRIMARY KEY (aluno, curso),
  FOREIGN KEY (aluno) REFERENCES aluno(usuario),
  FOREIGN KEY (curso) REFERENCES curso(codigo)
);

/*Tutoria = { curso, voluntário }*/
CREATE TABLE tutoria (
  curso VARCHAR(255),
  voluntario VARCHAR(11),
  PRIMARY KEY (curso, voluntario),
  FOREIGN KEY (curso) REFERENCES curso(codigo),
  FOREIGN KEY (voluntario) REFERENCES voluntario(tutor)
);