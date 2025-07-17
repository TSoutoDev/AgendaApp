CREATE TABLE Modulo (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,
    Descricao VARCHAR(255)
);

CREATE TABLE Funcionalidade (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    NomeTabela VARCHAR(100) NOT NULL,
    Descricao VARCHAR(255),
    ModuloId INT NOT NULL,
    CONSTRAINT FK_Funcionalidade_Modulo FOREIGN KEY (ModuloId) REFERENCES Modulo(Id)
);

CREATE TABLE Operacao (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Nome VARCHAR(100) NOT NULL,            -- Ex: 'Visualizar', 'Editar'
    Descricao VARCHAR(255),
    FuncionalidadeId INT NOT NULL,
    CONSTRAINT FK_Operacao_Funcionalidade FOREIGN KEY (FuncionalidadeId) REFERENCES Funcionalidade(Id)
);

INSERT INTO Modulo (Nome, Descricao)
VALUES
    ('Basic', 'M�dulo b�sico com funcionalidades essenciais para iniciar.'),
    ('Essential', 'M�dulo intermedi�rio com recursos importantes para uso comum.'),
    ('Expert', 'M�dulo avan�ado com funcionalidades completas e avan�adas.');

	INSERT INTO Funcionalidade (NomeTabela, Descricao, ModuloId)
VALUES
-- Basic
('Agendamento', 'Gerenciamento de tarefas, compromissos ou eventos.', 1),
('Dashboard', 'Vis�o geral com informa��es resumidas do sistema.', 1),
('Usuarios', 'Cadastro e gerenciamento b�sico de usu�rios.', 1),
('Categoria', 'Gest�o de categorias ou classifica��es.', 1),

-- Essential
('Relatorios', 'Emiss�o de relat�rios para an�lise de dados.', 2),
('Integracoes', 'Integra��o com sistemas externos ou APIs.', 2),
('Documento', 'Organiza��o e controle de documentos do sistema.', 2),
('AuditoriaSimples', 'Registro b�sico de a��es realizadas no sistema.', 2),

-- Expert
('ControleAcesso', 'Gerenciamento de permiss�es avan�adas.', 3),
('AuditoriaCompleta', 'Rastreamento detalhado de atividades no sistema.', 3),
('Indicadores', 'Visualiza��o de KPIs e gr�ficos de performance.', 3),
('Automacoes', 'Automatiza��o de fluxos e processos.', 3);


-- Inserir opera��es padr�o (Acessar, Incluir, Editar, Excluir) para cada funcionalidade

DECLARE @FuncionalidadeId INT;

DECLARE cur CURSOR FOR
    SELECT Id FROM Funcionalidade;

OPEN cur;
FETCH NEXT FROM cur INTO @FuncionalidadeId;

WHILE @@FETCH_STATUS = 0
BEGIN
    INSERT INTO Operacao (Nome, Descricao, FuncionalidadeId)
    VALUES 
        ('Acessar', 'Permite acessar a funcionalidade.', @FuncionalidadeId),
        ('Incluir', 'Permite incluir novos registros.', @FuncionalidadeId),
        ('Editar', 'Permite editar registros existentes.', @FuncionalidadeId),
        ('Excluir', 'Permite excluir registros.', @FuncionalidadeId);

    FETCH NEXT FROM cur INTO @FuncionalidadeId;
END;

CLOSE cur;
DEALLOCATE cur;
