CREATE TABLE "calendar_events" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "title" varchar(255), "start_time" datetime, "end_time" datetime(255), "description" text, "created_at" datetime, "updated_at" datetime, "event_hash" varchar(64) DEFAULT 'INVALID' NOT NULL, "event_source_id" integer, "family_hash" varchar(64), "location" varchar(256), "host" varchar(256));
CREATE TABLE "event_assets" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, "calendar_event_id" integer, "caption" varchar(255), "mime_type" varchar(255), "data" blob, "created_at" datetime, "updated_at" datetime);
CREATE TABLE "event_sources" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
"name" varchar(255), "uri" varchar(255), "frequency" integer, "last_harvest"
integer, "json_parameters" text, "created_at" datetime, "updated_at" datetime,
"source_type" varchar(255));
CREATE TABLE "event_tags" ("id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
"name" varchar(255), "tag_type" varchar(64), "created_at" datetime, "updated_at" datetime);
CREATE TABLE "schema_migrations" ("version" varchar(255) NOT NULL);
CREATE UNIQUE INDEX "index_calendar_events_on_event_hash" ON "calendar_events" ("event_hash");
CREATE INDEX "index_calendar_events_on_event_source_id" ON "calendar_events" ("event_source_id");
CREATE INDEX index_calendar_events_on_family_hash on calendar_events (family_hash);
CREATE UNIQUE INDEX "unique_schema_migrations" ON "schema_migrations" ("version");
INSERT INTO schema_migrations (version) VALUES ('20141118214949');

INSERT INTO schema_migrations (version) VALUES ('20141118231236');

INSERT INTO schema_migrations (version) VALUES ('20141119203011');

INSERT INTO schema_migrations (version) VALUES ('20141119220007');

INSERT INTO schema_migrations (version) VALUES ('20141119220902');

INSERT INTO schema_migrations (version) VALUES ('20141119225617');

INSERT INTO schema_migrations (version) VALUES ('20141120160426');

INSERT INTO schema_migrations (version) VALUES ('20141124161424');

INSERT INTO schema_migrations (version) VALUES ('20141124162728');

INSERT INTO schema_migrations (version) VALUES ('20141124163222');

INSERT INTO schema_migrations (version) VALUES ('20141124165802');

INSERT INTO schema_migrations (version) VALUES ('20141124214702');

INSERT INTO schema_migrations (version) VALUES ('20141124222331');

INSERT INTO schema_migrations (version) VALUES ('20141124222741');

INSERT INTO schema_migrations (version) VALUES ('20141124222946');

INSERT INTO schema_migrations (version) VALUES ('20141124223709');

