--  *********************************************************************
--  Update Database Script
--  *********************************************************************
--  Change Log: changelog/db.changelog-master.xml
--  Ran at: 7/28/17 7:12 AM
--  Against: localhost@localhost@jdbc:mysql://127.0.0.1:3306?useUnicode=true&characterEncoding=UTF-8
--  Liquibase version: 3.4.2
--  *********************************************************************

--  Create Database Lock Table
CREATE TABLE api_tasks.DATABASECHANGELOGLOCK (ID INT NOT NULL, LOCKED BIT(1) NOT NULL, LOCKGRANTED datetime NULL, LOCKEDBY VARCHAR(255) NULL, CONSTRAINT PK_DATABASECHANGELOGLOCK PRIMARY KEY (ID));

--  Initialize Database Lock Table
DELETE FROM api_tasks.DATABASECHANGELOGLOCK;

INSERT INTO api_tasks.DATABASECHANGELOGLOCK (ID, LOCKED) VALUES (1, 0);

--  Lock Database
UPDATE api_tasks.DATABASECHANGELOGLOCK SET LOCKED = 1, LOCKEDBY = '10.0.1.33 (10.0.1.33)', LOCKGRANTED = '2017-07-28 07:12:41.288' WHERE ID = 1 AND LOCKED = 0;

--  Create Database Change Log Table
CREATE TABLE api_tasks.DATABASECHANGELOG (ID VARCHAR(255) NOT NULL, AUTHOR VARCHAR(255) NOT NULL, FILENAME VARCHAR(255) NOT NULL, DATEEXECUTED datetime NOT NULL, ORDEREXECUTED INT NOT NULL, EXECTYPE VARCHAR(10) NOT NULL, MD5SUM VARCHAR(35) NULL, DESCRIPTION VARCHAR(255) NULL, COMMENTS VARCHAR(255) NULL, TAG VARCHAR(255) NULL, LIQUIBASE VARCHAR(20) NULL, CONTEXTS VARCHAR(255) NULL, LABELS VARCHAR(255) NULL);

--  Changeset changelog/api/api-1.0.xml::1::mauricio.schmitz
ALTER TABLE api_tasks.DATABASECHANGELOGLOCK MODIFY locked TINYINT UNSIGNED;

INSERT INTO api_tasks.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE) VALUES ('1', 'mauricio.schmitz', 'changelog/api/api-1.0.xml', NOW(), 1, '7:bd8da1ab0c184103acd706eca7f895e6', 'modifyDataType', '', 'EXECUTED', NULL, NULL, '3.4.2');

--  Changeset changelog/api/api-1.0.xml::2::mauricio.schmitz
ALTER TABLE api_tasks.DATABASECHANGELOG ADD PRIMARY KEY (ORDEREXECUTED);

INSERT INTO api_tasks.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE) VALUES ('2', 'mauricio.schmitz', 'changelog/api/api-1.0.xml', NOW(), 2, '7:f5a7341323fbc6bb777261e697cd921d', 'addPrimaryKey', '', 'EXECUTED', NULL, NULL, '3.4.2');

--  Changeset changelog/api/api-1.0.xml::3::mauricio.schmitz
CREATE TABLE api_tasks.users (id INT UNSIGNED AUTO_INCREMENT NOT NULL, name VARCHAR(255) NOT NULL, email VARCHAR(255) NOT NULL, password VARCHAR(255) NOT NULL, apikey VARCHAR(100) NOT NULL, active TINYINT UNSIGNED DEFAULT 1 NOT NULL, created_at timestamp NULL, updated_at timestamp NULL, CONSTRAINT PK_USERS PRIMARY KEY (id));

INSERT INTO api_tasks.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE) VALUES ('3', 'mauricio.schmitz', 'changelog/api/api-1.0.xml', NOW(), 3, '7:fb371ac33d34f98a2b2b76ea13478915', 'createTable', '', 'EXECUTED', NULL, NULL, '3.4.2');

--  Changeset changelog/api/api-1.0.xml::4::mauricio.schmitz
ALTER TABLE api_tasks.users ADD CONSTRAINT users_email_unique UNIQUE (email);

INSERT INTO api_tasks.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE) VALUES ('4', 'mauricio.schmitz', 'changelog/api/api-1.0.xml', NOW(), 4, '7:9a347d0d96c54c02652297b3889cd754', 'addUniqueConstraint', '', 'EXECUTED', NULL, NULL, '3.4.2');

--  Changeset changelog/api/api-1.0.xml::5::mauricio.schmitz
CREATE TABLE api_tasks.tasks (id INT UNSIGNED AUTO_INCREMENT NOT NULL, user_id INT UNSIGNED NOT NULL, title VARCHAR(255) NOT NULL, description TEXT NOT NULL, done TINYINT UNSIGNED DEFAULT 0 NOT NULL, sequence INT UNSIGNED NULL, created_at timestamp NULL, updated_at timestamp NULL, CONSTRAINT PK_TASKS PRIMARY KEY (id));

INSERT INTO api_tasks.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE) VALUES ('5', 'mauricio.schmitz', 'changelog/api/api-1.0.xml', NOW(), 5, '7:cf3530a9532a6f3fd11eeda6f4f309bf', 'createTable', '', 'EXECUTED', NULL, NULL, '3.4.2');

--  Changeset changelog/api/api-1.0.xml::6::mauricio.schmitz
CREATE INDEX `fk_task$use$user_id_idx` ON api_tasks.tasks(user_id);

INSERT INTO api_tasks.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE) VALUES ('6', 'mauricio.schmitz', 'changelog/api/api-1.0.xml', NOW(), 6, '7:163bc250695939780f5e60d57cb149d9', 'createIndex', '', 'EXECUTED', NULL, NULL, '3.4.2');

--  Changeset changelog/api/api-1.0.xml::7::mauricio.schmitz
ALTER TABLE api_tasks.tasks ADD CONSTRAINT `fk_task$use$user_id` FOREIGN KEY (user_id) REFERENCES api_tasks.users (id) ON UPDATE NO ACTION ON DELETE NO ACTION;

INSERT INTO api_tasks.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE) VALUES ('7', 'mauricio.schmitz', 'changelog/api/api-1.0.xml', NOW(), 7, '7:6f1a30ece87c652d69d721c9986e11f8', 'addForeignKeyConstraint', '', 'EXECUTED', NULL, NULL, '3.4.2');

--  Changeset changelog/api/api-1.0.xml::8::mauricio.schmitz
INSERT INTO api_tasks.users (name, email, password, apikey) VALUES ('User 1', 'user1@user.com.br', '$2y$10$81JksrkLkrRSTEDoGlM.9uMrXgQT4eKmLdtytnUlJphqKfG6WZGOW', '356a192b7913b04c54574d18c28d46e6395428ab');

INSERT INTO api_tasks.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE) VALUES ('8', 'mauricio.schmitz', 'changelog/api/api-1.0.xml', NOW(), 8, '7:1a05a6d4c08abe6ee1edc5c1d24edf81', 'insert', '', 'EXECUTED', NULL, NULL, '3.4.2');

--  Changeset changelog/api/api-1.0.xml::9::mauricio.schmitz
INSERT INTO api_tasks.users (name, email, password, apikey) VALUES ('User 2', 'user2@user.com.br', '$2y$10$81JksrkLkrRSTEDoGlM.9uMrXgQT4eKmLdtytnUlJphqKfG6WZGOW', 'da4b9237bacccdf19c0760cab7aec4a8359010b0');

INSERT INTO api_tasks.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE) VALUES ('9', 'mauricio.schmitz', 'changelog/api/api-1.0.xml', NOW(), 9, '7:ddef6c16ab2c62783587ee4edfb270e9', 'insert', '', 'EXECUTED', NULL, NULL, '3.4.2');

--  Changeset changelog/api/api-1.0.xml::10::mauricio.schmitz
INSERT INTO api_tasks.users (name, email, password, apikey) VALUES ('User 3', 'user3@user.com.br', '$2y$10$81JksrkLkrRSTEDoGlM.9uMrXgQT4eKmLdtytnUlJphqKfG6WZGOW', '77de68daecd823babbb58edb1c8e14d7106e83bb');

INSERT INTO api_tasks.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE) VALUES ('10', 'mauricio.schmitz', 'changelog/api/api-1.0.xml', NOW(), 10, '7:74b50340e5dd057f2ce1e90df874d008', 'insert', '', 'EXECUTED', NULL, NULL, '3.4.2');

--  Changeset changelog/api/api-1.0.xml::11::mauricio.schmitz
INSERT INTO api_tasks.users (name, email, password, apikey) VALUES ('User 4', 'user4@user.com.br', '$2y$10$81JksrkLkrRSTEDoGlM.9uMrXgQT4eKmLdtytnUlJphqKfG6WZGOW', '1b6453892473a467d07372d45eb05abc2031647a');

INSERT INTO api_tasks.DATABASECHANGELOG (ID, AUTHOR, FILENAME, DATEEXECUTED, ORDEREXECUTED, MD5SUM, DESCRIPTION, COMMENTS, EXECTYPE, CONTEXTS, LABELS, LIQUIBASE) VALUES ('11', 'mauricio.schmitz', 'changelog/api/api-1.0.xml', NOW(), 11, '7:11a76a68f69a705448fcf19d8a88b0f2', 'insert', '', 'EXECUTED', NULL, NULL, '3.4.2');

--  Release Database Lock
UPDATE api_tasks.DATABASECHANGELOGLOCK SET LOCKED = 0, LOCKEDBY = NULL, LOCKGRANTED = NULL WHERE ID = 1;

