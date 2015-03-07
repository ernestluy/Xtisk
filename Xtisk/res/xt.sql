/* SQLEditor (SQLite)*/



CREATE TABLE USER_ADDRESS
(
id INTEGER PRIMARY KEY  AUTOINCREMENT,
ADDRESS_ID TEXT,
OWNER  TEXT,
USER_ID TEXT REFERENCES PIM_USER (USER_ID),
NAME_CARD_ID		varchar(40) ,
PRIORITY			smallint default 0,
CONTENT				varchar(200) ,
MEMO				varchar(4000),
TYPE INTEGER,
WORK_PLACE TEXT,
POSITION TEXT,
ENABLED INTEGER
);


create table SYNC_RESULT(
	_id				     INTEGER primary key autoincrement,
	RESPONSE			 varchar(40)    not null,
	ACCOUNT_ID           varchar(20) ,
	RESULT				 smallint       not null default 0,
	MESSAGE				 varchar(40),
	SYNC_TIMESTAMP		 varchar(20)
);

create table PIM_CONTACT(
	_id					 INTEGER primary key autoincrement,
   	CONTACT_ID           varchar(100) not null,
	USER_ID				 varchar(40) not null ,
   	TYPE                 smallint not null default 0 ,
	CONTENT              varchar(200) ,
	COUNTRY_CODE         varchar(10),
	AREA_CODE            varchar(10),
   	EXTENSION            varchar(10),
   	ENABLED              smallint not null default 1  ,
   	PRIORITY             varchar(200) ,
   	CREATED_BY           varchar(40) ,
   	CREATED_DATE         varchar(20) ,
   	LAST_UPDATED_BY      varchar(40),
   	LAST_UPDATED_DATE    varchar(20)
);


/*ishekou*/
create table push_msg(
sid					 INTEGER primary key autoincrement,
pid					 INTEGER,
type                 varchar(10),
content			     varchar(500),
account              varchar(40),
loc_create_date      varchar(20),
dateCreate           varchar(20)
);