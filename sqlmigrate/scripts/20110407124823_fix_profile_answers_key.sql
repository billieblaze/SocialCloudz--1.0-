--// fix_profile_answers_key
-- Migration SQL that makes the change goes here.

ALTER TABLE `members`.`profileAnswers` 
DROP PRIMARY KEY , ADD PRIMARY KEY USING BTREE (`questionID`, `memberID`, `answerSet`) ;

--//@UNDO
-- SQL to undo the change goes here.



