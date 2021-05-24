CREATE DATABASE "Library"
    WITH
    OWNER = postgres
    ENCODING = 'UTF8'
    CONNECTION LIMIT = -1;

CREATE SEQUENCE publisher_id_sequence;

CREATE TABLE Publisher (
	PublisherId int NOT NULL DEFAULT nextval('publisher_id_sequence'),
	Name varchar(255) NOT NULL,
	Address varchar(255),
	Telephone varchar(50),
	PRIMARY KEY (PublisherId)
);

CREATE TABLE Book (
	BookId int NOT NULL,
	Title varchar(255) NOT NULL,
	Language varchar(50),
	Format varchar(50),
	PublisherId int NOT NULL,
	PRIMARY KEY (BookId),
	CONSTRAINT FK_Book_PublisherId FOREIGN KEY (PublisherId) REFERENCES Publisher(PublisherId)
);

CREATE SEQUENCE topic_id_sequence;

CREATE TABLE Topic (
	TopicId int NOT NULL DEFAULT nextval('topic_id_sequence'),
	Name varchar(255),
	PRIMARY KEY (TopicId)
);

CREATE SEQUENCE author_id_sequence;

CREATE TABLE Author (
	AuthorId int NOT NULL DEFAULT nextval('author_id_sequence'),
	Name varchar(255),
	PRIMARY KEY (AuthorId)
);

CREATE SEQUENCE member_id_sequence;

CREATE TABLE Member (
	MemberId int NOT NULL DEFAULT nextval('member_id_sequence'),
	Name varchar(255) NOT NULL,
	Address varchar(255),
	Telephone varchar(50),
	Category varchar(50),
	PRIMARY KEY (MemberId)
);

CREATE SEQUENCE exemplar_id_sequence;

CREATE TABLE Exemplar (
	ExemplarId int NOT NULL DEFAULT nextval('exemplar_id_sequence'),
	OrderNumber int NOT NULL,
	Edition int NOT NULL,
	Localization varchar(50),
	Category varchar(50),
    BookId int NOT NULL,
	PRIMARY KEY (ExemplarId),
	CONSTRAINT FK_Exemplar_BookId FOREIGN KEY (BookId) REFERENCES Book(BookId)
);

CREATE SEQUENCE borrow_id_sequence;

CREATE TABLE Borrow (
	BorrowId int NOT NULL DEFAULT nextval('borrow_id_sequence'),
	BorrowDate date NOT NULL,
	ReturnDate date,
	Notes varchar(255),
    MemberId int NOT NULL,
    ExemplarId int NOT NULL,
	PRIMARY KEY (BorrowId),
	CONSTRAINT FK_Borrow_MemberId FOREIGN KEY (MemberId) REFERENCES Member(MemberId),
	CONSTRAINT FK_Borrow_ExemplarId FOREIGN KEY (ExemplarId) REFERENCES Exemplar(ExemplarId)
);

CREATE SEQUENCE about_id_sequence;

CREATE TABLE About (
	AboutId int NOT NULL DEFAULT nextval('about_id_sequence'),
    BookId int NOT NULL,
    TopicId int NOT NULL,
	PRIMARY KEY (AboutId),
	CONSTRAINT FK_About_BookId FOREIGN KEY (BookId) REFERENCES Book(BookId),
	CONSTRAINT FK_About_TopicId FOREIGN KEY (TopicId) REFERENCES Topic(TopicId)
);

CREATE SEQUENCE written_by_id_sequence;

CREATE TABLE WrittenBy (
	WrittenById int NOT NULL DEFAULT nextval('written_by_id_sequence'),
    BookId int NOT NULL,
    AuthorId int NOT NULL,
	PRIMARY KEY (WrittenById),
	CONSTRAINT FK_Written_BookId FOREIGN KEY (BookId) REFERENCES Book(BookId),
	CONSTRAINT FK_Written_AuthorId FOREIGN KEY (AuthorId) REFERENCES Author(AuthorId)
);
