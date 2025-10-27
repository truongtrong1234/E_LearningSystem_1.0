`-- ====================================
-- 21.10.2025 (ver4)
-- E-LEARNING DATABASE (Udemy-style, FIXED)
-- ====================================
create database ElearningDB10;
go
USE ElearningDB10;
GO

-- =========================
-- ACCOUNTS
-- =========================
CREATE TABLE Accounts (
    AccountID INT IDENTITY(1,1) PRIMARY KEY,
    email NVARCHAR(255) UNIQUE NOT NULL,
    password NVARCHAR(255) NULL,               -- null n?u dang nh?p b?ng Google
    name NVARCHAR(255) NULL,
    picture NVARCHAR(500) NULL,
	role NVARCHAR(20) CHECK (role IN ('learner','instructor','admin')),  
);
-- =========================
-- COURSES
-- =========================

-- B?ng Category
CREATE TABLE Category (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName NVARCHAR(100) NOT NULL
);

-- B?ng Courses
CREATE TABLE Courses (
    CourseID INT IDENTITY(1,1) PRIMARY KEY,
    Title NVARCHAR(200) NOT NULL,
    Description NVARCHAR(MAX),
    CategoryID INT NOT NULL,
    InstructorID INT NOT NULL,
    Price DECIMAL(10,2) CHECK (Price >= 0) DEFAULT 0,
    Thumbnail NVARCHAR(MAX) NULL,
	Class NVARCHAR(10) CHECK (Class IN ('10','11','12')) NOT NULL,
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID),
    FOREIGN KEY (InstructorID) REFERENCES Accounts(AccountID)
);
-- =========================
-- CHAPTERS
-- =========================
CREATE TABLE Chapters (
    ChapterID INT IDENTITY PRIMARY KEY,
    CourseID INT NOT NULL,
    Title NVARCHAR(200) NOT NULL,
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID) ON DELETE CASCADE
);

-- =========================
-- LESSONS
-- =========================
CREATE TABLE Lessons (
    LessonID INT IDENTITY PRIMARY KEY,
    ChapterID INT NOT NULL,
    Title NVARCHAR(200) NOT NULL,
    FOREIGN KEY (ChapterID) REFERENCES Chapters(ChapterID) ON DELETE CASCADE
);
-- =========================
-- MATERIALS
-- =========================
CREATE TABLE Materials (
    MaterialID INT IDENTITY PRIMARY KEY,
    LessonID INT NOT NULL,
    Title NVARCHAR(200) NOT NULL,
    ContentURL NVARCHAR(500),
    MaterialType NVARCHAR(50) CHECK (MaterialType IN ('Video','PDF','Slide','Other')),
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (LessonID) REFERENCES Lessons(LessonID) ON DELETE CASCADE
);

-- =========================
-- ENROLLMENTS
-- =========================
CREATE TABLE Enrollments (
    EnrollmentID INT IDENTITY PRIMARY KEY,
    AccountID INT NOT NULL,
    CourseID INT NOT NULL,
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID),
    FOREIGN KEY (CourseID) REFERENCES Courses(CourseID),
    UNIQUE(AccountID, CourseID)
);

-- =========================
-- PAYMENTS
-- =========================
CREATE TABLE Payments (
    PaymentID INT IDENTITY PRIMARY KEY,
    EnrollmentID INT NOT NULL,
    Amount DECIMAL(10,2) CHECK (Amount >= 0) NOT NULL,
    Status NVARCHAR(20) CHECK (Status IN ('Pending','Success','Failed','Refunded')) DEFAULT 'Pending',
    TransactionID NVARCHAR(100) UNIQUE NULL,
    PaidAt DATETIME DEFAULT GETDATE(),
	FOREIGN KEY (EnrollmentID) REFERENCES Enrollments(EnrollmentID)
);

-- =========================
-- QUIZZES
-- =========================
CREATE TABLE Quizzes (
    QuizID INT IDENTITY PRIMARY KEY,
    ChapterID INT NOT NULL,
    Title NVARCHAR(200) NOT NULL,
    FOREIGN KEY (ChapterID) REFERENCES Chapters(ChapterID) ON DELETE CASCADE
);

CREATE TABLE Questions (
    QuestionID INT IDENTITY PRIMARY KEY,
    QuizID INT NOT NULL,
    QuestionText NVARCHAR(MAX) NOT NULL,
    OptionA NVARCHAR(255) NOT NULL,
    OptionB NVARCHAR(255) NOT NULL,
    OptionC NVARCHAR(255) NOT NULL,
    OptionD NVARCHAR(255) NOT NULL,
    CorrectAnswer CHAR(1) CHECK (CorrectAnswer IN ('A','B','C','D')) NOT NULL,
    FOREIGN KEY (QuizID) REFERENCES Quizzes(QuizID)
);

CREATE TABLE StudentAnswers (
    AnswerID INT IDENTITY PRIMARY KEY,
    AccountID INT NOT NULL,
    QuestionID INT NOT NULL,
    SelectedAnswer CHAR(1) CHECK (SelectedAnswer IN ('A','B','C','D')),
    IsCorrect BIT,
    AnsweredAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID),
    FOREIGN KEY (QuestionID) REFERENCES Questions(QuestionID)
);

-- =========================
-- PROGRESS TRACKING
-- =========================

CREATE TABLE [dbo].[QuizProgress](
	[ProgressID] [int] IDENTITY(1,1) NOT NULL,
	[AccountID] [int] NOT NULL,
	[QuizID] [int] NOT NULL,
	[CorrectCount] [int] NULL,
	[TotalScore] [decimal](5, 2) NULL,
	FOREIGN KEY ([AccountID]) REFERENCES Accounts([AccountID]) ON DELETE CASCADE,
    FOREIGN KEY ([QuizID]) REFERENCES Quizzes([QuizID]) ON DELETE CASCADE,
	UNIQUE([AccountID], [QuizID])
);
CREATE TABLE LessonProgress (
    LessonProgressID INT IDENTITY PRIMARY KEY,
    EnrollmentID INT NOT NULL,
    LessonID INT NOT NULL,
    IsCompleted BIT DEFAULT 0,
    CompletedAt DATETIME NULL,
    FOREIGN KEY (EnrollmentID) REFERENCES Enrollments(EnrollmentID) ON DELETE CASCADE,
    FOREIGN KEY (LessonID) REFERENCES Lessons(LessonID) ON DELETE CASCADE,
    UNIQUE(EnrollmentID, LessonID)
);

CREATE TABLE CourseProgress (
    ProgressID INT IDENTITY PRIMARY KEY,
    EnrollmentID INT NOT NULL,
    CompletedPercent DECIMAL(5,2) DEFAULT 0,
    LastAccess DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (EnrollmentID) REFERENCES Enrollments(EnrollmentID) ON DELETE CASCADE,
    UNIQUE(EnrollmentID)
);

-- =========================
-- NOTIFICATIONS
-- =========================
CREATE TABLE Notifications (
    NotificationID INT IDENTITY PRIMARY KEY,
    AccountID INT NOT NULL,
    Type NVARCHAR(50) 
        CHECK (Type IN ('System', 'Email', 'CourseUpdate', 'Payment', 'Reminder')) 
        DEFAULT 'System',
    Title NVARCHAR(200) NOT NULL,
    Message NVARCHAR(1000) NOT NULL,
    IsRead BIT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);

-- =========================
-- SAMPLE DATA
-- =========================
-- ====================================
-- 22.10.2025 (ver5)
-- E-LEARNING DATABASE (Sample Data Expanded)
-- ====================================

-- ===== CLEAR OLD DATA =====
DELETE FROM Notifications;
DELETE FROM StudentAnswers;
DELETE FROM QuizProgress;
DELETE FROM LessonProgress;
DELETE FROM CourseProgress;
DELETE FROM Payments;
DELETE FROM Enrollments;
DELETE FROM Materials;
DELETE FROM Lessons;
DELETE FROM Chapters;
DELETE FROM Questions;
DELETE FROM Quizzes;
DELETE FROM Courses;
DELETE FROM Category;
DELETE FROM Accounts;
GO
/* =========================
   RESEED IDENTITIES
   ========================= */
PRINT 'Reseeding identity columns...';
DBCC CHECKIDENT ('Accounts', RESEED, 0);
DBCC CHECKIDENT ('Category', RESEED, 0);
DBCC CHECKIDENT ('Courses', RESEED, 0);
DBCC CHECKIDENT ('Chapters', RESEED, 0);
DBCC CHECKIDENT ('Lessons', RESEED, 0);
DBCC CHECKIDENT ('Materials', RESEED, 0);
DBCC CHECKIDENT ('Enrollments', RESEED, 0);
DBCC CHECKIDENT ('Payments', RESEED, 0);
DBCC CHECKIDENT ('Quizzes', RESEED, 0);
DBCC CHECKIDENT ('Questions', RESEED, 0);
DBCC CHECKIDENT ('StudentAnswers', RESEED, 0);
DBCC CHECKIDENT ('QuizProgress', RESEED, 0);
DBCC CHECKIDENT ('LessonProgress', RESEED, 0);
DBCC CHECKIDENT ('CourseProgress', RESEED, 0);
DBCC CHECKIDENT ('Notifications', RESEED, 0);
GO

/* =========================
   INSERT ACCOUNTS
   ========================= */
PRINT 'Inserting accounts...';
INSERT INTO Accounts (email, password, name, picture, role) VALUES
('admin@elearn.com', '123456', N'System Admin', NULL, 'admin'),
('alice@gmail.com', 'pass123', N'Alice Nguyen', NULL, 'instructor'),
('bob@gmail.com', 'pass123', N'Bob Tran', NULL, 'instructor'),
('charlie@gmail.com', 'pass123', N'Charlie Pham', NULL, 'learner'),
('daisy@gmail.com', 'pass123', N'Daisy Le', NULL, 'learner'),
('edward@gmail.com', 'pass123', N'Edward Hoang', NULL, 'learner');
GO

/* =========================
   INSERT CATEGORY
   ========================= */
PRINT 'Inserting categories...';
INSERT INTO Category (CategoryName) VALUES
(N'Toán học'),
(N'Vật lý'),
(N'Hóa học'),
(N'Ngữ văn'),
(N'Ngoại ngữ'),
(N'Tin học');
GO

/* =========================
   INSERT COURSES (map Instructor by email)
   ========================= */
PRINT 'Inserting courses...';
INSERT INTO Courses (Title, Description, CategoryID, InstructorID, Price, Thumbnail, Class)
SELECT T.Title, T.Description, C.CategoryID, A.AccountID, T.Price, NULL, T.Class
FROM (VALUES
    (N'Giải tích 12 nâng cao', N'Khóa học giúp học sinh 12 làm chủ đạo hàm, tích phân và ứng dụng.', N'Toán học', 199000.00, '12'),
    (N'Vật lý 11 cơ bản', N'Tổng hợp kiến thức điện học, quang học lớp 11.', N'Vật lý', 149000.00, '11'),
    (N'Luyện thi TOEIC cấp tốc', N'Khoá luyện nghe - đọc TOEIC trong 30 ngày.', N'Ngoại ngữ', 299000.00, '12')
) AS T(Title, Description, CategoryName, Price, Class)
JOIN Category C ON C.CategoryName = T.CategoryName
-- assign instructors: Alice -> 'Giải tích', Bob -> 'Vật lý', Alice -> TOEIC
JOIN Accounts A ON A.email = CASE 
    WHEN T.Title = N'Giải tích 12 nâng cao' THEN 'alice@gmail.com'
    WHEN T.Title = N'Vật lý 11 cơ bản' THEN 'bob@gmail.com'
    WHEN T.Title = N'Luyện thi TOEIC cấp tốc' THEN 'alice@gmail.com'
END;
GO

/* =========================
   INSERT CHAPTERS (map CourseID by Title)
   ========================= */
PRINT 'Inserting chapters...';
INSERT INTO Chapters (CourseID, Title)
SELECT C.CourseID, X.Title FROM (
    VALUES
    (N'Giải tích 12 nâng cao', N'Đạo hàm và ứng dụng'),
    (N'Giải tích 12 nâng cao', N'Tích phân và ứng dụng'),
    (N'Vật lý 11 cơ bản', N'Điện học'),
    (N'Vật lý 11 cơ bản', N'Quang học'),
    (N'Luyện thi TOEIC cấp tốc', N'Ngữ pháp TOEIC'),
    (N'Luyện thi TOEIC cấp tốc', N'Kỹ năng Listening')
) AS X(CourseTitle, Title)
JOIN Courses C ON C.Title = X.CourseTitle;
GO

/* =========================
   INSERT LESSONS (map ChapterID by Course+Chapter)
   ========================= */
PRINT 'Inserting lessons...';
-- We'll insert a set of lessons; ensure titles are unique per chapter for mapping
INSERT INTO Lessons (ChapterID, Title)
SELECT Ch.ChapterID, L.Title
FROM (
    VALUES
    (N'Giải tích 12 nâng cao', N'Đạo hàm và ứng dụng', N'Khái niệm đạo hàm'),
    (N'Giải tích 12 nâng cao', N'Đạo hàm và ứng dụng', N'Đạo hàm của hàm hợp'),
    (N'Giải tích 12 nâng cao', N'Tích phân và ứng dụng', N'Khái niệm tích phân'),
    (N'Giải tích 12 nâng cao', N'Tích phân và ứng dụng', N'Ứng dụng tích phân trong hình học'),
    (N'Vật lý 11 cơ bản', N'Điện học', N'Định luật Ôm'),
    (N'Vật lý 11 cơ bản', N'Điện học', N'Điện trở và mạch song song'),
    (N'Vật lý 11 cơ bản', N'Quang học', N'Phản xạ ánh sáng'),
    (N'Vật lý 11 cơ bản', N'Quang học', N'Khúc xạ ánh sáng'),
    (N'Luyện thi TOEIC cấp tốc', N'Ngữ pháp TOEIC', N'Cấu trúc câu cơ bản'),
    (N'Luyện thi TOEIC cấp tốc', N'Kỹ năng Listening', N'Nghe Part 1 – Mô tả hình ảnh')
) AS L(CourseTitle, ChapterTitle, Title)
JOIN Courses C ON C.Title = L.CourseTitle
JOIN Chapters Ch ON Ch.CourseID = C.CourseID AND Ch.Title = L.ChapterTitle;
GO

/* =========================
   INSERT MATERIALS safely by LOOKUP lesson by title
   ========================= */
PRINT 'Inserting materials...';
INSERT INTO Materials (LessonID, Title, ContentURL, MaterialType)
SELECT L.LessonID, M.Title, M.ContentURL, M.MaterialType
FROM (
    VALUES
    (N'Khái niệm đạo hàm', N'Video bài giảng đạo hàm', N'https://example.com/video1.mp4', N'Video'),
    (N'Khái niệm đạo hàm', N'File PDF tóm tắt công thức', N'https://example.com/pdf1.pdf', N'PDF'),
    (N'Khái niệm tích phân', N'Video tích phân cơ bản', N'https://example.com/video2.mp4', N'Video'),
    (N'Định luật Ôm', N'Slide định luật Ôm', N'https://example.com/slide1.pptx', N'Slide'),
    (N'Khúc xạ ánh sáng', N'Video khúc xạ', N'https://example.com/video_refraction.mp4', N'Video'),
    (N'Cấu trúc câu cơ bản', N'Slide ngữ pháp cơ bản', N'https://example.com/grammar_slide.pdf', N'PDF'),
    (N'Nghe Part 1 – Mô tả hình ảnh', N'Audio mẫu Part1', N'https://example.com/toeic_part1.mp3', N'Other')
) AS M(LessonTitle, Title, ContentURL, MaterialType)
JOIN Lessons L ON L.Title = M.LessonTitle;
GO

/* =========================
   INSERT ENROLLMENTS (map Account by email, Course by title)
   ========================= */
PRINT 'Inserting enrollments...';
INSERT INTO Enrollments (AccountID, CourseID)
SELECT A.AccountID, C.CourseID
FROM (
    VALUES
    ('charlie@gmail.com', N'Giải tích 12 nâng cao'),
    ('daisy@gmail.com', N'Giải tích 12 nâng cao'),
    ('daisy@gmail.com', N'Vật lý 11 cơ bản'),
    ('edward@gmail.com', N'Luyện thi TOEIC cấp tốc')
) AS E(Email, CourseTitle)
JOIN Accounts A ON A.email = E.Email
JOIN Courses C ON C.Title = E.CourseTitle;
GO

/* =========================
   INSERT PAYMENTS (map EnrollmentID by Account+Course)
   ========================= */
PRINT 'Inserting payments...';
-- Example payments for each enrollment
INSERT INTO Payments (EnrollmentID, Amount, Status, TransactionID)
SELECT En.EnrollmentID,
       CASE WHEN C.Price IS NULL THEN 0 ELSE C.Price END,
       CASE WHEN A.email = 'edward@gmail.com' THEN 'Pending' ELSE 'Success' END,
       CONCAT('TXN', RIGHT('000' + CAST(ROW_NUMBER() OVER (ORDER BY En.EnrollmentID) AS VARCHAR(10)),4))
FROM Enrollments En
JOIN Courses C ON C.CourseID = En.CourseID
JOIN Accounts A ON A.AccountID = En.AccountID;
GO

/* =========================
   INSERT QUIZZES (map ChapterID by Course+Chapter)
   ========================= */
PRINT 'Inserting quizzes...';
INSERT INTO Quizzes (ChapterID, Title)
SELECT Ch.ChapterID, Q.Title
FROM (
    VALUES
    (N'Giải tích 12 nâng cao', N'Đạo hàm - Quiz'),
    (N'Vật lý 11 cơ bản', N'Điện học - Quiz'),
    (N'Luyện thi TOEIC cấp tốc', N'Grammar - Quiz')
) AS Q(CourseTitle, Title)
JOIN Courses C ON C.Title = Q.CourseTitle
JOIN Chapters Ch ON Ch.CourseID = C.CourseID
-- pick first chapter matching quiz name area (safe because chapter exists)
WHERE (Q.CourseTitle = N'Giải tích 12 nâng cao' AND Ch.Title = N'Đạo hàm và ứng dụng')
   OR (Q.CourseTitle = N'Vật lý 11 cơ bản' AND Ch.Title = N'Điện học')
   OR (Q.CourseTitle = N'Luyện thi TOEIC cấp tốc' AND Ch.Title = N'Ngữ pháp TOEIC');
GO

/* =========================
   INSERT QUESTIONS (map QuizID by Quiz.Title)
   ========================= */
PRINT 'Inserting questions...';
INSERT INTO Questions (QuizID, QuestionText, OptionA, OptionB, OptionC, OptionD, CorrectAnswer)
SELECT Q.QuizID, QP.QuestionText, QP.OptionA, QP.OptionB, QP.OptionC, QP.OptionD, QP.Correct
FROM (
    VALUES
    (N'Đạo hàm - Quiz', N'Đạo hàm của x^2 là?', N'2x', N'x', N'x^2', N'1', N'A'),
    (N'Đạo hàm - Quiz', N'Đạo hàm của sin(x) là?', N'cos(x)', N'-sin(x)', N'-cos(x)', N'sin(x)', N'A'),
    (N'Điện học - Quiz', N'Hiệu điện thế đo bằng đơn vị nào?', N'Vôn', N'Oát', N'Ampe', N'Niutơn', N'A'),
    (N'Grammar - Quiz', N'Choose the correct answer: She ___ to school yesterday.', N'go', N'goes', N'went', N'going', N'C')
) AS QP(QuizTitle, QuestionText, OptionA, OptionB, OptionC, OptionD, Correct)
JOIN Quizzes Q ON Q.Title = QP.QuizTitle;
GO

/* =========================
   INSERT STUDENT ANSWERS (map Account + Question)
   ========================= */
PRINT 'Inserting student answers...';
INSERT INTO StudentAnswers (AccountID, QuestionID, SelectedAnswer, IsCorrect)
SELECT A.AccountID, QQ.QuestionID,
       CASE WHEN A.email = 'charlie@gmail.com' THEN QQ_Correct.Selected ELSE 'A' END,
       CASE WHEN (CASE WHEN A.email = 'charlie@gmail.com' THEN QQ_Correct.Selected ELSE 'A' END) = QQ.CorrectAnswer THEN 1 ELSE 0 END
FROM Accounts A
CROSS JOIN (
    -- pick some sample questions (we'll take first 4)
    SELECT TOP (4) QuestionID, CorrectAnswer FROM Questions ORDER BY QuestionID
) QQ
CROSS APPLY (SELECT QQ.CorrectAnswer AS Selected) AS QQ_Correct
WHERE A.email IN ('charlie@gmail.com','daisy@gmail.com','edward@gmail.com');
-- This inserts answers for the listed accounts against first 4 questions.
GO

/* =========================
   INSERT PROGRESS (LessonProgress & CourseProgress & QuizProgress)
   All mapping done by lookups (Account email, Lesson title, Enrollment)
   ========================= */
PRINT 'Inserting progress...';

-- Example LessonProgress: mark first lesson completed for charlie's enrollment in Giải tích
INSERT INTO LessonProgress (EnrollmentID, LessonID, IsCompleted, CompletedAt)
SELECT En.EnrollmentID, L.LessonID, 1, GETDATE()
FROM Enrollments En
JOIN Accounts A ON A.AccountID = En.AccountID
JOIN Courses C ON C.CourseID = En.CourseID
JOIN Chapters Ch ON Ch.CourseID = C.CourseID
JOIN Lessons L ON L.ChapterID = Ch.ChapterID
WHERE A.email = 'charlie@gmail.com' AND C.Title = N'Giải tích 12 nâng cao' AND L.Title = N'Khái niệm đạo hàm';
GO

-- CourseProgress sample (calculate simple percent)
INSERT INTO CourseProgress (EnrollmentID, CompletedPercent, LastAccess)
SELECT En.EnrollmentID,
       CASE WHEN En.AccountID IS NOT NULL THEN 33 ELSE 0 END,
       GETDATE()
FROM Enrollments En
WHERE En.EnrollmentID IN (SELECT EnrollmentID FROM Enrollments);
GO

-- QuizProgress sample
INSERT INTO QuizProgress (AccountID, QuizID, CorrectCount, TotalScore)
SELECT A.AccountID, Q.QuizID, 2, 10.0
FROM Accounts A
JOIN Quizzes Q ON Q.Title = N'Đạo hàm - Quiz'
WHERE A.email = 'charlie@gmail.com';
GO

/* =========================
   INSERT NOTIFICATIONS
   ========================= */
PRINT 'Inserting notifications...';
INSERT INTO Notifications (AccountID, Type, Title, Message)
SELECT A.AccountID, 'System', N'Chào mừng', N'Chào mừng bạn đã tham gia khoá học!'
FROM Accounts A
WHERE A.email IN ('charlie@gmail.com','daisy@gmail.com','edward@gmail.com');
GO

PRINT 'All inserts completed successfully.';
GO
