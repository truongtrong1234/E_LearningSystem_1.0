CREATE PROCEDURE deleteCourse
    @CourseID INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- 1️⃣ Xóa QnAReply → QnAQuestion
        DELETE QR
        FROM QnAReply QR
        INNER JOIN QnAQuestion Q ON QR.QnAID = Q.QnAID
        WHERE Q.CourseID = @CourseID;

        DELETE FROM QnAQuestion
        WHERE CourseID = @CourseID;

        -- 2️⃣ Xóa StudentAnswers liên quan đến Questions của Quizzes
        DELETE SA
        FROM StudentAnswers SA
        INNER JOIN Questions Q ON SA.QuestionID = Q.QuestionID
        INNER JOIN Quizzes Qu ON Q.QuizID = Qu.QuizID
        INNER JOIN Chapters C ON Qu.ChapterID = C.ChapterID
        WHERE C.CourseID = @CourseID;

        -- 3️⃣ Xóa Questions → Quizzes
        DELETE Q
        FROM Questions Q
        INNER JOIN Quizzes Qu ON Q.QuizID = Qu.QuizID
        INNER JOIN Chapters C ON Qu.ChapterID = C.ChapterID
        WHERE C.CourseID = @CourseID;

        DELETE Qu
        FROM Quizzes Qu
        INNER JOIN Chapters C ON Qu.ChapterID = C.ChapterID
        WHERE C.CourseID = @CourseID;

        -- 4️⃣ Xóa MaterialProgress → Materials
        DELETE MP
        FROM MaterialProgress MP
        INNER JOIN Materials M ON MP.MaterialID = M.MaterialID
        INNER JOIN Lessons L ON M.LessonID = L.LessonID
        INNER JOIN Chapters C ON L.ChapterID = C.ChapterID
        WHERE C.CourseID = @CourseID;

        -- 5️⃣ Xóa LessonProgress → Lessons
        DELETE LP
        FROM LessonProgress LP
        INNER JOIN Lessons L ON LP.LessonID = L.LessonID
        INNER JOIN Chapters C ON L.ChapterID = C.ChapterID
        WHERE C.CourseID = @CourseID;

        -- 6️⃣ Xóa ChapterProgress
        DELETE CP
        FROM ChapterProgress CP
        INNER JOIN Chapters C ON CP.ChapterID = C.ChapterID
        WHERE C.CourseID = @CourseID;

        -- 7️⃣ Xóa CourseProgress → Enrollments
        DELETE CP
        FROM CourseProgress CP
        INNER JOIN Enrollments E ON CP.EnrollmentID = E.EnrollmentID
        WHERE E.CourseID = @CourseID;

        -- 8️⃣ Xóa Payments → Enrollments
        DELETE P
        FROM Payments P
        INNER JOIN Enrollments E ON P.EnrollmentID = E.EnrollmentID
        WHERE E.CourseID = @CourseID;

        -- 9️⃣ Xóa Enrollments
        DELETE FROM Enrollments
        WHERE CourseID = @CourseID;

        -- 10️⃣ Xóa Notifications liên quan đến course (nếu có)
        DELETE N
        FROM Notifications N
        INNER JOIN Courses C ON N.AccountID = C.InstructorID
        WHERE C.CourseID = @CourseID;

        -- 11️⃣ Xóa Reports → ReportReplies
        DELETE RR
        FROM ReportReplies RR
        INNER JOIN Reports R ON RR.ReportID = R.ReportID
        WHERE R.AccountID IN (
            SELECT InstructorID FROM Courses WHERE CourseID = @CourseID
        );

        DELETE R
        FROM Reports R
        WHERE R.AccountID IN (SELECT InstructorID FROM Courses WHERE CourseID = @CourseID
        );

        -- 12️⃣ Xóa Chapters, Lessons, Materials
        -- ✅ Bạn đã có cascade delete, nhưng xóa thủ công cũng ok
        DELETE M
        FROM Materials M
        INNER JOIN Lessons L ON M.LessonID = L.LessonID
        INNER JOIN Chapters C ON L.ChapterID = C.ChapterID
        WHERE C.CourseID = @CourseID;

        DELETE L
        FROM Lessons L
        INNER JOIN Chapters C ON L.ChapterID = C.ChapterID
        WHERE C.CourseID = @CourseID;

        DELETE FROM Chapters
        WHERE CourseID = @CourseID;

        -- 13️⃣ Cuối cùng xóa Course
        DELETE FROM Courses
        WHERE CourseID = @CourseID;

        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        THROW;
    END CATCH
END;
GO