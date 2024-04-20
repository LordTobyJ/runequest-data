
CREATE TABLE IF NOT EXISTS StandardOfLiving (
  id UUID PRIMARY KEY,
  name VARCHAR,
  description VARCHAR,
  cost INTEGER
);

CREATE TABLE IF NOT EXISTS HomelandCulture (
  id UUID PRIMARY KEY,
  name VARCHAR,
  cultural_skills UUID[]
);

CREATE TABLE IF NOT EXISTS FormAffinity (
  id UUID PRIMARY KEY,
  name VARCHAR,
  description VARCHAR,
  magnitude INTEGER
);

CREATE TABLE IF NOT EXISTS Passion (
  id UUID PRIMARY KEY,
  name VARCHAR,
  magnitude INTEGER
);

CREATE TABLE IF NOT EXISTS Occupations (
  id UUID PRIMARY KEY,
  name VARCHAR,
  description VARCHAR,
  occupational_skills UUID[],
  available_cults UUID[],
  allowed_homelands UUID[],
  standard_of_living UUID REFERENCES StandardOfLiving,
  base_income INTEGER,
  favoured_passions UUID[],
  equipment VARCHAR,
  ransom INTEGER
);

CREATE TABLE IF NOT EXISTS Homeland (
  id UUID PRIMARY KEY,
  name VARCHAR,
  description VARCHAR,
  stereotypes VARCHAR,
  culture UUID REFERENCES HomelandCulture,
  suggested_occupations UUID[],
  common_cults UUID[],
  starting_passions UUID[],
  cultural_skills UUID[],
  cultural_equipment VARCHAR
);

CREATE TABLE IF NOT EXISTS Cult (
  id UUID PRIMARY KEY,
  name VARCHAR,
  description VARCHAR,
  rune_A UUID REFERENCES FormAffinity,
  rune_B UUID REFERENCES FormAffinity,
  rune_C UUID REFERENCES FormAffinity,
  special_rune_magic UUID[],
  cult_spirit_magic UUID[],
  prohibited_rune_magic UUID[],
  prohibited_spirit_magic UUID[],
  cult_skills UUID[],
  favoured_passions UUID[],
  associated_cults UUID[]
);

CREATE TABLE IF NOT EXISTS RuneMagic (
  id UUID PRIMARY KEY,
  name VARCHAR
);

CREATE TABLE IF NOT EXISTS SpiritMagic (
  id UUID PRIMARY KEY,
  name VARCHAR
);

CREATE TABLE IF NOT EXISTS LifeEvent (
  id UUID PRIMARY KEY,
  participating_homelands UUID[],
  name VARCHAR,
  outcomes UUID[],
  homeland_roll_modifier UUID[]
);

CREATE TABLE IF NOT EXISTS GrandparentHistory (
  id UUID PRIMARY KEY,
  event_1582 UUID REFERENCES LifeEvent,
  event_1597 UUID REFERENCES LifeEvent,
  event_1602 UUID REFERENCES LifeEvent,
  event_interrim UUID REFERENCES LifeEvent,
  event_1605 UUID REFERENCES LifeEvent,
  name VARCHAR
);

CREATE TABLE IF NOT EXISTS ParentHistory (
  id UUID PRIMARY KEY,
  event_1608 UUID REFERENCES LifeEvent,
  event_1610 UUID REFERENCES LifeEvent,
  event_1613 UUID REFERENCES LifeEvent,
  event_1615 UUID REFERENCES LifeEvent,
  event_1616 UUID REFERENCES LifeEvent,
  event_1618 UUID REFERENCES LifeEvent,
  event_1619 UUID REFERENCES LifeEvent,
  event_1620 UUID REFERENCES LifeEvent,
  name VARCHAR
);

CREATE TABLE IF NOT EXISTS OwnHistory (
  id UUID PRIMARY KEY,
  event_1622 UUID REFERENCES LifeEvent,
  event_1623 UUID REFERENCES LifeEvent,
  event_1624 UUID REFERENCES LifeEvent,
  event_1635 UUID REFERENCES LifeEvent,
  name VARCHAR
);

CREATE TABLE IF NOT EXISTS FamilyHistory (
  id UUID PRIMARY KEY,
  GrandparentHistory UUID REFERENCES GrandparentHistory,
  ParentHistory UUID REFERENCES ParentHistory,
  OwnHistory UUID REFERENCES OwnHistory
);

CREATE TABLE IF NOT EXISTS CauseOfDeath (
  id UUID PRIMARY KEY,
  name VARCHAR,
  roll_result VARCHAR
);

CREATE TABLE IF NOT EXISTS RandomBoon (
  id UUID PRIMARY KEY,
  name VARCHAR,
  roll_result VARCHAR
);

CREATE TABLE IF NOT EXISTS Outcome (
  id UUID PRIMARY KEY,
  name VARCHAR,
  outcome_skill_modifier UUID[],
  died BOOLEAN,
  outcome_random_cause_of_death UUID REFERENCES CauseOfDeath,
  outcome_random_boon UUID REFERENCES RandomBoon,
  sub_outcome UUID[],
  outcome_passion_modifier UUID[]
);

CREATE TABLE IF NOT EXISTS PassionModifier (
  id UUID PRIMARY KEY,
  passion UUID REFERENCES Passion,
  modifier INTEGER
);

CREATE TABLE IF NOT EXISTS HomelandRollModifier (
  id UUID PRIMARY KEY,
  homeland UUID REFERENCES Homeland,
  name VARCHAR,
  modifier INTEGER
);

CREATE TABLE IF NOT EXISTS RuneAffinity (
  id UUID PRIMARY KEY,
  name VARCHAR,
  description VARCHAR,
  magnitude INTEGER
);

CREATE TABLE IF NOT EXISTS AffinityModifier (
  id UUID PRIMARY KEY,
  rune_affinity UUID REFERENCES RuneAffinity,
  form_affinity UUID REFERENCES FormAffinity,
  modifier INTEGER
);

CREATE TABLE IF NOT EXISTS Characteristic (
  id UUID PRIMARY KEY,
  name VARCHAR,
  description VARCHAR,
  magnitude INTEGER
);

CREATE TABLE IF NOT EXISTS CharacteristicModifier (
  id UUID PRIMARY KEY,
  characteristic UUID REFERENCES Characteristic,
  modifier INTEGER
);

CREATE TABLE IF NOT EXISTS SkillCategory (
  id UUID PRIMARY KEY,
  name VARCHAR,
  description VARCHAR,
  skills UUID[],
  STR_modifier INTEGER,
  CON_modifier INTEGER,
  SIZ_modifier INTEGER,
  DEX_modifier INTEGER,
  INT_modifier INTEGER,
  POW_modifier INTEGER,
  CHA_modifier INTEGER
);

CREATE TABLE IF NOT EXISTS Skill (
  id UUID PRIMARY KEY,
  name VARCHAR,
  description VARCHAR,
  skill_category UUID REFERENCES SkillCategory,
  magnitude INTEGER
);

CREATE TABLE IF NOT EXISTS SkillModifier (
  id UUID PRIMARY KEY,
  skill UUID REFERENCES Skill,
  modifier INTEGER
);

CREATE TABLE IF NOT EXISTS CharacteristicModifier (
  id UUID PRIMARY KEY,
  characteristic UUID REFERENCES Characteristic,
  modifier INTEGER
);

CREATE TABLE IF NOT EXISTS Character (
  id UUID PRIMARY KEY,
  occupation UUID REFERENCES Occupations,
  homeland UUID REFERENCES Homeland,
  family_history UUID REFERENCES FamilyHistory,
  affinity_60 UUID REFERENCES RuneAffinity,
  affinity_40 UUID REFERENCES RuneAffinity,
  affinity_20 UUID REFERENCES RuneAffinity,
  affinity_distribution_50 UUID REFERENCES AffinityModifier,
  form_75A UUID REFERENCES FormAffinity,
  form_75B UUID REFERENCES FormAffinity,
  stat_STR UUID REFERENCES Characteristic,
  stat_CON UUID REFERENCES Characteristic,
  stat_SIZ UUID REFERENCES Characteristic,
  stat_DEX UUID REFERENCES Characteristic,
  stat_INT UUID REFERENCES Characteristic,
  stat_POW UUID REFERENCES Characteristic,
  stat_CHA UUID REFERENCES Characteristic,
  rune_char_mod_A UUID REFERENCES CharacteristicModifier,
  rune_char_mod_B UUID REFERENCES CharacteristicModifier,
  name VARCHAR,
  age INTEGER,
  is_woman BOOLEAN,
  is_left_handed BOOLEAN
);

