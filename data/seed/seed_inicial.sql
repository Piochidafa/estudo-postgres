CREATE TABLE pessoa (
    pes_id SERIAL PRIMARY KEY,
    pes_nome VARCHAR(200),
    pes_data_nascimento DATE,
    pes_sexo VARCHAR(9),
    pes_mae VARCHAR(200),
    pes_pai VARCHAR(200)
);

CREATE TABLE foto_pessoa (
    fp_id SERIAL PRIMARY KEY,
    pes_id INT NOT NULL,
    tp_data DATE,
    tp_bucket VARCHAR(200),
    tp_hash VARCHAR(20),
    CONSTRAINT fk_foto_pessoa FOREIGN KEY (pes_id) REFERENCES pessoa(pes_id)
);

CREATE TABLE cidade (
    cid_id SERIAL PRIMARY KEY,
    cid_nome VARCHAR(200),
    cid_uf CHAR(2)
);

CREATE TABLE endereco (
    end_id SERIAL PRIMARY KEY,
    end_tipo_logradouro VARCHAR(30),
    end_logradouro VARCHAR(200),
    end_numero INT,
    end_bairro VARCHAR(100),
    cid_id INT,
    CONSTRAINT fk_endereco_cidade FOREIGN KEY (cid_id) REFERENCES cidade(cid_id)
);

CREATE TABLE pessoa_endereco (
    pes_id INT NOT NULL,
    end_id INT NOT NULL,
    PRIMARY KEY (pes_id, end_id),
    CONSTRAINT fk_pessoa_endereco_pessoa FOREIGN KEY (pes_id) REFERENCES pessoa(pes_id),
    CONSTRAINT fk_pessoa_endereco_endereco FOREIGN KEY (end_id) REFERENCES endereco(end_id)
);

CREATE TABLE servidor_temporario (
    pes_id INT PRIMARY KEY,
    st_data_admissao DATE NOT NULL,
    st_data_demissao DATE,
    CONSTRAINT fk_servidor_temporario FOREIGN KEY (pes_id) REFERENCES pessoa(pes_id)
);

CREATE TABLE servidor_efetivo (
    pes_id INT PRIMARY KEY,
    se_matricula VARCHAR(20) UNIQUE NOT NULL,
    CONSTRAINT fk_servidor_efetivo FOREIGN KEY (pes_id) REFERENCES pessoa(pes_id)
);

CREATE TABLE unidade (
    unid_id SERIAL PRIMARY KEY,
    unid_nome VARCHAR(200),
    unid_sigla VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE lotacao (
    lot_id SERIAL PRIMARY KEY,
    pes_id INT NOT NULL,
    unid_id INT NOT NULL,
    lot_data_lotacao DATE NOT NULL,
    lot_data_remocao DATE,
    lot_portaria VARCHAR(100),
    CONSTRAINT fk_lotacao_pessoa FOREIGN KEY (pes_id) REFERENCES pessoa(pes_id),
    CONSTRAINT fk_lotacao_unidade FOREIGN KEY (unid_id) REFERENCES unidade(unid_id)
);

CREATE TABLE unidade_endereco (
    unid_id INT NOT NULL,
    end_id INT NOT NULL,
    PRIMARY KEY (unid_id, end_id),
    CONSTRAINT fk_unidade_endereco_unidade FOREIGN KEY (unid_id) REFERENCES unidade(unid_id),
    CONSTRAINT fk_unidade_endereco_endereco FOREIGN KEY (end_id) REFERENCES endereco(end_id)
);
