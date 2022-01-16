--club(id PK,nombre,ciudad,nJugadores,nExtranjeros,ValorTotal)
--Jugadores(id PK, nombre, id_club FK, posicion, peso, Altura, Nacionalidad,edad, valor)
--partidos(id PK, id_local FK, id_visitante FK,gol_local,gol_visitante,id_arbitro FK,aforo, jornada, temporada FK)
--temporadas(id PK,fecha_inicio,fecha_final)
--Estadisticas_partido(id PK, id_jugador FK, id_partido FK,goles, amarillas, roja, titularidad)
--EstadisticasTotales(id_jugador PK FK, goles, amarillas, rojas, partidos_titular)
--arbitros(id PK, nombre, nacionalidad, edad)
--clasificacion (id_equipo PK FK, puntos, goles)
--ClasificacionTemporadas(id PK, id_club FK, puntos, golesAfavor,golesEncontra, temporada FK)
--estadios(nombre, id_equipo PK FK,capacidad)

--Modificaciones:
--Historicos
--HistoricoClub(id PK, id_club FK, nJugadores,nExtranjeros,ValorTotal,fechaModificacion)
--HistoricoJugadores(id PK, id_jugador FK, id_club,valor,fechaModificacion)

--Para servidor SQL

 --INTEGER NOT NULL IDENTITY(1, 1) PRIMARY KEY


CREATE TABLE [club] (
  [id] int NOT NULL IDENTITY(1, 1) PRIMARY KEY,
  [nombre] varchar(100),
  [ciudad] varchar(100),
  [nJugadores] int,
  [nExtranjeros] int,
  [ValorTotal] varchar(100)
);
CREATE TABLE [estadios] (
    [nombre] VARCHAR(255) NULL,
    [id_club] INTEGER PRIMARY KEY,
    [capacidad] INTEGER NULL
);
GO
    ALTER TABLE ESTADIOS  ADD CONSTRAINT [FK_estadios.id_club]
    FOREIGN KEY ([id_club])
    REFERENCES [club]([id])

CREATE TABLE [arbitros] (
  [id] int NOT NULL IDENTITY(1, 1) PRIMARY KEY,
  [nombre] varchar(100),
  [nacionalidad] varchar(100),
  [edad] int
);


CREATE TABLE [jugadores] (
  [id] int NOT NULL IDENTITY(1, 1) PRIMARY KEY,
  [nombre] varchar(100),
  [id_club] int,
  [posicion] varchar(100),
  [peso] varchar(100),
  [altura] varchar(100),
  [nacionalidad] varchar(100),
  [edad] int,
  [valor] varchar(100),
  CONSTRAINT [FK_jugadores.id_club]
    FOREIGN KEY ([id_club])
      REFERENCES [club]([id])
);
CREATE TABLE Temporada (
  id int PRIMARY KEY NOT NULL,
  Fecha_inicio datetime,
  Fecha_final datetime
);


CREATE TABLE [partidos] (
   [id] int NOT NULL IDENTITY(1, 1) PRIMARY KEY,
  [id_local] int,
  [id_visitante] int,
  [goles_local] int,
  [goles_visitante] int,
  [id_arbitro] int,
  [aforo] varchar(10),
  [jornada] int,
  [temporada] int,
  CONSTRAINT [FK_partidos.id_arbitro]
    FOREIGN KEY ([id_arbitro])
      REFERENCES [arbitros]([id]),
  CONSTRAINT [FK_partidos.ID_LOCAL]
    FOREIGN KEY ([id_local])
      REFERENCES [club]([id]),
  CONSTRAINT [FK_partidos.id_visitante]
    FOREIGN KEY ([id_visitante])
      REFERENCES [club]([id]),
  CONSTRAINT [FK_partidos.temporada]
      FOREIGN KEY (temporada) 
      REFERENCES Temporada(id)

);

CREATE TABLE [estadisticasPartido] (
  [id] int NOT NULL IDENTITY(1, 1) PRIMARY KEY,
  [id_jugador] int,
  [id_partido] int,
  [goles] int,
  [amarillas] int,
  [roja] int,
  [titularidad] varchar(100),
  CONSTRAINT [FK_estadisticasPartido.id_jugador]
    FOREIGN KEY ([id_jugador])
      REFERENCES [jugadores]([id]),
  CONSTRAINT [FK_estadisticasPartido.id_partido]
    FOREIGN KEY ([id_partido])
      REFERENCES [partidos]([id])
);

CREATE TABLE [estadisticasTotales] (
  [id_jugador] int NOT NULL PRIMARY KEY,
  [goles] int,
  [amarillas] int,
  [rojas] int,
  [Partidos_titular] int,
  CONSTRAINT [FK_estadisticasTotales.id_jugador]
    FOREIGN KEY ([id_jugador])
      REFERENCES [jugadores]([id])
);

CREATE TABLE [clasificacion] (
  [id_club] int NOT NULL PRIMARY KEY,
  [puntos] int,
  [golesAfavor] int,
  [golesEncontra] int,
  CONSTRAINT [FK_clasificacion.id_club]
    FOREIGN KEY ([id_club])
      REFERENCES [club]([id])
);
CREATE TABLE [clasificacionTemporada] (
  [id] int NOT NULL IDENTITY(1, 1) PRIMARY KEY,
  [id_club] int NOT NULL,
  [puntos] int,
  [golesAfavor] int,
  [golesEncontra] int,
  [temporada] int,
  CONSTRAINT [FK_clasificacionTemporada.id_club]
    FOREIGN KEY ([id_club])
      REFERENCES [club]([id]),
    CONSTRAINT [FK_clasificacionTemporada.temporada]
      FOREIGN KEY (temporada) 
      REFERENCES Temporada(id)
);
CREATE TABLE [estadisticasTotales] (
  [id] int,
  [id_jugador] int,
  [id_club] int,
  [goles] int,
  [amarillas] int,
  [roja] int,
  CONSTRAINT [FK_estadisticasTotales.id_club]
    FOREIGN KEY ([id_club])
      REFERENCES [club]([id]),
  CONSTRAINT [FK_estadisticasTotales.id_jugador]
    FOREIGN KEY ([id_jugador])
      REFERENCES [jugadores]([id])
);



ALTER TABLE clasificacion  add CONSTRAINT idclasificacion FOREIGN KEY (id) REFERENCES club(id);

