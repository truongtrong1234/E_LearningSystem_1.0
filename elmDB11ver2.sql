-- ====================================
-- 31.10.2025 (ver4)
-- E-LEARNING DATABASE (Udemy-style, FIXED)
-- Report Report replies addon
-- ====================================
create database ElearningDB11;
go
USE ElearningDB11;
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



-- =========================
-- PROGRESS TRACKING (ver4.1)
-- =========================

-- 🔹 Tiến độ Quiz (có ngày làm bài)
CREATE TABLE [dbo].[QuizProgress](
	[ProgressID] INT IDENTITY(1,1) PRIMARY KEY,
	[AccountID] INT NOT NULL,
	[QuizID] INT NOT NULL,
	[CorrectCount] INT NULL,
	[TotalScore] DECIMAL(5, 2) NULL,
    [TakenDate] DATETIME DEFAULT GETDATE(), -- 🆕 thêm ngày làm quiz
	FOREIGN KEY ([AccountID]) REFERENCES Accounts([AccountID]) ON DELETE CASCADE,
    FOREIGN KEY ([QuizID]) REFERENCES Quizzes([QuizID]) ON DELETE CASCADE,
	UNIQUE([AccountID], [QuizID])
);

-- 🔹 Tiến độ từng bài học (lesson)
CREATE TABLE LessonProgress (
    LessonProgressID INT IDENTITY PRIMARY KEY,
    EnrollmentID INT NOT NULL,
    LessonID INT NOT NULL,
    IsCompleted BIT DEFAULT 0,
    -- ❌ bỏ CompletedAt
    FOREIGN KEY (EnrollmentID) REFERENCES Enrollments(EnrollmentID) ON DELETE CASCADE,
    FOREIGN KEY (LessonID) REFERENCES Lessons(LessonID) ON DELETE CASCADE,
    UNIQUE(EnrollmentID, LessonID)
);

-- 🔹 Tiến độ khóa học tổng thể
CREATE TABLE CourseProgress (
    ProgressID INT IDENTITY PRIMARY KEY,
    EnrollmentID INT NOT NULL,
    CompletedPercent DECIMAL(5,2) DEFAULT 0,
    -- ❌ bỏ LastAccess
    FOREIGN KEY (EnrollmentID) REFERENCES Enrollments(EnrollmentID) ON DELETE CASCADE,
    UNIQUE(EnrollmentID)
);

-- 🔹 Tiến độ từng tài liệu (Material)
CREATE TABLE MaterialProgress (
    MaterialProgressID INT IDENTITY PRIMARY KEY,
    EnrollmentID INT NOT NULL,
    MaterialID INT NOT NULL,
    IsCompleted BIT DEFAULT 0,
    FOREIGN KEY (EnrollmentID) REFERENCES Enrollments(EnrollmentID) ON DELETE CASCADE,
    FOREIGN KEY (MaterialID) REFERENCES Materials(MaterialID) ON DELETE CASCADE,
    UNIQUE(EnrollmentID, MaterialID)
);

-- 🔹 Tiến độ chương (Chapter)
CREATE TABLE ChapterProgress (
    ChapterProgressID INT IDENTITY PRIMARY KEY,
    EnrollmentID INT NOT NULL,
    ChapterID INT NOT NULL,
    IsCompleted BIT DEFAULT 0,
    FOREIGN KEY (EnrollmentID) REFERENCES Enrollments(EnrollmentID) ON DELETE CASCADE,
    FOREIGN KEY (ChapterID) REFERENCES Chapters(ChapterID) ON DELETE CASCADE,
    UNIQUE(EnrollmentID, ChapterID)
);

-- 🔹 Câu trả lời của học viên (bỏ thời gian)
CREATE TABLE StudentAnswers (
    AnswerID INT IDENTITY PRIMARY KEY,
    AccountID INT NOT NULL,
    QuestionID INT NOT NULL,
    SelectedAnswer CHAR(1) CHECK (SelectedAnswer IN ('A','B','C','D')),
    IsCorrect BIT,
    -- ❌ bỏ AnsweredAt
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID),
    FOREIGN KEY (QuestionID) REFERENCES Questions(QuestionID)
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
-- REPORTS (User → Admin)
-- =========================
CREATE TABLE Reports (
    ReportID INT IDENTITY(1,1) PRIMARY KEY,
    AccountID INT NOT NULL, -- Người gửi (learner/instructor)
    Title NVARCHAR(200) NOT NULL,
    Message NVARCHAR(MAX) NOT NULL,
    Status NVARCHAR(20) CHECK (Status IN ('Pending','Reviewed','Resolved')) DEFAULT 'Pending',
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (AccountID) REFERENCES Accounts(AccountID)
);

-- =========================
-- REPORT REPLIES (Admin → User)
-- =========================
CREATE TABLE ReportReplies (
    ReplyID INT IDENTITY(1,1) PRIMARY KEY,
    ReportID INT NOT NULL,
    AdminID INT NOT NULL, -- Tài khoản admin trả lời
    ReplyMessage NVARCHAR(MAX) NOT NULL,
    RepliedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ReportID) REFERENCES Reports(ReportID) ON DELETE CASCADE,
    FOREIGN KEY (AdminID) REFERENCES Accounts(AccountID)
);
go
-- =========================
-- TRIGGER: Notify user when admin replies
-- =========================
CREATE TRIGGER trg_ReportReply_Notify
ON ReportReplies
AFTER INSERT
AS
BEGIN
    INSERT INTO Notifications (AccountID, Type, Title, Message)
    SELECT R.AccountID, 'System',
           N'Phản hồi từ Admin',
           CONCAT(N'Admin đã trả lời báo cáo của bạn: "', LEFT(RR.ReplyMessage, 100), '..."')
    FROM inserted RR
    JOIN Reports R ON R.ReportID = RR.ReportID;
END;
GO
-- =========================
-- SAMPLE DATA
-- =========================
-- ====================================
-- 22.10.2025 (ver5)
-- E-LEARNING DATABASE (Sample Data Expanded)
-- ====================================



-- =========================
-- DỮ LIỆU MẪU CHO E-LEARNING CẤP 3
-- =========================


PRINT 'Inserting corrected high-school sample data...';

-- ===== ACCOUNTS: 1 admin, 3 instructors, 4 learners =====
INSERT INTO Accounts (email, password, name, picture, role) VALUES
('admin@school.local', 'admin123', N'Quản trị viên', NULL, 'admin'),
('gv_toan@school.local', 'gv123', N'Nguyễn Văn Toán', NULL, 'instructor'),
('gv_ly@school.local', 'gv123', N'Trần Thị Lý', NULL, 'instructor'),
('gv_anh@school.local', 'gv123', N'Lê Thị Anh', NULL, 'instructor'),
('hs1@school.local', 'hs123', N'Nguyễn Minh A', NULL, 'learner'),
('hs2@school.local', 'hs123', N'Trần Thùy B', NULL, 'learner'),
('hs3@school.local', 'hs123', N'Phạm Lan C', NULL, 'learner'),
('hs4@school.local', 'hs123', N'Võ Văn D', NULL, 'learner');
GO

INSERT INTO Accounts (email, password, name, picture, role) VALUES
('admin@elearn.com', '123456', N'System Admin', NULL, 'admin');

-- ===== CATEGORY: 9 môn văn hóa =====
INSERT INTO Category (CategoryName) VALUES
(N'Toán học'),
(N'Vật lý'),
(N'Hóa học'),
(N'Sinh học'),
(N'Ngữ văn'),
(N'Lịch sử'),
(N'Địa lý'),
(N'Tiếng Anh'),
(N'Tin học');
GO

-- ===== COURSES: 12+ khóa (dùng CategoryID 1..9 và InstructorIDs 2..4) =====
INSERT INTO Courses (Title, Description, CategoryID, InstructorID, Price, Thumbnail, Class) VALUES
(N'Toán 10 - Đại số & Hình học', N'Khóa cơ bản Toán 10', 1, 2, 300000.00, 'toan10.jpg', '10'),
(N'Toán 11 - Hình học', N'Hình học phẳng & không gian', 1, 2, 4000000.00, 'toan11.jpg', '11'),
(N'Toán 12 - Ôn thi THPT', N'Tổng ôn Toán 12', 1, 2, 500000.00, 'toan12.jpg', '12'),
(N'Vật lý 11 - Điện học', N'Điện tĩnh, điện động', 2, 3, 600000.00, 'ly11.jpg', '11'),
(N'Vật lý 12 - Dao động & Sóng', N'Dao động, sóng cơ', 2, 3, 250000.00, 'ly12.jpg', '12'),
(N'Hóa học 12 - Vô cơ', N'Phản ứng vô cơ trọng tâm', 3, 4, 1200000.00, 'hoa12.jpg', '12'),
(N'Sinh học 11 - Di truyền', N'Gen, quy luật Mendel', 4, 4, 450000.00, 'sinh11.jpg', '11'),
(N'Ngữ văn 12 - Tác phẩm trọng tâm', N'Phân tích văn học', 5, 3, 450000.00, 'van12.jpg', '12'),
(N'Lịch sử 12 - Cận đại', N'Lịch sử thế giới & VN', 6, 3, 450000.00, 'su12.jpg', '12'),
(N'Địa lý 12 - Khí hậu & Bản đồ', N'Địa lý tự nhiên & dân cư', 7, 2, 450000.00, 'dia12.jpg', '12'),
(N'Tiếng Anh 12 - Luyện đề', N'Ngữ pháp, đọc hiểu', 8, 4, 700000.00, 'eng12.jpg', '12'),
(N'Tin học 11 - Cơ bản', N'Tin học ứng dụng & lập trình cơ bản', 9, 2, 70000.00, 'it11.jpg', '11');
GO

-- ===== CHAPTERS: 2-3 chương mỗi khóa (tham khảo CourseID 1..12) =====
INSERT INTO Chapters (CourseID, Title) VALUES
(1, N'Hàm số & đồ thị'),
(1, N'Phương trình & bất phương trình'),
(2, N'Hình học phẳng'),
(2, N'Hình học không gian'),
(3, N'Tổ hợp & xác suất'),
(3, N'Tích phân cơ bản'),
(4, N'Điện tích & điện trường'),
(4, N'Dòng điện không đổi'),
(5, N'Dao động điều hòa'),
(5, N'Sóng cơ và siêu âm'),
(6, N'Vô cơ - Axit bazơ'),
(6, N'Kim loại & phi kim'),
(7, N'Di truyền Mendel'),
(8, N'Phong cách văn học'),
(9, N'Cách mạng & chiến tranh thế giới'),
(10, N'Khí hậu & bản đồ'),
(11, N'Techniques for Reading'),
(11, N'Grammar for Writing'),
(12, N'Tin học cơ bản'),
(12, N'Lập trình sơ cấp');
GO

-- ===== LESSONS: 2 bài mỗi chương (liên tiếp ChapterID từ 1...) =====
INSERT INTO Lessons (ChapterID, Title) VALUES
-- Course 1 chapters (ChapterID 1-2)
(1, N'Đồ thị hàm số bậc hai'),
(1, N'Tính chất hàm số'),
(2, N'Giải bất phương trình'),
(2, N'Ứng dụng thực tế'),
-- Course 2 chapters (3-4)
(3, N'Tam giác & đường tròn'),
(3, N'Ứng dụng hình học'),
(4, N'Mặt phẳng trong không gian'),
(4, N'Hình chóp - hình lăng trụ'),
-- Course 3 chapters (5-6)
(5, N'Nguyên lý đếm'),
(5, N'Xác suất cơ bản'),
(6, N'Định nghĩa tích phân'),
(6, N'Ứng dụng tích phân'),
-- Course 4 chapters (7-8)
(7, N'Khái niệm điện tích'),
(7, N'Trường điện'),
(8, N'Định luật Ôm'),
(8, N'Mạch điện cơ bản'),
-- Course 5 chapters (9-10)
(9, N'Chu kỳ & dao động'),
(9, N'Năng lượng trong dao động'),
(10, N'Sóng cơ bản'),
(10, N'Hiện tượng sóng'),
-- Course 6 chapters (11-12)
(11, N'Axit & Bazơ căn bản'),
(11, N'Phản ứng hóa học'),
(12, N'Tính chất kim loại'),
(12, N'Ứng dụng kim loại'),
-- Course 7-12 (continuing)
(13, N'Quy luật Mendel 1'),
(14, N'Phân tích văn bản 1'),
(15, N'Lịch sử thế giới - phần 1'),
(16, N'Bản đồ địa lý cơ bản'),
(17, N'Reading: strategies'),
(17, N'Vocabulary building'),
(18, N'Grammar: tenses overview'),
(19, N'Khái niệm máy tính'),
(19, N'File & thư mục');
GO

-- ===== MATERIALS: 2 items mỗi lesson (liên tiếp LessonID từ 1...) =====
INSERT INTO Materials (LessonID, Title, ContentURL, MaterialType) VALUES
(1, N'Video: Đồ thị hàm bậc hai', 'videos/toan1.mp4', 'Video'),
(1, N'Slide minh họa', 'slides/toan1.pdf', 'PDF'),
(2, N'Tài liệu tính chất', 'docs/toan2.pdf', 'PDF'),
(2, N'Ví dụ làm tay', 'docs/toan2_ex.pdf', 'PDF'),
(3, N'Bài tập bất phương trình', 'docs/bpt.pdf', 'PDF'),
(3, N'Video hướng dẫn', 'videos/bpt.mp4', 'Video'),
(4, N'Ứng dụng thực tế - bài tập', 'docs/app.pdf', 'PDF'),
(4, N'Quiz nhỏ', 'quiz/app_quiz.html', 'Other'),
(5, N'Bài giảng tam giác', 'videos/geo1.mp4', 'Video'),
(5, N'Slide tam giác', 'slides/geo1.pdf', 'PDF'),
(6, N'Bài tập hình học', 'docs/geo2.pdf', 'PDF'),
(6, N'Bài giải mẫu', 'docs/geo2_solutions.pdf', 'PDF'),
(7, N'Video mặt phẳng', 'videos/space1.mp4', 'Video'),
(7, N'Slide mặt phẳng', 'slides/space1.pdf', 'PDF'),
(8, N'Bài tập hình chóp', 'docs/pyramid.pdf', 'PDF'),
(8, N'Ví dụ thực tế', 'docs/pyramid_case.pdf', 'PDF'),
(9, N'Video tích phân', 'videos/integral1.mp4', 'Video'),
(9, N'Bài tập tích phân', 'docs/integral_ex.pdf', 'PDF'),
(10, N'Ứng dụng tích phân', 'docs/integral_app.pdf', 'PDF'),
(10, N'Quiz tích phân', 'quiz/integral_quiz.html', 'Other'),
(11, N'Video điện tích', 'videos/elec1.mp4', 'Video'),
(11, N'Slide điện trường', 'slides/elec1.pdf', 'PDF'),
(12, N'Bài tập Ôm', 'docs/ohm.pdf', 'PDF'),
(12, N'Video mạch đơn giản', 'videos/circuit1.mp4', 'Video'),
(13, N'Video Mendel', 'videos/mendel.mp4', 'Video'),
(13, N'Worksheet Mendel', 'docs/mendel_ws.pdf', 'PDF'),
(14, N'Bài phân tích văn bản', 'docs/van1.pdf', 'PDF'),
(14, N'Video hướng dẫn phân tích', 'videos/van1.mp4', 'Video'),
(15, N'Tư liệu lịch sử', 'docs/su1.pdf', 'PDF'),
(15, N'Bản đồ kèm chú thích', 'maps/su1.pdf', 'PDF'),
(16, N'Bản đồ vùng', 'maps/dia1.pdf', 'PDF'),
(16, N'Bài tập địa lý', 'docs/dia1_ex.pdf', 'PDF'),
(17, N'Reading practice 1', 'docs/reading1.pdf', 'PDF'),
(17, N'Audio reading 1', 'audio/read1.mp3', 'Other'),
(18, N'Grammar overview', 'docs/grammar1.pdf', 'PDF'),
(18, N'Exercises', 'quiz/grammar1.html', 'Other'),
(19, N'Intro to computers', 'docs/it1.pdf', 'PDF'),
(19, N'Practical file exercises', 'docs/it2.pdf', 'PDF');
GO

-- ===== ENROLLMENTS: enroll learners into several courses =====
-- AccountIDs: 1=admin,2=instructor1,3=instructor2,4=instructor3, 5..8 learners
INSERT INTO Enrollments (AccountID, CourseID) VALUES
(5, 1), -- hs1 vào Toán10
(5, 3), -- hs1 vào Toán12
(6, 1), -- hs2 vào Toán10
(6, 4), -- hs2 vào Vật lý11
(7, 11), -- hs3 vào Tiếng Anh12
(8, 12); -- hs4 vào Tin học11
GO

-- ===== PAYMENTS: (EnrollmentID must match inserted enrollments above) =====
-- Assuming EnrollmentIDs assigned sequentially starting from 1 in same order as above
INSERT INTO Payments (EnrollmentID, Amount, Status, TransactionID) VALUES
(1, 0.00, 'Success', 'FREE-001'),
(2, 0.00, 'Success', 'FREE-002'),
(3, 0.00, 'Success', 'FREE-003'),
(4, 0.00, 'Success', 'FREE-004'),
(5, 0.00, 'Success', 'FREE-005'),
(6, 0.00, 'Success', 'FREE-006');
GO

-- ===== QUIZZES + QUESTIONS (a few samples) =====
-- create quizzes for some chapters (use ChapterIDs from earlier inserts)
INSERT INTO Quizzes (ChapterID, Title) VALUES
(1, N'Quiz: Hàm số cơ bản'),
(6, N'Quiz: Tích phân cơ bản'),
(11, N'Quiz: Điện tích cơ bản'),
(17, N'Quiz: Reading practice');
GO

INSERT INTO Questions (QuizID, QuestionText, OptionA, OptionB, OptionC, OptionD, CorrectAnswer) VALUES
(1, N'Hàm số y = ax^2 + bx + c là hàm bậc mấy?', N'Bậc 1', N'Bậc 2', N'Bậc 3', N'Không xác định', 'B'),
(2, N'Định nghĩa tích phân là gì?', N'Đạo hàm ngược', N'Tổng vô hạn', N'Giá trị trung bình', N'Không phải các đáp án', 'A'),
(3, N'Đơn vị điện tích là gì?', N'Volt', N'Ampere', N'Coulomb', N'Ohm', 'C'),
(4, N'What does skimming help with?', N'Detail understanding', N'Overall idea', N'Translation', N'Grammar', 'B');
GO

-- ===== PROGRESS EXAMPLES =====
-- QuizProgress (AccountID, QuizID, CorrectCount, TotalScore) 
INSERT INTO QuizProgress (AccountID, QuizID, CorrectCount, TotalScore) VALUES
(5, 1, 3, 100.00),
(6, 2, 1, 50.00),
(7, 4, 2, 66.67);
GO

-- LessonProgress (EnrollmentID, LessonID, IsCompleted)
-- Note: EnrollmentIDs 1..6 correspond to earlier inserted enrollments
INSERT INTO LessonProgress (EnrollmentID, LessonID, IsCompleted) VALUES
(1, 1, 1),
(1, 2, 1),
(2, 3, 0),
(3, 5, 1),
(4, 11, 1);
GO

-- MaterialProgress (EnrollmentID, MaterialID, IsCompleted)
INSERT INTO MaterialProgress (EnrollmentID, MaterialID, IsCompleted) VALUES
(1, 1, 1),
(1, 2, 1),
(3, 5, 1),
(5, 21, 0);
GO

-- ChapterProgress (EnrollmentID, ChapterID, IsCompleted)
INSERT INTO ChapterProgress (EnrollmentID, ChapterID, IsCompleted) VALUES
(1, 1, 1),
(1, 2, 0),
(4, 7, 1);
GO

-- CourseProgress (EnrollmentID, CompletedPercent)
INSERT INTO CourseProgress (EnrollmentID, CompletedPercent) VALUES
(1, 50.00),
(2, 10.00),
(3, 80.00),
(4, 100.00);
GO

-- StudentAnswers (AccountID, QuestionID, SelectedAnswer, IsCorrect)
INSERT INTO StudentAnswers (AccountID, QuestionID, SelectedAnswer, IsCorrect) VALUES
(5, 1, 'B', 1),
(6, 2, 'A', 1),
(7, 4, 'B', 1);
GO

-- REPORTS & REPLIES to test trigger (Reports -> ReportReplies will insert notification)
INSERT INTO Reports (AccountID, Title, Message) VALUES
(5, N'Video bị lỗi', N'Không xem được video bài 1'),
(6, N'Điểm quiz không cập nhật', N'Em đã nộp nhưng không thấy điểm.');
GO

INSERT INTO ReportReplies (ReportID, AdminID, ReplyMessage) VALUES
(1, 1, N'Chúng tôi đã kiểm tra và sửa lỗi video.'),
(2, 1, N'Đã cập nhật điểm, bạn kiểm tra lại.');
GO

-- Check inserted notifications created by trigger
SELECT TOP 20 * FROM Notifications;
GO

PRINT 'Sample data insertion completed.';

