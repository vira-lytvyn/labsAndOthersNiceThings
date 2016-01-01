
CREATE TABLE E_mail (
       E_mail_ID            NUMBER NOT NULL,
       E_mail               VARCHAR2(40) NULL,
       Student              NUMBER NOT NULL
);

CREATE UNIQUE INDEX XPKE_mail ON E_mail
(
       E_mail_ID                      ASC,
       Student                        ASC
);

CREATE INDEX XIF1E_mail ON E_mail
(
       Student                        ASC
);


ALTER TABLE E_mail
       ADD  ( PRIMARY KEY (E_mail_ID, Student) ) ;


CREATE TABLE Exam (
       Exam_ID              NUMBER NOT NULL,
       Exam_Subject         VARCHAR2(20) NULL,
       Date_of_Passing      DATE NULL,
       Lecturer_ID          NUMBER NULL,
       Subject_ID           NUMBER NULL
);

CREATE UNIQUE INDEX XPKExam ON Exam
(
       Exam_ID                        ASC
);

CREATE INDEX XIF2Exam ON Exam
(
       Lecturer_ID                    ASC
);

CREATE INDEX XIF3Exam ON Exam
(
       Subject_ID                     ASC
);


ALTER TABLE Exam
       ADD  ( PRIMARY KEY (Exam_ID) ) ;


CREATE TABLE Groupa (
       Groupa_ID            NUMBER NOT NULL,
       Caption              VARCHAR2(40) NULL
);

CREATE UNIQUE INDEX XPKGroup ON Groupa
(
       Groupa_ID                      ASC
);


ALTER TABLE Groupa
       ADD  ( PRIMARY KEY (Groupa_ID) ) ;


CREATE TABLE Lecturer (
       Lecturer_ID          NUMBER NOT NULL,
       FLM_Name             VARCHAR2(40) NULL
);

CREATE UNIQUE INDEX XPKLecturer ON Lecturer
(
       Lecturer_ID                    ASC
);


ALTER TABLE Lecturer
       ADD  ( PRIMARY KEY (Lecturer_ID) ) ;


CREATE TABLE Phone (
       Phone_ID             NUMBER NOT NULL,
       Phone_Number         VARCHAR2(40) NULL,
       Student              NUMBER NOT NULL
);

CREATE UNIQUE INDEX XPKPhone ON Phone
(
       Phone_ID                       ASC,
       Student                        ASC
);

CREATE INDEX XIF1Phone ON Phone
(
       Student                        ASC
);


ALTER TABLE Phone
       ADD  ( PRIMARY KEY (Phone_ID, Student) ) ;


CREATE TABLE Result (
       Mark                 NUMBER(1) NULL
                                   CHECK (Mark IN (1, 2, 3, 4, 5)),
       Exam_ID              NUMBER NOT NULL,
       Student_ID           NUMBER NOT NULL
);

CREATE UNIQUE INDEX XPKResult ON Result
(
       Exam_ID                        ASC,
       Student_ID                     ASC
);

CREATE INDEX XIF1Result ON Result
(
       Exam_ID                        ASC
);

CREATE INDEX XIF2Result ON Result
(
       Student_ID                     ASC
);


ALTER TABLE Result
       ADD  ( PRIMARY KEY (Exam_ID, Student_ID) ) ;


CREATE TABLE Student (
       Student_ID           NUMBER NOT NULL,
       Last_Name            VARCHAR2(40) NULL,
       First_Name           VARCHAR2(40) NULL,
       Middle_Name          VARCHAR2(40) NULL,
       Birthday             DATE NULL,
       Sex                  CHAR(1) NULL
                                   CHECK (Sex IN ('Ч', 'Ж')),
       Ref                  BLOB NULL,
       Groupa_ID            NUMBER NULL
);

CREATE UNIQUE INDEX XPKStudent ON Student
(
       Student_ID                     ASC
);

CREATE INDEX XIF1Student ON Student
(
       Groupa_ID                      ASC
);


ALTER TABLE Student
       ADD  ( PRIMARY KEY (Student_ID) ) ;


CREATE TABLE Subject (
       Subject_ID           NUMBER NOT NULL,
       Subject_Name         VARCHAR2(40) NULL
);

CREATE UNIQUE INDEX XPKSubject ON Subject
(
       Subject_ID                     ASC
);


ALTER TABLE Subject
       ADD  ( PRIMARY KEY (Subject_ID) ) ;


ALTER TABLE E_mail
       ADD  ( FOREIGN KEY (Student)
                             REFERENCES Student ) ;


ALTER TABLE Exam
       ADD  ( FOREIGN KEY (Lecturer_ID)
                             REFERENCES Lecturer ) ;


ALTER TABLE Exam
       ADD  ( FOREIGN KEY (Subject_ID)
                             REFERENCES Subject
                             ON DELETE SET NULL ) ;


ALTER TABLE Phone
       ADD  ( FOREIGN KEY (Student)
                             REFERENCES Student ) ;


ALTER TABLE Result
       ADD  ( FOREIGN KEY (Student_ID)
                             REFERENCES Student ) ;


ALTER TABLE Result
       ADD  ( FOREIGN KEY (Exam_ID)
                             REFERENCES Exam ) ;


ALTER TABLE Student
       ADD  ( FOREIGN KEY (Groupa_ID)
                             REFERENCES Groupa ) ;




create or replace trigger tI_E_mail after INSERT on E_mail for each row
-- ERwin Builtin Sun May 26 23:01:57 2013
-- INSERT trigger on E_mail 
declare numrows INTEGER;
begin
    /* ERwin Builtin Sun May 26 23:01:57 2013 */
    /* Student R/10 E_mail ON CHILD INSERT RESTRICT */
    /* ERWIN_RELATION:PARENT_OWNER="", PARENT_TABLE="Student"
    CHILD_OWNER="", CHILD_TABLE="E_mail"
    P2C_VERB_PHRASE="R/10", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_10", FK_COLUMNS="Student" */
    select count(*) into numrows
      from Student
      where
        /* %JoinFKPK(:%New,Student," = "," and") */
        :new.Student = Student.Student_ID;
    if (
      /* %NotnullFK(:%New," is not null and") */
      
      numrows = 0
    )
    then
      raise_application_error(
        -20002,
        'Cannot INSERT E_mail because Student does not exist.'
      );
    end if;


-- ERwin Builtin Sun May 26 23:01:57 2013
end;
/

create or replace trigger tD_Exam after DELETE on Exam for each row
-- ERwin Builtin Sun May 26 23:01:57 2013
-- DELETE trigger on Exam 
declare numrows INTEGER;
begin
    /* ERwin Builtin Sun May 26 23:01:57 2013 */
    /* Exam R/8 Result ON PARENT DELETE RESTRICT */
    /* ERWIN_RELATION:PARENT_OWNER="", PARENT_TABLE="Exam"
    CHILD_OWNER="", CHILD_TABLE="Result"
    P2C_VERB_PHRASE="R/8", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_8", FK_COLUMNS="Exam_ID" */
    select count(*) into numrows
      from Result
      where
        /*  %JoinFKPK(Result,:%Old," = "," and") */
        Result.Exam_ID = :old.Exam_ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE Exam because Result exists.'
      );
    end if;


-- ERwin Builtin Sun May 26 23:01:57 2013
end;
/

create or replace trigger tI_Exam after INSERT on Exam for each row
-- ERwin Builtin Sun May 26 23:01:57 2013
-- INSERT trigger on Exam 
declare numrows INTEGER;
begin
    /* ERwin Builtin Sun May 26 23:01:57 2013 */
    /* Lecturer R/3 Exam ON CHILD INSERT RESTRICT */
    /* ERWIN_RELATION:PARENT_OWNER="", PARENT_TABLE="Lecturer"
    CHILD_OWNER="", CHILD_TABLE="Exam"
    P2C_VERB_PHRASE="R/3", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="check", FK_COLUMNS="Lecturer_ID" */
    select count(*) into numrows
      from Lecturer
      where
        /* %JoinFKPK(:%New,Lecturer," = "," and") */
        :new.Lecturer_ID = Lecturer.Lecturer_ID;
    if (
      /* %NotnullFK(:%New," is not null and") */
      :new.Lecturer_ID is not null and
      numrows = 0
    )
    then
      raise_application_error(
        -20002,
        'Cannot INSERT Exam because Lecturer does not exist.'
      );
    end if;

    /* ERwin Builtin Sun May 26 23:01:57 2013 */
    /* Subject R/2 Exam ON CHILD INSERT RESTRICT */
    /* ERWIN_RELATION:PARENT_OWNER="", PARENT_TABLE="Subject"
    CHILD_OWNER="", CHILD_TABLE="Exam"
    P2C_VERB_PHRASE="R/2", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="suspect", FK_COLUMNS="Subject_ID" */
    select count(*) into numrows
      from Subject
      where
        /* %JoinFKPK(:%New,Subject," = "," and") */
        :new.Subject_ID = Subject.Subject_ID;
    if (
      /* %NotnullFK(:%New," is not null and") */
      :new.Subject_ID is not null and
      numrows = 0
    )
    then
      raise_application_error(
        -20002,
        'Cannot INSERT Exam because Subject does not exist.'
      );
    end if;


-- ERwin Builtin Sun May 26 23:01:57 2013
end;
/

create or replace trigger tD_Groupa after DELETE on Groupa for each row
-- ERwin Builtin Sun May 26 23:01:57 2013
-- DELETE trigger on Groupa 
declare numrows INTEGER;
begin
    /* ERwin Builtin Sun May 26 23:01:57 2013 */
    /* Groupa R/4 Student ON PARENT DELETE RESTRICT */
    /* ERWIN_RELATION:PARENT_OWNER="", PARENT_TABLE="Groupa"
    CHILD_OWNER="", CHILD_TABLE="Student"
    P2C_VERB_PHRASE="R/4", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="study_at", FK_COLUMNS="Groupa_ID" */
    select count(*) into numrows
      from Student
      where
        /*  %JoinFKPK(Student,:%Old," = "," and") */
        Student.Groupa_ID = :old.Groupa_ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE Groupa because Student exists.'
      );
    end if;


-- ERwin Builtin Sun May 26 23:01:57 2013
end;
/

create or replace trigger tD_Lecturer after DELETE on Lecturer for each row
-- ERwin Builtin Sun May 26 23:01:57 2013
-- DELETE trigger on Lecturer 
declare numrows INTEGER;
begin
    /* ERwin Builtin Sun May 26 23:01:57 2013 */
    /* Lecturer R/3 Exam ON PARENT DELETE RESTRICT */
    /* ERWIN_RELATION:PARENT_OWNER="", PARENT_TABLE="Lecturer"
    CHILD_OWNER="", CHILD_TABLE="Exam"
    P2C_VERB_PHRASE="R/3", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="check", FK_COLUMNS="Lecturer_ID" */
    select count(*) into numrows
      from Exam
      where
        /*  %JoinFKPK(Exam,:%Old," = "," and") */
        Exam.Lecturer_ID = :old.Lecturer_ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE Lecturer because Exam exists.'
      );
    end if;


-- ERwin Builtin Sun May 26 23:01:57 2013
end;
/

create or replace trigger tI_Phone after INSERT on Phone for each row
-- ERwin Builtin Sun May 26 23:01:57 2013
-- INSERT trigger on Phone 
declare numrows INTEGER;
begin
    /* ERwin Builtin Sun May 26 23:01:57 2013 */
    /* Student R/11 Phone ON CHILD INSERT RESTRICT */
    /* ERWIN_RELATION:PARENT_OWNER="", PARENT_TABLE="Student"
    CHILD_OWNER="", CHILD_TABLE="Phone"
    P2C_VERB_PHRASE="R/11", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_11", FK_COLUMNS="Student" */
    select count(*) into numrows
      from Student
      where
        /* %JoinFKPK(:%New,Student," = "," and") */
        :new.Student = Student.Student_ID;
    if (
      /* %NotnullFK(:%New," is not null and") */
      
      numrows = 0
    )
    then
      raise_application_error(
        -20002,
        'Cannot INSERT Phone because Student does not exist.'
      );
    end if;


-- ERwin Builtin Sun May 26 23:01:57 2013
end;
/

create or replace trigger tI_Result after INSERT on Result for each row
-- ERwin Builtin Sun May 26 23:01:57 2013
-- INSERT trigger on Result 
declare numrows INTEGER;
begin
    /* ERwin Builtin Sun May 26 23:01:57 2013 */
    /* Student R/9 Result ON CHILD INSERT RESTRICT */
    /* ERWIN_RELATION:PARENT_OWNER="", PARENT_TABLE="Student"
    CHILD_OWNER="", CHILD_TABLE="Result"
    P2C_VERB_PHRASE="R/9", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_9", FK_COLUMNS="Student_ID" */
    select count(*) into numrows
      from Student
      where
        /* %JoinFKPK(:%New,Student," = "," and") */
        :new.Student_ID = Student.Student_ID;
    if (
      /* %NotnullFK(:%New," is not null and") */
      
      numrows = 0
    )
    then
      raise_application_error(
        -20002,
        'Cannot INSERT Result because Student does not exist.'
      );
    end if;

    /* ERwin Builtin Sun May 26 23:01:57 2013 */
    /* Exam R/8 Result ON CHILD INSERT RESTRICT */
    /* ERWIN_RELATION:PARENT_OWNER="", PARENT_TABLE="Exam"
    CHILD_OWNER="", CHILD_TABLE="Result"
    P2C_VERB_PHRASE="R/8", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_8", FK_COLUMNS="Exam_ID" */
    select count(*) into numrows
      from Exam
      where
        /* %JoinFKPK(:%New,Exam," = "," and") */
        :new.Exam_ID = Exam.Exam_ID;
    if (
      /* %NotnullFK(:%New," is not null and") */
      
      numrows = 0
    )
    then
      raise_application_error(
        -20002,
        'Cannot INSERT Result because Exam does not exist.'
      );
    end if;


-- ERwin Builtin Sun May 26 23:01:57 2013
end;
/

create or replace trigger tD_Student after DELETE on Student for each row
-- ERwin Builtin Sun May 26 23:01:57 2013
-- DELETE trigger on Student 
declare numrows INTEGER;
begin
    /* ERwin Builtin Sun May 26 23:01:57 2013 */
    /* Student R/11 Phone ON PARENT DELETE RESTRICT */
    /* ERWIN_RELATION:PARENT_OWNER="", PARENT_TABLE="Student"
    CHILD_OWNER="", CHILD_TABLE="Phone"
    P2C_VERB_PHRASE="R/11", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_11", FK_COLUMNS="Student" */
    select count(*) into numrows
      from Phone
      where
        /*  %JoinFKPK(Phone,:%Old," = "," and") */
        Phone.Student = :old.Student_ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE Student because Phone exists.'
      );
    end if;

    /* ERwin Builtin Sun May 26 23:01:57 2013 */
    /* Student R/10 E_mail ON PARENT DELETE RESTRICT */
    /* ERWIN_RELATION:PARENT_OWNER="", PARENT_TABLE="Student"
    CHILD_OWNER="", CHILD_TABLE="E_mail"
    P2C_VERB_PHRASE="R/10", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_10", FK_COLUMNS="Student" */
    select count(*) into numrows
      from E_mail
      where
        /*  %JoinFKPK(E_mail,:%Old," = "," and") */
        E_mail.Student = :old.Student_ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE Student because E_mail exists.'
      );
    end if;

    /* ERwin Builtin Sun May 26 23:01:57 2013 */
    /* Student R/9 Result ON PARENT DELETE RESTRICT */
    /* ERWIN_RELATION:PARENT_OWNER="", PARENT_TABLE="Student"
    CHILD_OWNER="", CHILD_TABLE="Result"
    P2C_VERB_PHRASE="R/9", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="R_9", FK_COLUMNS="Student_ID" */
    select count(*) into numrows
      from Result
      where
        /*  %JoinFKPK(Result,:%Old," = "," and") */
        Result.Student_ID = :old.Student_ID;
    if (numrows > 0)
    then
      raise_application_error(
        -20001,
        'Cannot DELETE Student because Result exists.'
      );
    end if;


-- ERwin Builtin Sun May 26 23:01:57 2013
end;
/

create or replace trigger tI_Student after INSERT on Student for each row
-- ERwin Builtin Sun May 26 23:01:57 2013
-- INSERT trigger on Student 
declare numrows INTEGER;
begin
    /* ERwin Builtin Sun May 26 23:01:57 2013 */
    /* Groupa R/4 Student ON CHILD INSERT RESTRICT */
    /* ERWIN_RELATION:PARENT_OWNER="", PARENT_TABLE="Groupa"
    CHILD_OWNER="", CHILD_TABLE="Student"
    P2C_VERB_PHRASE="R/4", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="study_at", FK_COLUMNS="Groupa_ID" */
    select count(*) into numrows
      from Groupa
      where
        /* %JoinFKPK(:%New,Groupa," = "," and") */
        :new.Groupa_ID = Groupa.Groupa_ID;
    if (
      /* %NotnullFK(:%New," is not null and") */
      :new.Groupa_ID is not null and
      numrows = 0
    )
    then
      raise_application_error(
        -20002,
        'Cannot INSERT Student because Groupa does not exist.'
      );
    end if;


-- ERwin Builtin Sun May 26 23:01:57 2013
end;
/

create or replace trigger tD_Subject after DELETE on Subject for each row
-- ERwin Builtin Sun May 26 23:01:57 2013
-- DELETE trigger on Subject 
declare numrows INTEGER;
begin
    /* ERwin Builtin Sun May 26 23:01:57 2013 */
    /* Subject R/2 Exam ON PARENT DELETE SET NULL */
    /* ERWIN_RELATION:PARENT_OWNER="", PARENT_TABLE="Subject"
    CHILD_OWNER="", CHILD_TABLE="Exam"
    P2C_VERB_PHRASE="R/2", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="suspect", FK_COLUMNS="Subject_ID" */
    update Exam
      set
        /* %SetFK(Exam,NULL) */
        Exam.Subject_ID = NULL
      where
        /* %JoinFKPK(Exam,:%Old," = "," and") */
        Exam.Subject_ID = :old.Subject_ID;


-- ERwin Builtin Sun May 26 23:01:57 2013
end;
/

create or replace trigger tU_Subject after UPDATE on Subject for each row
-- ERwin Builtin Sun May 26 23:01:57 2013
-- UPDATE trigger on Subject 
declare numrows INTEGER;
begin
  /* Subject R/2 Exam ON PARENT UPDATE SET NULL */
  /* ERWIN_RELATION:PARENT_OWNER="", PARENT_TABLE="Subject"
    CHILD_OWNER="", CHILD_TABLE="Exam"
    P2C_VERB_PHRASE="R/2", C2P_VERB_PHRASE="", 
    FK_CONSTRAINT="suspect", FK_COLUMNS="Subject_ID" */
  if
    /* %JoinPKPK(:%Old,:%New," <> "," or ") */
    :old.Subject_ID <> :new.Subject_ID
  then
    update Exam
      set
        /* %SetFK(Exam,NULL) */
        Exam.Subject_ID = NULL
      where
        /* %JoinFKPK(Exam,:%Old," = ",",") */
        Exam.Subject_ID = :old.Subject_ID;
  end if;


-- ERwin Builtin Sun May 26 23:01:57 2013
end;
/

create sequence SEQ_E_mail
minvalue 0
maxvalue 999999999
start with 1
increment by 1
cache 20;

create or replace trigger T_ID_E_mail
  before insert on E_mail  
  for each row
declare
 
begin
SELECT SEQ_E_mail.nextval INTO :new.E_mail_ID
FROM DUAL;

end TIS_E_mail;
/ -- розділювач тригерів

create sequence SEQ_Exam
minvalue 0
maxvalue 999999999
start with 1
increment by 1
cache 20;

create or replace trigger T_ID_Exam
  before insert on Exam  
  for each row
declare
 
begin
SELECT SEQ_Exam.nextval INTO :new.Exam_ID
FROM DUAL;

end TIS_Exam;
/ -- розділювач тригерів

create sequence SEQ_Groupa
minvalue 0
maxvalue 999999999
start with 1
increment by 1
cache 20;

create or replace trigger T_ID_Groupa
  before insert on Groupa  
  for each row
declare
 
begin
SELECT SEQ_Groupa.nextval INTO :new.Groupa_ID
FROM DUAL;

end TIS_Groupa;
/ -- розділювач тригерів

create sequence SEQ_Lecturer
minvalue 0
maxvalue 999999999
start with 1
increment by 1
cache 20;

create or replace trigger T_ID_Lecturer
  before insert on Lecturer  
  for each row
declare
 
begin
SELECT SEQ_Lecturer.nextval INTO :new.Lecturer_ID
FROM DUAL;

end TIS_Lecturer;
/ -- розділювач тригерів

create sequence SEQ_Phone
minvalue 0
maxvalue 999999999
start with 1
increment by 1
cache 20;

create or replace trigger T_ID_Phone
  before insert on Phone  
  for each row
declare
 
begin
SELECT SEQ_Phone.nextval INTO :new.Phone_ID
FROM DUAL;

end TIS_Phone;
/ -- розділювач тригерів

create sequence SEQ_Result
minvalue 0
maxvalue 999999999
start with 1
increment by 1
cache 20;

create or replace trigger T_ID_Result
  before insert on Result  
  for each row
declare
 
begin
SELECT SEQ_Result.nextval INTO :new.Result_ID
FROM DUAL;

end TIS_Result;
/ -- розділювач тригерів

create sequence SEQ_Student
minvalue 0
maxvalue 999999999
start with 1
increment by 1
cache 20;

create or replace trigger T_ID_Student
  before insert on Student  
  for each row
declare
 
begin
SELECT SEQ_Student.nextval INTO :new.Student_ID
FROM DUAL;

end TIS_Student;
/ -- розділювач тригерів

create sequence SEQ_Subject
minvalue 0
maxvalue 999999999
start with 1
increment by 1
cache 20;

create or replace trigger T_ID_Subject
  before insert on Subject  
  for each row
declare
 
begin
SELECT SEQ_Subject.nextval INTO :new.Subject_ID
FROM DUAL;

end TIS_Subject;
/ -- розділювач тригерів



create sequence SEQ_E_mail
minvalue 0
maxvalue 999999999
start with 1
increment by 1
cache 20;

create or replace trigger T_ID_E_mail
  before insert on E_mail  
  for each row
declare
 
begin
SELECT SEQ_E_mail.nextval INTO :new.E_mail_ID
FROM DUAL;

end TIS_E_mail;
/ -- розділювач тригерів

create sequence SEQ_Exam
minvalue 0
maxvalue 999999999
start with 1
increment by 1
cache 20;

create or replace trigger T_ID_Exam
  before insert on Exam  
  for each row
declare
 
begin
SELECT SEQ_Exam.nextval INTO :new.Exam_ID
FROM DUAL;

end TIS_Exam;
/ -- розділювач тригерів

create sequence SEQ_Groupa
minvalue 0
maxvalue 999999999
start with 1
increment by 1
cache 20;

create or replace trigger T_ID_Groupa
  before insert on Groupa  
  for each row
declare
 
begin
SELECT SEQ_Groupa.nextval INTO :new.Groupa_ID
FROM DUAL;

end TIS_Groupa;
/ -- розділювач тригерів

create sequence SEQ_Lecturer
minvalue 0
maxvalue 999999999
start with 1
increment by 1
cache 20;

create or replace trigger T_ID_Lecturer
  before insert on Lecturer  
  for each row
declare
 
begin
SELECT SEQ_Lecturer.nextval INTO :new.Lecturer_ID
FROM DUAL;

end TIS_Lecturer;
/ -- розділювач тригерів

create sequence SEQ_Phone
minvalue 0
maxvalue 999999999
start with 1
increment by 1
cache 20;

create or replace trigger T_ID_Phone
  before insert on Phone  
  for each row
declare
 
begin
SELECT SEQ_Phone.nextval INTO :new.Phone_ID
FROM DUAL;

end TIS_Phone;
/ -- розділювач тригерів

create sequence SEQ_Result
minvalue 0
maxvalue 999999999
start with 1
increment by 1
cache 20;

create or replace trigger T_ID_Result
  before insert on Result  
  for each row
declare
 
begin
SELECT SEQ_Result.nextval INTO :new.Result_ID
FROM DUAL;

end TIS_Result;
/ -- розділювач тригерів

create sequence SEQ_Student
minvalue 0
maxvalue 999999999
start with 1
increment by 1
cache 20;

create or replace trigger T_ID_Student
  before insert on Student  
  for each row
declare
 
begin
SELECT SEQ_Student.nextval INTO :new.Student_ID
FROM DUAL;

end TIS_Student;
/ -- розділювач тригерів

create sequence SEQ_Subject
minvalue 0
maxvalue 999999999
start with 1
increment by 1
cache 20;

create or replace trigger T_ID_Subject
  before insert on Subject  
  for each row
declare
 
begin
SELECT SEQ_Subject.nextval INTO :new.Subject_ID
FROM DUAL;

end TIS_Subject;
/ -- розділювач тригерів



