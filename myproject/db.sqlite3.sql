BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "API_cargo" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"nombre"	varchar(60) NOT NULL,
	"status"	varchar(10) NOT NULL,
	"id_departamento_id"	integer NOT NULL,
	FOREIGN KEY("id_departamento_id") REFERENCES "API_departamento"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "API_cliente" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"id_persona_id"	integer NOT NULL,
	FOREIGN KEY("id_persona_id") REFERENCES "API_persona"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "API_detalle" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"cantidadVendida"	integer unsigned NOT NULL CHECK("cantidadVendida">=0),
	"precioVenta"	decimal NOT NULL,
	"id_cliente_id"	integer NOT NULL,
	"id_empleado_id"	integer NOT NULL,
	"id_factura_id"	integer NOT NULL,
	"id_producto_id"	integer NOT NULL,
	FOREIGN KEY("id_producto_id") REFERENCES "API_producto"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("id_cliente_id") REFERENCES "API_cliente"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("id_empleado_id") REFERENCES "API_empleado"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("id_factura_id") REFERENCES "API_factura"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "API_empleado" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"id_cargo_id"	integer NOT NULL,
	"id_persona_id"	integer NOT NULL,
	"id_sucursal_id"	integer NOT NULL,
	FOREIGN KEY("id_cargo_id") REFERENCES "API_cargo"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("id_persona_id") REFERENCES "API_persona"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("id_sucursal_id") REFERENCES "API_sucursal"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "API_factura" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"fec_creacion"	date NOT NULL,
	"id_cliente_id"	integer NOT NULL,
	"id_departamento_id"	integer NOT NULL,
	"id_empleado_id"	integer NOT NULL,
	"id_sucursal_id"	integer NOT NULL,
	FOREIGN KEY("id_cliente_id") REFERENCES "API_cliente"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("id_departamento_id") REFERENCES "API_departamento"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("id_empleado_id") REFERENCES "API_empleado"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("id_sucursal_id") REFERENCES "API_sucursal"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "API_producto" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"nombre"	varchar(60) NOT NULL,
	"fec_elaboracion"	date NOT NULL,
	"precio_compra"	decimal NOT NULL,
	"precio_venta"	decimal NOT NULL,
	"stock"	integer unsigned NOT NULL CHECK("stock">=0),
	"fec_vencimiento"	date NOT NULL,
	"status"	varchar(10) NOT NULL,
	"id_producto_id"	integer NOT NULL,
	FOREIGN KEY("id_producto_id") REFERENCES "API_tipoproducto"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "API_telefono" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"numero_telefono"	varchar(20) NOT NULL,
	"id_persona_id"	integer NOT NULL,
	"id_tipo_id"	integer NOT NULL,
	FOREIGN KEY("id_tipo_id") REFERENCES "API_tipotelefono"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("id_persona_id") REFERENCES "API_persona"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "API_tipotelefono" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"nombre"	varchar(60) NOT NULL
);
CREATE TABLE IF NOT EXISTS "API_tipoproducto" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"nombre"	varchar(60) NOT NULL,
	"descripcion"	varchar(60) NOT NULL
);
CREATE TABLE IF NOT EXISTS "API_sucursal" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"nombre"	varchar(60) NOT NULL,
	"direccion"	varchar(60) NOT NULL,
	"telefono"	varchar(60) NOT NULL,
	"status"	varchar(10) NOT NULL
);
CREATE TABLE IF NOT EXISTS "API_proveedor" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"nombre"	varchar(60) NOT NULL,
	"id_persona_id"	integer NOT NULL,
	FOREIGN KEY("id_persona_id") REFERENCES "API_persona"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "API_persona" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"nombre"	varchar(60) NOT NULL,
	"apellido"	varchar(60) NOT NULL,
	"cedula"	varchar(25) NOT NULL,
	"direccion"	varchar(60) NOT NULL,
	"fec_creacion"	date NOT NULL,
	"usuario"	varchar(60) NOT NULL,
	"correo"	varchar(60) NOT NULL
);
CREATE TABLE IF NOT EXISTS "API_departamento" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"nombre"	varchar(60) NOT NULL,
	"status"	varchar(10) NOT NULL
);
CREATE TABLE IF NOT EXISTS "socialaccount_socialaccount" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"provider"	varchar(30) NOT NULL,
	"uid"	varchar(191) NOT NULL,
	"last_login"	datetime NOT NULL,
	"date_joined"	datetime NOT NULL,
	"user_id"	integer NOT NULL,
	"extra_data"	text NOT NULL,
	FOREIGN KEY("user_id") REFERENCES "API_account"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "socialaccount_socialapp" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"provider"	varchar(30) NOT NULL,
	"name"	varchar(40) NOT NULL,
	"client_id"	varchar(191) NOT NULL,
	"key"	varchar(191) NOT NULL,
	"secret"	varchar(191) NOT NULL
);
CREATE TABLE IF NOT EXISTS "socialaccount_socialtoken" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"token"	text NOT NULL,
	"token_secret"	text NOT NULL,
	"expires_at"	datetime,
	"account_id"	integer NOT NULL,
	"app_id"	integer NOT NULL,
	FOREIGN KEY("account_id") REFERENCES "socialaccount_socialaccount"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("app_id") REFERENCES "socialaccount_socialapp"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "socialaccount_socialapp_sites" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"socialapp_id"	integer NOT NULL,
	"site_id"	integer NOT NULL,
	FOREIGN KEY("socialapp_id") REFERENCES "socialaccount_socialapp"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("site_id") REFERENCES "django_site"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_site" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"name"	varchar(50) NOT NULL,
	"domain"	varchar(100) NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS "account_emailaddress" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"verified"	bool NOT NULL,
	"primary"	bool NOT NULL,
	"user_id"	integer NOT NULL,
	"email"	varchar(254) NOT NULL UNIQUE,
	FOREIGN KEY("user_id") REFERENCES "API_account"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "account_emailconfirmation" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"created"	datetime NOT NULL,
	"sent"	datetime,
	"key"	varchar(64) NOT NULL UNIQUE,
	"email_address_id"	integer NOT NULL,
	FOREIGN KEY("email_address_id") REFERENCES "account_emailaddress"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_session" (
	"session_key"	varchar(40) NOT NULL,
	"session_data"	text NOT NULL,
	"expire_date"	datetime NOT NULL,
	PRIMARY KEY("session_key")
);
CREATE TABLE IF NOT EXISTS "authtoken_token" (
	"key"	varchar(40) NOT NULL,
	"created"	datetime NOT NULL,
	"user_id"	integer NOT NULL UNIQUE,
	PRIMARY KEY("key"),
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_group" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"name"	varchar(150) NOT NULL UNIQUE
);
CREATE TABLE IF NOT EXISTS "auth_user" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"password"	varchar(128) NOT NULL,
	"last_login"	datetime,
	"is_superuser"	bool NOT NULL,
	"username"	varchar(150) NOT NULL UNIQUE,
	"first_name"	varchar(30) NOT NULL,
	"email"	varchar(254) NOT NULL,
	"is_staff"	bool NOT NULL,
	"is_active"	bool NOT NULL,
	"date_joined"	datetime NOT NULL,
	"last_name"	varchar(150) NOT NULL
);
CREATE TABLE IF NOT EXISTS "auth_permission" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"content_type_id"	integer NOT NULL,
	"codename"	varchar(100) NOT NULL,
	"name"	varchar(255) NOT NULL,
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_content_type" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"app_label"	varchar(100) NOT NULL,
	"model"	varchar(100) NOT NULL
);
CREATE TABLE IF NOT EXISTS "django_admin_log" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"action_time"	datetime NOT NULL,
	"object_id"	text,
	"object_repr"	varchar(200) NOT NULL,
	"change_message"	text NOT NULL,
	"content_type_id"	integer,
	"user_id"	integer NOT NULL,
	"action_flag"	smallint unsigned NOT NULL CHECK("action_flag">=0),
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_user_user_permissions" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"user_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_user_groups" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"user_id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "auth_group_permissions" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"group_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED
);
CREATE TABLE IF NOT EXISTS "django_migrations" (
	"id"	integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	"app"	varchar(255) NOT NULL,
	"name"	varchar(255) NOT NULL,
	"applied"	datetime NOT NULL
);
INSERT INTO "django_site" VALUES (1,'example.com','example.com');
INSERT INTO "django_session" VALUES ('ad3xtf94u6qvuerliqcp7utgtjdumsfr','MDJiM2ExMTg2YWJhZjdlZDJlZjA2MDdiMjlhNTg0MDA0OGY1NDc0Yzp7Il9zZXNzaW9uX2V4cGlyeSI6MH0=','2020-02-14 03:39:24.945207');
INSERT INTO "django_session" VALUES ('uzetnqrocrnckxth0l8wkqwq6bmv62z6','NTI1M2ZjZDQ0OTRkYjg5NTNjNjQ0OWVlZGNkMmJiNjNkYWMzOWU4Mjp7Il9hdXRoX3VzZXJfaWQiOiIzIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiI1NDM1YWI0ZWRjOWZkMWUwM2VhNzNiYTM0NTJmOTkzOGZhMzMwMmVjIn0=','2020-02-16 03:24:12.509174');
INSERT INTO "django_session" VALUES ('iib4fnvayzjve6dsch85z8x6hawe32np','NGIwNWMxY2MwODhkYTdhODAzNzEzM2M4YWYyNmQzYTVlNjhiN2U2YTp7Il9hdXRoX3VzZXJfaWQiOiIyIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiIyMGZjYWJkN2JjYWEzNTVkM2I1NmZmZTE2MzdhNzg1ZmI0NDhiMjlkIn0=','2020-03-06 02:51:38.730915');
INSERT INTO "authtoken_token" VALUES ('da28bfc38140231aa33e719d90badcc4b8e8b540','2019-10-18 17:06:05.355498',1);
INSERT INTO "authtoken_token" VALUES ('f1505ef12705498710c99374813c5afede9cb0dc','2020-01-29 04:42:19.544452',2);
INSERT INTO "authtoken_token" VALUES ('cd834a3c822426841ecc216cd0bbae8cba692e01','2020-02-04 02:03:03.768515',4);
INSERT INTO "authtoken_token" VALUES ('74f219d1092c200f591249d46727386e8f07b22c','2020-02-21 03:03:14.723144',3);
INSERT INTO "authtoken_token" VALUES ('174304bfbb90223cb99d372c6ade9e92cdde4909','2020-03-06 03:42:36.674912',5);
INSERT INTO "auth_user" VALUES (1,'pbkdf2_sha256$150000$z6uLoNSaFTwl$i8Kt3Av1xYyrlrOLz607CgCDknHDu73SVvaUmHVrwX8=',NULL,1,'manni','','',1,1,'2019-10-18 03:12:37.993167','');
INSERT INTO "auth_user" VALUES (2,'pbkdf2_sha256$180000$z6MxFOM4X6ma$VDL9KWQMyEOUTN+pJsWQ2hYLKApTG65tPutqc7/XAWg=','2020-02-21 02:51:38.553479',1,'admin','','enrique.solis@snovaservice.com',1,1,'2020-01-27 18:53:21.106152','');
INSERT INTO "auth_user" VALUES (3,'pbkdf2_sha256$150000$Sb6sAUsLtMC2$z20qkzPMPre0StIKGecm1Jfo6+brrjMbJaajH4QpKaY=','2020-02-01 03:56:52.610659',1,'enriquesolis','','acostaenrique954@gmail.com',1,1,'2020-02-01 03:00:45.345104','');
INSERT INTO "auth_user" VALUES (4,'pbkdf2_sha256$150000$5vlj6J1wD9pH$tXiUQw7zeyf0KUVBBUTBNcFRgHquV6wHNfGhN+lBEfY=',NULL,1,'manuel','','',1,1,'2020-02-04 02:02:30.915802','');
INSERT INTO "auth_user" VALUES (5,'pbkdf2_sha256$180000$NBHNgf378317$HfLOO+uty6FR36Y50jkaIeLSF/F3CJYYglgYAnhTp74=',NULL,0,'enrique','','enrique123',0,1,'2020-03-06 03:40:47.833107','');
INSERT INTO "auth_user" VALUES (6,'pbkdf2_sha256$180000$WGrmNBXY2fPX$T2TTrPuo1bJZcNna+SgsgygREXf4c+zKuSkp4Lfwels=',NULL,0,'enrique1111','','enrique123',0,1,'2020-03-07 22:22:28.084065','');
INSERT INTO "auth_user" VALUES (7,'pbkdf2_sha256$180000$djAVFUTkOx1q$NppR2yQYRewLSjSlghj4zmRvuVNO3pCb288wWfReiGs=',NULL,0,'asasas','','sasas',0,1,'2020-03-07 22:25:38.001214','');
INSERT INTO "auth_user" VALUES (8,'pbkdf2_sha256$180000$xTJMSekJds69$TzQa7lpJkeHvo92o5tme/BqDgAP+ZRaYREi/BGQ89FI=',NULL,0,'asasasasasas','','asasasas',0,1,'2020-03-07 22:26:06.426680','');
INSERT INTO "auth_user" VALUES (9,'pbkdf2_sha256$180000$xsMHzME3KsnZ$oJmypGqHijqgO68U7dcFmiTNFLMS7AFtBCgg1h4vGvw=',NULL,0,'asasas123','','asasas',0,1,'2020-03-07 22:37:07.472497','');
INSERT INTO "auth_permission" VALUES (1,1,'add_logentry','Can add log entry');
INSERT INTO "auth_permission" VALUES (2,1,'change_logentry','Can change log entry');
INSERT INTO "auth_permission" VALUES (3,1,'delete_logentry','Can delete log entry');
INSERT INTO "auth_permission" VALUES (4,1,'view_logentry','Can view log entry');
INSERT INTO "auth_permission" VALUES (5,2,'add_permission','Can add permission');
INSERT INTO "auth_permission" VALUES (6,2,'change_permission','Can change permission');
INSERT INTO "auth_permission" VALUES (7,2,'delete_permission','Can delete permission');
INSERT INTO "auth_permission" VALUES (8,2,'view_permission','Can view permission');
INSERT INTO "auth_permission" VALUES (9,3,'add_group','Can add group');
INSERT INTO "auth_permission" VALUES (10,3,'change_group','Can change group');
INSERT INTO "auth_permission" VALUES (11,3,'delete_group','Can delete group');
INSERT INTO "auth_permission" VALUES (12,3,'view_group','Can view group');
INSERT INTO "auth_permission" VALUES (13,4,'add_user','Can add user');
INSERT INTO "auth_permission" VALUES (14,4,'change_user','Can change user');
INSERT INTO "auth_permission" VALUES (15,4,'delete_user','Can delete user');
INSERT INTO "auth_permission" VALUES (16,4,'view_user','Can view user');
INSERT INTO "auth_permission" VALUES (17,5,'add_contenttype','Can add content type');
INSERT INTO "auth_permission" VALUES (18,5,'change_contenttype','Can change content type');
INSERT INTO "auth_permission" VALUES (19,5,'delete_contenttype','Can delete content type');
INSERT INTO "auth_permission" VALUES (20,5,'view_contenttype','Can view content type');
INSERT INTO "auth_permission" VALUES (21,6,'add_session','Can add session');
INSERT INTO "auth_permission" VALUES (22,6,'change_session','Can change session');
INSERT INTO "auth_permission" VALUES (23,6,'delete_session','Can delete session');
INSERT INTO "auth_permission" VALUES (24,6,'view_session','Can view session');
INSERT INTO "auth_permission" VALUES (25,7,'add_goals','Can add goals');
INSERT INTO "auth_permission" VALUES (26,7,'change_goals','Can change goals');
INSERT INTO "auth_permission" VALUES (27,7,'delete_goals','Can delete goals');
INSERT INTO "auth_permission" VALUES (28,7,'view_goals','Can view goals');
INSERT INTO "auth_permission" VALUES (29,8,'add_goaldetail','Can add goal detail');
INSERT INTO "auth_permission" VALUES (30,8,'change_goaldetail','Can change goal detail');
INSERT INTO "auth_permission" VALUES (31,8,'delete_goaldetail','Can delete goal detail');
INSERT INTO "auth_permission" VALUES (32,8,'view_goaldetail','Can view goal detail');
INSERT INTO "auth_permission" VALUES (33,9,'add_token','Can add Token');
INSERT INTO "auth_permission" VALUES (34,9,'change_token','Can change Token');
INSERT INTO "auth_permission" VALUES (35,9,'delete_token','Can delete Token');
INSERT INTO "auth_permission" VALUES (36,9,'view_token','Can view Token');
INSERT INTO "auth_permission" VALUES (37,10,'add_account','Can add account');
INSERT INTO "auth_permission" VALUES (38,10,'change_account','Can change account');
INSERT INTO "auth_permission" VALUES (39,10,'delete_account','Can delete account');
INSERT INTO "auth_permission" VALUES (40,10,'view_account','Can view account');
INSERT INTO "auth_permission" VALUES (41,11,'add_emailaddress','Can add email address');
INSERT INTO "auth_permission" VALUES (42,11,'change_emailaddress','Can change email address');
INSERT INTO "auth_permission" VALUES (43,11,'delete_emailaddress','Can delete email address');
INSERT INTO "auth_permission" VALUES (44,11,'view_emailaddress','Can view email address');
INSERT INTO "auth_permission" VALUES (45,12,'add_emailconfirmation','Can add email confirmation');
INSERT INTO "auth_permission" VALUES (46,12,'change_emailconfirmation','Can change email confirmation');
INSERT INTO "auth_permission" VALUES (47,12,'delete_emailconfirmation','Can delete email confirmation');
INSERT INTO "auth_permission" VALUES (48,12,'view_emailconfirmation','Can view email confirmation');
INSERT INTO "auth_permission" VALUES (49,13,'add_socialaccount','Can add social account');
INSERT INTO "auth_permission" VALUES (50,13,'change_socialaccount','Can change social account');
INSERT INTO "auth_permission" VALUES (51,13,'delete_socialaccount','Can delete social account');
INSERT INTO "auth_permission" VALUES (52,13,'view_socialaccount','Can view social account');
INSERT INTO "auth_permission" VALUES (53,14,'add_socialapp','Can add social application');
INSERT INTO "auth_permission" VALUES (54,14,'change_socialapp','Can change social application');
INSERT INTO "auth_permission" VALUES (55,14,'delete_socialapp','Can delete social application');
INSERT INTO "auth_permission" VALUES (56,14,'view_socialapp','Can view social application');
INSERT INTO "auth_permission" VALUES (57,15,'add_socialtoken','Can add social application token');
INSERT INTO "auth_permission" VALUES (58,15,'change_socialtoken','Can change social application token');
INSERT INTO "auth_permission" VALUES (59,15,'delete_socialtoken','Can delete social application token');
INSERT INTO "auth_permission" VALUES (60,15,'view_socialtoken','Can view social application token');
INSERT INTO "auth_permission" VALUES (61,16,'add_site','Can add site');
INSERT INTO "auth_permission" VALUES (62,16,'change_site','Can change site');
INSERT INTO "auth_permission" VALUES (63,16,'delete_site','Can delete site');
INSERT INTO "auth_permission" VALUES (64,16,'view_site','Can view site');
INSERT INTO "auth_permission" VALUES (65,17,'add_progress','Can add progress');
INSERT INTO "auth_permission" VALUES (66,17,'change_progress','Can change progress');
INSERT INTO "auth_permission" VALUES (67,17,'delete_progress','Can delete progress');
INSERT INTO "auth_permission" VALUES (68,17,'view_progress','Can view progress');
INSERT INTO "auth_permission" VALUES (69,18,'add_cliente','Can add cliente');
INSERT INTO "auth_permission" VALUES (70,18,'change_cliente','Can change cliente');
INSERT INTO "auth_permission" VALUES (71,18,'delete_cliente','Can delete cliente');
INSERT INTO "auth_permission" VALUES (72,18,'view_cliente','Can view cliente');
INSERT INTO "auth_permission" VALUES (73,19,'add_departamento','Can add departamento');
INSERT INTO "auth_permission" VALUES (74,19,'change_departamento','Can change departamento');
INSERT INTO "auth_permission" VALUES (75,19,'delete_departamento','Can delete departamento');
INSERT INTO "auth_permission" VALUES (76,19,'view_departamento','Can view departamento');
INSERT INTO "auth_permission" VALUES (77,20,'add_factura','Can add factura');
INSERT INTO "auth_permission" VALUES (78,20,'change_factura','Can change factura');
INSERT INTO "auth_permission" VALUES (79,20,'delete_factura','Can delete factura');
INSERT INTO "auth_permission" VALUES (80,20,'view_factura','Can view factura');
INSERT INTO "auth_permission" VALUES (81,21,'add_persona','Can add persona');
INSERT INTO "auth_permission" VALUES (82,21,'change_persona','Can change persona');
INSERT INTO "auth_permission" VALUES (83,21,'delete_persona','Can delete persona');
INSERT INTO "auth_permission" VALUES (84,21,'view_persona','Can view persona');
INSERT INTO "auth_permission" VALUES (85,22,'add_sucursal','Can add sucursal');
INSERT INTO "auth_permission" VALUES (86,22,'change_sucursal','Can change sucursal');
INSERT INTO "auth_permission" VALUES (87,22,'delete_sucursal','Can delete sucursal');
INSERT INTO "auth_permission" VALUES (88,22,'view_sucursal','Can view sucursal');
INSERT INTO "auth_permission" VALUES (89,23,'add_proveedor','Can add proveedor');
INSERT INTO "auth_permission" VALUES (90,23,'change_proveedor','Can change proveedor');
INSERT INTO "auth_permission" VALUES (91,23,'delete_proveedor','Can delete proveedor');
INSERT INTO "auth_permission" VALUES (92,23,'view_proveedor','Can view proveedor');
INSERT INTO "auth_permission" VALUES (93,24,'add_producto','Can add producto');
INSERT INTO "auth_permission" VALUES (94,24,'change_producto','Can change producto');
INSERT INTO "auth_permission" VALUES (95,24,'delete_producto','Can delete producto');
INSERT INTO "auth_permission" VALUES (96,24,'view_producto','Can view producto');
INSERT INTO "auth_permission" VALUES (97,25,'add_tipoproducto','Can add tipoproducto');
INSERT INTO "auth_permission" VALUES (98,25,'change_tipoproducto','Can change tipoproducto');
INSERT INTO "auth_permission" VALUES (99,25,'delete_tipoproducto','Can delete tipoproducto');
INSERT INTO "auth_permission" VALUES (100,25,'view_tipoproducto','Can view tipoproducto');
INSERT INTO "auth_permission" VALUES (101,26,'add_telefono','Can add telefono');
INSERT INTO "auth_permission" VALUES (102,26,'change_telefono','Can change telefono');
INSERT INTO "auth_permission" VALUES (103,26,'delete_telefono','Can delete telefono');
INSERT INTO "auth_permission" VALUES (104,26,'view_telefono','Can view telefono');
INSERT INTO "auth_permission" VALUES (105,27,'add_empleado','Can add empleado');
INSERT INTO "auth_permission" VALUES (106,27,'change_empleado','Can change empleado');
INSERT INTO "auth_permission" VALUES (107,27,'delete_empleado','Can delete empleado');
INSERT INTO "auth_permission" VALUES (108,27,'view_empleado','Can view empleado');
INSERT INTO "auth_permission" VALUES (109,28,'add_cargo','Can add cargo');
INSERT INTO "auth_permission" VALUES (110,28,'change_cargo','Can change cargo');
INSERT INTO "auth_permission" VALUES (111,28,'delete_cargo','Can delete cargo');
INSERT INTO "auth_permission" VALUES (112,28,'view_cargo','Can view cargo');
INSERT INTO "auth_permission" VALUES (113,29,'add_tipotelefono','Can add tipotelefono');
INSERT INTO "auth_permission" VALUES (114,29,'change_tipotelefono','Can change tipotelefono');
INSERT INTO "auth_permission" VALUES (115,29,'delete_tipotelefono','Can delete tipotelefono');
INSERT INTO "auth_permission" VALUES (116,29,'view_tipotelefono','Can view tipotelefono');
INSERT INTO "auth_permission" VALUES (117,30,'add_detalle','Can add detalle');
INSERT INTO "auth_permission" VALUES (118,30,'change_detalle','Can change detalle');
INSERT INTO "auth_permission" VALUES (119,30,'delete_detalle','Can delete detalle');
INSERT INTO "auth_permission" VALUES (120,30,'view_detalle','Can view detalle');
INSERT INTO "django_content_type" VALUES (1,'admin','logentry');
INSERT INTO "django_content_type" VALUES (2,'auth','permission');
INSERT INTO "django_content_type" VALUES (3,'auth','group');
INSERT INTO "django_content_type" VALUES (4,'auth','user');
INSERT INTO "django_content_type" VALUES (5,'contenttypes','contenttype');
INSERT INTO "django_content_type" VALUES (6,'sessions','session');
INSERT INTO "django_content_type" VALUES (7,'API','goals');
INSERT INTO "django_content_type" VALUES (8,'API','goaldetail');
INSERT INTO "django_content_type" VALUES (9,'authtoken','token');
INSERT INTO "django_content_type" VALUES (10,'API','account');
INSERT INTO "django_content_type" VALUES (11,'account','emailaddress');
INSERT INTO "django_content_type" VALUES (12,'account','emailconfirmation');
INSERT INTO "django_content_type" VALUES (13,'socialaccount','socialaccount');
INSERT INTO "django_content_type" VALUES (14,'socialaccount','socialapp');
INSERT INTO "django_content_type" VALUES (15,'socialaccount','socialtoken');
INSERT INTO "django_content_type" VALUES (16,'sites','site');
INSERT INTO "django_content_type" VALUES (17,'API','progress');
INSERT INTO "django_content_type" VALUES (18,'API','cliente');
INSERT INTO "django_content_type" VALUES (19,'API','departamento');
INSERT INTO "django_content_type" VALUES (20,'API','factura');
INSERT INTO "django_content_type" VALUES (21,'API','persona');
INSERT INTO "django_content_type" VALUES (22,'API','sucursal');
INSERT INTO "django_content_type" VALUES (23,'API','proveedor');
INSERT INTO "django_content_type" VALUES (24,'API','producto');
INSERT INTO "django_content_type" VALUES (25,'API','tipoproducto');
INSERT INTO "django_content_type" VALUES (26,'API','telefono');
INSERT INTO "django_content_type" VALUES (27,'API','empleado');
INSERT INTO "django_content_type" VALUES (28,'API','cargo');
INSERT INTO "django_content_type" VALUES (29,'API','tipotelefono');
INSERT INTO "django_content_type" VALUES (30,'API','detalle');
INSERT INTO "django_admin_log" VALUES (1,'2020-02-02 03:24:12.107310','2','admin','[{"changed": {"fields": ["password"]}}]',4,3,2);
INSERT INTO "django_migrations" VALUES (1,'API','0001_initial','2019-10-14 00:41:21.435852');
INSERT INTO "django_migrations" VALUES (2,'contenttypes','0001_initial','2019-10-14 00:41:21.580615');
INSERT INTO "django_migrations" VALUES (3,'auth','0001_initial','2019-10-14 00:41:21.693857');
INSERT INTO "django_migrations" VALUES (4,'admin','0001_initial','2019-10-14 00:41:21.826811');
INSERT INTO "django_migrations" VALUES (5,'admin','0002_logentry_remove_auto_add','2019-10-14 00:41:21.966226');
INSERT INTO "django_migrations" VALUES (6,'admin','0003_logentry_add_action_flag_choices','2019-10-14 00:41:22.131624');
INSERT INTO "django_migrations" VALUES (7,'contenttypes','0002_remove_content_type_name','2019-10-14 00:41:22.324162');
INSERT INTO "django_migrations" VALUES (8,'auth','0002_alter_permission_name_max_length','2019-10-14 00:41:22.526329');
INSERT INTO "django_migrations" VALUES (9,'auth','0003_alter_user_email_max_length','2019-10-14 00:41:22.680695');
INSERT INTO "django_migrations" VALUES (10,'auth','0004_alter_user_username_opts','2019-10-14 00:41:22.855528');
INSERT INTO "django_migrations" VALUES (11,'auth','0005_alter_user_last_login_null','2019-10-14 00:41:23.032087');
INSERT INTO "django_migrations" VALUES (12,'auth','0006_require_contenttypes_0002','2019-10-14 00:41:23.185424');
INSERT INTO "django_migrations" VALUES (13,'auth','0007_alter_validators_add_error_messages','2019-10-14 00:41:23.299740');
INSERT INTO "django_migrations" VALUES (14,'auth','0008_alter_user_username_max_length','2019-10-14 00:41:23.449546');
INSERT INTO "django_migrations" VALUES (15,'auth','0009_alter_user_last_name_max_length','2019-10-14 00:41:23.605877');
INSERT INTO "django_migrations" VALUES (16,'auth','0010_alter_group_name_max_length','2019-10-14 00:41:23.797698');
INSERT INTO "django_migrations" VALUES (17,'auth','0011_update_proxy_permissions','2019-10-14 00:41:24.052940');
INSERT INTO "django_migrations" VALUES (18,'authtoken','0001_initial','2019-10-14 00:41:24.171499');
INSERT INTO "django_migrations" VALUES (19,'authtoken','0002_auto_20160226_1747','2019-10-14 00:41:24.359006');
INSERT INTO "django_migrations" VALUES (20,'sessions','0001_initial','2019-10-14 00:41:24.471858');
INSERT INTO "django_migrations" VALUES (21,'API','0002_account','2020-01-29 04:34:08.298119');
INSERT INTO "django_migrations" VALUES (22,'account','0001_initial','2020-01-31 03:02:29.094774');
INSERT INTO "django_migrations" VALUES (23,'account','0002_email_max_length','2020-01-31 03:02:29.224786');
INSERT INTO "django_migrations" VALUES (24,'sites','0001_initial','2020-01-31 03:02:29.376731');
INSERT INTO "django_migrations" VALUES (25,'sites','0002_alter_domain_unique','2020-01-31 03:02:29.473938');
INSERT INTO "django_migrations" VALUES (26,'socialaccount','0001_initial','2020-01-31 03:02:29.645693');
INSERT INTO "django_migrations" VALUES (27,'socialaccount','0002_token_max_lengths','2020-01-31 03:02:29.850831');
INSERT INTO "django_migrations" VALUES (28,'socialaccount','0003_extra_data_default_dict','2020-01-31 03:02:30.021654');
INSERT INTO "django_migrations" VALUES (29,'API','0003_delete_account','2020-02-02 04:31:08.645664');
INSERT INTO "django_migrations" VALUES (30,'API','0004_goals_time_line','2020-02-21 16:39:11.004278');
INSERT INTO "django_migrations" VALUES (31,'API','0005_auto_20200224_0025','2020-02-24 04:25:38.061720');
INSERT INTO "django_migrations" VALUES (32,'API','0006_auto_20200226_2122','2020-02-27 01:26:00.070219');
INSERT INTO "django_migrations" VALUES (33,'API','0007_goaldetail_status','2020-03-01 21:17:28.402690');
INSERT INTO "django_migrations" VALUES (34,'API','0008_progress','2020-03-02 01:02:55.536322');
INSERT INTO "django_migrations" VALUES (35,'API','0009_auto_20200403_2303','2020-04-04 03:04:10.633618');
CREATE INDEX IF NOT EXISTS "API_cargo_id_departamento_id_ea6a05a5" ON "API_cargo" (
	"id_departamento_id"
);
CREATE INDEX IF NOT EXISTS "API_cliente_id_persona_id_5d908070" ON "API_cliente" (
	"id_persona_id"
);
CREATE INDEX IF NOT EXISTS "API_detalle_id_producto_id_7d22099b" ON "API_detalle" (
	"id_producto_id"
);
CREATE INDEX IF NOT EXISTS "API_detalle_id_factura_id_6fa1cb0f" ON "API_detalle" (
	"id_factura_id"
);
CREATE INDEX IF NOT EXISTS "API_detalle_id_empleado_id_a8b54231" ON "API_detalle" (
	"id_empleado_id"
);
CREATE INDEX IF NOT EXISTS "API_detalle_id_cliente_id_0302891b" ON "API_detalle" (
	"id_cliente_id"
);
CREATE INDEX IF NOT EXISTS "API_empleado_id_sucursal_id_59595eeb" ON "API_empleado" (
	"id_sucursal_id"
);
CREATE INDEX IF NOT EXISTS "API_empleado_id_persona_id_f412cb22" ON "API_empleado" (
	"id_persona_id"
);
CREATE INDEX IF NOT EXISTS "API_empleado_id_cargo_id_c88b482d" ON "API_empleado" (
	"id_cargo_id"
);
CREATE INDEX IF NOT EXISTS "API_factura_id_sucursal_id_fcd66cd0" ON "API_factura" (
	"id_sucursal_id"
);
CREATE INDEX IF NOT EXISTS "API_factura_id_empleado_id_4b4e4126" ON "API_factura" (
	"id_empleado_id"
);
CREATE INDEX IF NOT EXISTS "API_factura_id_departamento_id_2993333a" ON "API_factura" (
	"id_departamento_id"
);
CREATE INDEX IF NOT EXISTS "API_factura_id_cliente_id_32086fac" ON "API_factura" (
	"id_cliente_id"
);
CREATE INDEX IF NOT EXISTS "API_producto_id_producto_id_fd31d509" ON "API_producto" (
	"id_producto_id"
);
CREATE INDEX IF NOT EXISTS "API_telefono_id_tipo_id_cf9a74ab" ON "API_telefono" (
	"id_tipo_id"
);
CREATE INDEX IF NOT EXISTS "API_telefono_id_persona_id_b208b9a5" ON "API_telefono" (
	"id_persona_id"
);
CREATE INDEX IF NOT EXISTS "API_proveedor_id_persona_id_e78b2fba" ON "API_proveedor" (
	"id_persona_id"
);
CREATE INDEX IF NOT EXISTS "socialaccount_socialaccount_user_id_8146e70c" ON "socialaccount_socialaccount" (
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "socialaccount_socialaccount_provider_uid_fc810c6e_uniq" ON "socialaccount_socialaccount" (
	"provider",
	"uid"
);
CREATE INDEX IF NOT EXISTS "socialaccount_socialtoken_app_id_636a42d7" ON "socialaccount_socialtoken" (
	"app_id"
);
CREATE INDEX IF NOT EXISTS "socialaccount_socialtoken_account_id_951f210e" ON "socialaccount_socialtoken" (
	"account_id"
);
CREATE INDEX IF NOT EXISTS "socialaccount_socialapp_sites_site_id_2579dee5" ON "socialaccount_socialapp_sites" (
	"site_id"
);
CREATE INDEX IF NOT EXISTS "socialaccount_socialapp_sites_socialapp_id_97fb6e7d" ON "socialaccount_socialapp_sites" (
	"socialapp_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "socialaccount_socialapp_sites_socialapp_id_site_id_71a9a768_uniq" ON "socialaccount_socialapp_sites" (
	"socialapp_id",
	"site_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "socialaccount_socialtoken_app_id_account_id_fca4e0ac_uniq" ON "socialaccount_socialtoken" (
	"app_id",
	"account_id"
);
CREATE INDEX IF NOT EXISTS "account_emailaddress_user_id_2c513194" ON "account_emailaddress" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "account_emailconfirmation_email_address_id_5b7f8c58" ON "account_emailconfirmation" (
	"email_address_id"
);
CREATE INDEX IF NOT EXISTS "django_session_expire_date_a5c62663" ON "django_session" (
	"expire_date"
);
CREATE INDEX IF NOT EXISTS "auth_permission_content_type_id_2f476e4b" ON "auth_permission" (
	"content_type_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_permission_content_type_id_codename_01ab375a_uniq" ON "auth_permission" (
	"content_type_id",
	"codename"
);
CREATE UNIQUE INDEX IF NOT EXISTS "django_content_type_app_label_model_76bd3d3b_uniq" ON "django_content_type" (
	"app_label",
	"model"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_user_id_c564eba6" ON "django_admin_log" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_content_type_id_c4bce8eb" ON "django_admin_log" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_permission_id_1fbb5f2c" ON "auth_user_user_permissions" (
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_a95ead1b" ON "auth_user_user_permissions" (
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_permission_id_14a6b632_uniq" ON "auth_user_user_permissions" (
	"user_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_groups_group_id_97559544" ON "auth_user_groups" (
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_groups_user_id_6a12ed8b" ON "auth_user_groups" (
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_groups_user_id_group_id_94350c0c_uniq" ON "auth_user_groups" (
	"user_id",
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_permission_id_84c5c92e" ON "auth_group_permissions" (
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_group_id_b120cbf9" ON "auth_group_permissions" (
	"group_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" ON "auth_group_permissions" (
	"group_id",
	"permission_id"
);
COMMIT;
