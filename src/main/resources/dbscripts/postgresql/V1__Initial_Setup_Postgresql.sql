--
-- Table structure for table account
--
DROP TABLE IF EXISTS account;
CREATE SEQUENCE account_db_id_seq;
CREATE TABLE account (
 db_id numeric(20) NOT NULL DEFAULT nextval('account_db_id_seq'),
 id numeric(20) NOT NULL,
 creation_height numeric(11) NOT NULL,
 public_key bytea DEFAULT NULL,
 key_height numeric(11) DEFAULT NULL,
 balance numeric(20) NOT NULL,
 unconfirmed_balance numeric(20) NOT NULL,
 forged_balance numeric(20) NOT NULL,
 name varchar(100) DEFAULT NULL,
 description text ,
 height numeric(11) NOT NULL,
 latest boolean NOT NULL DEFAULT TRUE,
 CHECK(length(public_key) <= 32),
 PRIMARY KEY (db_id),
 UNIQUE (id, height)
);
ALTER SEQUENCE account_db_id_seq OWNED BY account.db_id;
CREATE INDEX ON account (id, balance, height);
CREATE INDEX ON account (id, latest);

--
-- Table structure for table account_asset
--

DROP TABLE IF EXISTS account_asset;
CREATE SEQUENCE account_asset_db_id_seq;
CREATE TABLE account_asset (
 db_id numeric(20) NOT NULL DEFAULT nextval('account_asset_db_id_seq'),
 account_id numeric(20) NOT NULL,
 asset_id numeric(20) NOT NULL,
 quantity numeric(20) NOT NULL,
 unconfirmed_quantity numeric(20) NOT NULL,
 height numeric(11) NOT NULL,
 latest boolean NOT NULL DEFAULT TRUE,
 PRIMARY KEY (db_id),
 UNIQUE (account_id, asset_id,height)
);
ALTER SEQUENCE account_asset_db_id_seq OWNED BY account_asset.db_id;
CREATE INDEX ON account_asset (quantity);
--
-- Table structure for table alias
--

DROP TABLE IF EXISTS alias;
CREATE SEQUENCE alias_db_id_seq;
CREATE TABLE alias (
 db_id numeric(20) NOT NULL DEFAULT nextval('alias_db_id_seq'),
 id numeric(20) NOT NULL,
 account_id numeric(20) NOT NULL,
 alias_name varchar(100) NOT NULL,
 alias_name_lower varchar(100) NOT NULL,
 alias_uri text NOT NULL,
 timestamp numeric(11) NOT NULL,
 height numeric(11) NOT NULL,
 latest boolean NOT NULL DEFAULT TRUE,
 PRIMARY KEY (db_id),
 UNIQUE (id, height)
);
ALTER SEQUENCE alias_db_id_seq OWNED BY alias.db_id;
CREATE INDEX ON alias (account_id, height);
CREATE INDEX ON alias (alias_name_lower);

--
-- Table structure for table alias_offer
--

DROP TABLE IF EXISTS alias_offer;
CREATE SEQUENCE alias_offer_db_id_seq;
CREATE TABLE alias_offer (
 db_id numeric(20) NOT NULL DEFAULT nextval('alias_offer_db_id_seq'),
 id numeric(20) NOT NULL,
 price numeric(20) NOT NULL,
 buyer_id numeric(20) DEFAULT NULL,
 height numeric(11) NOT NULL,
 latest boolean NOT NULL DEFAULT TRUE,
 PRIMARY KEY (db_id),
 UNIQUE (id, height)
);
ALTER SEQUENCE alias_offer_db_id_seq OWNED BY alias_offer.db_id;

--
-- Table structure for table ask_order
--

DROP TABLE IF EXISTS ask_order;
CREATE SEQUENCE ask_order_db_id_seq;
CREATE TABLE ask_order (
 db_id numeric(20) NOT NULL DEFAULT nextval('ask_order_db_id_seq'),
 id numeric(20) NOT NULL,
 account_id numeric(20) NOT NULL,
 asset_id numeric(20) NOT NULL,
 price numeric(20) NOT NULL,
 quantity numeric(20) NOT NULL,
 creation_height numeric(11) NOT NULL,
 height numeric(11) NOT NULL,
 latest boolean NOT NULL DEFAULT TRUE,
 PRIMARY KEY (db_id),
 UNIQUE (id, height)
);
ALTER SEQUENCE ask_order_db_id_seq OWNED BY ask_order.db_id;
CREATE INDEX ON ask_order (account_id, height);
CREATE INDEX ON ask_order (asset_id,price);
CREATE INDEX ON ask_order (creation_height);

--
-- Table structure for table asset
--

DROP TABLE IF EXISTS asset;
CREATE SEQUENCE asset_db_id_seq;
CREATE TABLE asset (
 db_id numeric(20) NOT NULL DEFAULT nextval('asset_db_id_seq'),
 id numeric(20) NOT NULL,
 account_id numeric(20) NOT NULL,
 name varchar(10) NOT NULL,
 description text ,
 quantity numeric(20) NOT NULL,
 decimals numeric(4) NOT NULL,
 height numeric(11) NOT NULL,
 PRIMARY KEY (db_id),
 UNIQUE (id)
);
ALTER SEQUENCE asset_db_id_seq OWNED BY asset.db_id;
CREATE INDEX ON asset (account_id);

--
-- Table structure for table asset_transfer
--

DROP TABLE IF EXISTS asset_transfer;
CREATE SEQUENCE asset_transfer_db_id_seq;
CREATE TABLE asset_transfer (
 db_id numeric(20) NOT NULL DEFAULT nextval('asset_transfer_db_id_seq'),
 id numeric(20) NOT NULL,
 asset_id numeric(20) NOT NULL,
 sender_id numeric(20) NOT NULL,
 recipient_id numeric(20) NOT NULL,
 quantity numeric(20) NOT NULL,
 timestamp numeric(11) NOT NULL,
 height numeric(11) NOT NULL,
 PRIMARY KEY (db_id),
 UNIQUE (id)
);
ALTER SEQUENCE asset_transfer_db_id_seq OWNED BY asset_transfer.db_id;
CREATE INDEX ON asset_transfer (asset_id, height);
CREATE INDEX ON asset_transfer (sender_id, height);
CREATE INDEX ON asset_transfer (recipient_id,height);


--
-- Table structure for table at
--

DROP TABLE IF EXISTS at;
CREATE SEQUENCE at_db_id_seq;
CREATE TABLE at (
 db_id numeric(20) NOT NULL DEFAULT nextval('at_db_id_seq'),
 id numeric(20) NOT NULL,
 creator_id numeric(20) NOT NULL,
 name varchar(30) DEFAULT NULL,
 description text ,
 version numeric(6) NOT NULL,
 csize numeric(11) NOT NULL,
 dsize numeric(11) NOT NULL,
 c_user_stack_bytes numeric(11) NOT NULL,
 c_call_stack_bytes numeric(11) NOT NULL,
 creation_height numeric(11) NOT NULL,
 ap_code bytea NOT NULL,
 height numeric(11) NOT NULL,
 latest boolean NOT NULL DEFAULT TRUE,
 PRIMARY KEY (db_id),
 UNIQUE (id, height)
);
ALTER SEQUENCE at_db_id_seq OWNED BY at.db_id;
CREATE INDEX ON at (creator_id, height);


--
-- Table structure for table at_state
--

DROP TABLE IF EXISTS at_state;
CREATE SEQUENCE at_state_db_id_seq;
CREATE TABLE at_state (
 db_id numeric(20) NOT NULL DEFAULT nextval('at_state_db_id_seq'),
 at_id numeric(20) NOT NULL,
 state bytea NOT NULL,
 prev_height numeric(11) NOT NULL,
 next_height numeric(11) NOT NULL,
 sleep_between numeric(11) NOT NULL,
 prev_balance numeric(20) NOT NULL,
 freeze_when_same_balance boolean NOT NULL,
 min_activate_amount numeric(20) NOT NULL,
 height numeric(11) NOT NULL,
 latest boolean NOT NULL DEFAULT TRUE,
 PRIMARY KEY (db_id),
 UNIQUE (at_id, height)
);
ALTER SEQUENCE at_state_db_id_seq OWNED BY at_state.db_id;
CREATE INDEX ON at_state (at_id,next_height, height);

--
-- Table structure for table bid_order
--

DROP TABLE IF EXISTS bid_order;
CREATE SEQUENCE bid_order_db_id_seq;
CREATE TABLE bid_order (
 db_id numeric(20) NOT NULL DEFAULT nextval('bid_order_db_id_seq'),
 id numeric(20) NOT NULL,
 account_id numeric(20) NOT NULL,
 asset_id numeric(20) NOT NULL,
 price numeric(20) NOT NULL,
 quantity numeric(20) NOT NULL,
 creation_height numeric(11) NOT NULL,
 height numeric(11) NOT NULL,
 latest boolean NOT NULL DEFAULT TRUE,
 PRIMARY KEY (db_id),
 UNIQUE (id, height)
);
ALTER SEQUENCE bid_order_db_id_seq OWNED BY bid_order.db_id;
CREATE INDEX ON bid_order (account_id, height);
CREATE INDEX ON bid_order (asset_id, price);
CREATE INDEX ON bid_order (creation_height);

--
-- Table structure for table block
--

DROP TABLE IF EXISTS block CASCADE;
CREATE SEQUENCE block_db_id_seq;
CREATE TABLE block (
 db_id numeric(20) NOT NULL DEFAULT nextval('block_db_id_seq'),
 id numeric(20) NOT NULL,
 version numeric(11) NOT NULL,
 timestamp numeric(11) NOT NULL,
 previous_block_id numeric(20) DEFAULT NULL,
 total_amount numeric(20) NOT NULL,
 total_fee numeric(20) NOT NULL,
 payload_length numeric(11) NOT NULL,
 generator_public_key bytea NOT NULL,
 previous_block_hash bytea DEFAULT NULL,
 cumulative_difficulty bytea NOT NULL,
 base_target numeric(20) NOT NULL,
 next_block_id numeric(20) DEFAULT NULL,
 height numeric(11) NOT NULL,
 generation_signature bytea NOT NULL,
 block_signature bytea NOT NULL,
 payload_hash bytea NOT NULL,
 generator_id numeric(20) NOT NULL,
 nonce numeric(20) NOT NULL,
 ats bytea,
 CHECK(length(generator_public_key) <= 32),
 CHECK(length(previous_block_hash) <= 32),
 CHECK(length(generation_signature) <= 64),
 CHECK(length(block_signature) <= 64),
 CHECK(length(payload_hash) <= 32),
 PRIMARY KEY (db_id),
 UNIQUE (id),
 UNIQUE (height),
 UNIQUE (timestamp),
 CONSTRAINT constraint_3c FOREIGN KEY (previous_block_id) REFERENCES block (id) ON DELETE CASCADE,
 CONSTRAINT constraint_3c5 FOREIGN KEY (next_block_id) REFERENCES block (id) ON DELETE SET NULL
);
ALTER SEQUENCE block_db_id_seq OWNED BY block.db_id;
CREATE INDEX ON block (generator_id);
CREATE INDEX ON block (next_block_id);
CREATE INDEX ON block (previous_block_id);

--
-- Table structure for table escrow
--

DROP TABLE IF EXISTS escrow;
CREATE SEQUENCE escrow_db_id_seq;
CREATE TABLE escrow (
 db_id numeric(20) NOT NULL DEFAULT nextval('escrow_db_id_seq'),
 id numeric(20) NOT NULL,
 sender_id numeric(20) NOT NULL,
 recipient_id numeric(20) NOT NULL,
 amount numeric(20) NOT NULL,
 required_signers numeric(11) DEFAULT NULL,
 deadline numeric(11) NOT NULL,
 deadline_action numeric(11) NOT NULL,
 height numeric(11) NOT NULL,
 latest boolean NOT NULL DEFAULT TRUE,
 PRIMARY KEY (db_id),
 UNIQUE (id, height)
);
ALTER SEQUENCE escrow_db_id_seq OWNED BY escrow.db_id;
CREATE INDEX ON escrow (sender_id,height);
CREATE INDEX ON escrow (recipient_id,height);
CREATE INDEX ON escrow (deadline,height);

--
-- Table structure for table escrow_decision
--

DROP TABLE IF EXISTS escrow_decision;
CREATE SEQUENCE escrow_decision_db_id_seq;
CREATE TABLE escrow_decision (
 db_id numeric(20) NOT NULL DEFAULT nextval('escrow_decision_db_id_seq'),
 escrow_id numeric(20) NOT NULL,
 account_id numeric(20) NOT NULL,
 decision numeric(11) NOT NULL,
 height numeric(11) NOT NULL,
 latest boolean NOT NULL DEFAULT TRUE,
 PRIMARY KEY (db_id),
 UNIQUE (escrow_id, account_id, height)
);
ALTER SEQUENCE escrow_decision_db_id_seq OWNED BY escrow_decision.db_id;
CREATE INDEX ON escrow_decision (escrow_id, height);
CREATE INDEX ON escrow_decision (account_id, height);

--
-- Table structure for table goods
--

DROP TABLE IF EXISTS goods;
CREATE SEQUENCE goods_db_id_seq;
CREATE TABLE goods (
 db_id numeric(20) NOT NULL DEFAULT nextval('goods_db_id_seq'),
 id numeric(20) NOT NULL,
 seller_id numeric(20) NOT NULL,
 name varchar(100) NOT NULL,
 description text ,
 tags varchar(100) DEFAULT NULL,
 timestamp numeric(11) NOT NULL,
 quantity numeric(11) NOT NULL,
 price numeric(20) NOT NULL,
 delisted boolean NOT NULL,
 height numeric(11) NOT NULL,
 latest boolean NOT NULL DEFAULT TRUE,
 PRIMARY KEY (db_id),
 UNIQUE (id, height)
);
ALTER SEQUENCE goods_db_id_seq OWNED BY goods.db_id;
CREATE INDEX ON goods (seller_id, name);
CREATE INDEX ON goods (timestamp,height);

--
-- Table structure for table peer
--

DROP TABLE IF EXISTS peer;
CREATE TABLE peer (
 address varchar(100) NOT NULL,
 PRIMARY KEY (address)
);

--
-- Table structure for table purchase
--

DROP TABLE IF EXISTS purchase;
CREATE SEQUENCE purchase_db_id_seq;
CREATE TABLE purchase (
 db_id numeric(20) NOT NULL DEFAULT nextval('purchase_db_id_seq'),
 id numeric(20) NOT NULL,
 buyer_id numeric(20) NOT NULL,
 goods_id numeric(20) NOT NULL,
 seller_id numeric(20) NOT NULL,
 quantity numeric(11) NOT NULL,
 price numeric(20) NOT NULL,
 deadline numeric(11) NOT NULL,
 note bytea,
 nonce bytea DEFAULT NULL,
 timestamp numeric(11) NOT NULL,
 pending boolean NOT NULL,
 goods bytea,
 goods_nonce bytea DEFAULT NULL,
 refund_note bytea,
 refund_nonce bytea DEFAULT NULL,
 has_feedback_notes boolean NOT NULL DEFAULT FALSE,
 has_public_feedbacks boolean NOT NULL DEFAULT FALSE,
 discount numeric(20) NOT NULL,
 refund numeric(20) NOT NULL,
 height numeric(11) NOT NULL,
 latest boolean NOT NULL DEFAULT TRUE,
 CHECK(length(nonce) <= 32),
 CHECK(length(goods_nonce) <= 32),
 CHECK(length(refund_nonce) <= 32),
 PRIMARY KEY (db_id),
 UNIQUE (id, height)
);
ALTER SEQUENCE purchase_db_id_seq OWNED BY purchase.db_id;
CREATE INDEX ON purchase (buyer_id, height);
CREATE INDEX ON purchase (seller_id, height);
CREATE INDEX ON purchase (deadline, height);
CREATE INDEX ON purchase (timestamp, id);

--
-- Table structure for table purchase_feedback
--

DROP TABLE IF EXISTS purchase_feedback;
CREATE SEQUENCE purchase_feedback_db_id_seq;
CREATE TABLE purchase_feedback (
 db_id numeric(20) NOT NULL DEFAULT nextval('purchase_feedback_db_id_seq'),
 id numeric(20) NOT NULL,
 feedback_data bytea NOT NULL,
 feedback_nonce bytea NOT NULL,
 height numeric(11) NOT NULL,
 latest boolean NOT NULL DEFAULT TRUE,
 CHECK(length(feedback_nonce) <= 32),
 PRIMARY KEY (db_id)
);
ALTER SEQUENCE purchase_feedback_db_id_seq OWNED BY purchase_feedback.db_id;
CREATE INDEX ON purchase_feedback (id, height);


--
-- Table structure for table purchase_public_feedback
--

DROP TABLE IF EXISTS purchase_public_feedback;
CREATE SEQUENCE purchase_public_feedback_db_id_seq;
CREATE TABLE purchase_public_feedback (
 db_id numeric(20) NOT NULL DEFAULT nextval('purchase_public_feedback_db_id_seq'),
 id numeric(20) NOT NULL,
 public_feedback text NOT NULL,
 height numeric(11) NOT NULL,
 latest boolean NOT NULL DEFAULT TRUE,
 PRIMARY KEY (db_id),
 UNIQUE (id, height)
);
ALTER SEQUENCE purchase_public_feedback_db_id_seq OWNED BY purchase_public_feedback.db_id;
CREATE INDEX ON purchase_public_feedback (id,height);


--
-- Table structure for table reward_recip_assign
--

DROP TABLE IF EXISTS reward_recip_assign;
CREATE SEQUENCE reward_recip_assign_db_id_seq;
CREATE TABLE reward_recip_assign (
 db_id numeric(20) NOT NULL DEFAULT nextval('reward_recip_assign_db_id_seq'),
 account_id numeric(20) NOT NULL,
 prev_recip_id numeric(20) NOT NULL,
 recip_id numeric(20) NOT NULL,
 from_height numeric(11) NOT NULL,
 height numeric(11) NOT NULL,
 latest boolean NOT NULL DEFAULT TRUE,
 PRIMARY KEY (db_id),
 UNIQUE (account_id, height)
);
ALTER SEQUENCE reward_recip_assign_db_id_seq OWNED BY reward_recip_assign.db_id;
CREATE INDEX ON reward_recip_assign (recip_id, height);

--
-- Table structure for table subscription
--

DROP TABLE IF EXISTS subscription;
CREATE SEQUENCE subscription_db_id_seq;
CREATE TABLE subscription (
 db_id numeric(20) NOT NULL DEFAULT nextval('subscription_db_id_seq'),
 id numeric(20) NOT NULL,
 sender_id numeric(20) NOT NULL,
 recipient_id numeric(20) NOT NULL,
 amount numeric(20) NOT NULL,
 frequency numeric(11) NOT NULL,
 time_next numeric(11) NOT NULL,
 height numeric(11) NOT NULL,
 latest boolean NOT NULL DEFAULT TRUE,
 PRIMARY KEY (db_id),
 UNIQUE (id, height),
 UNIQUE(id, sender_id, recipient_id, amount, frequency, time_next, height, latest)
);
ALTER SEQUENCE subscription_db_id_seq OWNED BY subscription.db_id;
CREATE INDEX ON subscription (sender_id, height);
CREATE INDEX ON subscription (recipient_id, height);

--
-- Table structure for table trade
--

DROP TABLE IF EXISTS trade;
CREATE SEQUENCE trade_db_id_seq;
CREATE TABLE trade (
 db_id numeric(20) NOT NULL DEFAULT nextval('trade_db_id_seq'),
 asset_id numeric(20) NOT NULL,
 block_id numeric(20) NOT NULL,
 ask_order_id numeric(20) NOT NULL,
 bid_order_id numeric(20) NOT NULL,
 ask_order_height numeric(11) NOT NULL,
 bid_order_height numeric(11) NOT NULL,
 seller_id numeric(20) NOT NULL,
 buyer_id numeric(20) NOT NULL,
 quantity numeric(20) NOT NULL,
 price numeric(20) NOT NULL,
 timestamp numeric(11) NOT NULL,
 height numeric(11) NOT NULL,
 PRIMARY KEY (db_id),
 UNIQUE (ask_order_id, bid_order_id)
);
ALTER SEQUENCE trade_db_id_seq OWNED BY trade.db_id;
CREATE INDEX ON trade (asset_id, height);
CREATE INDEX ON trade (seller_id, height);
CREATE INDEX ON trade (buyer_id, height);

--
-- Table structure for table transaction
--

DROP TABLE IF EXISTS transaction;
CREATE SEQUENCE transaction_db_id_seq;
CREATE TABLE transaction (
 db_id numeric(20) NOT NULL DEFAULT nextval('transaction_db_id_seq'),
 id numeric(20) NOT NULL,
 deadline numeric(6) NOT NULL,
 sender_public_key bytea NOT NULL,
 recipient_id numeric(20) DEFAULT NULL,
 amount numeric(20) NOT NULL,
 fee numeric(20) NOT NULL,
 height numeric(11) NOT NULL,
 block_id numeric(20) NOT NULL,
 signature bytea DEFAULT NULL,
 timestamp numeric(11) NOT NULL,
 type numeric(4) NOT NULL,
 subtype numeric(4) NOT NULL,
 sender_id numeric(20) NOT NULL,
 block_timestamp numeric(11) NOT NULL,
 full_hash bytea NOT NULL,
 referenced_transaction_fullhash bytea DEFAULT NULL,
 attachment_bytes bytea,
 version numeric(4) NOT NULL,
 has_message boolean NOT NULL DEFAULT FALSE,
 has_encrypted_message boolean NOT NULL DEFAULT FALSE,
 has_public_key_announcement boolean NOT NULL DEFAULT FALSE,
 ec_block_height numeric(11) DEFAULT NULL,
 ec_block_id numeric(20) DEFAULT NULL,
 has_encrypttoself_message boolean NOT NULL DEFAULT FALSE,
 CHECK(length(sender_public_key) <= 32),
 CHECK(length(full_hash) <= 32),
 CHECK(length(referenced_transaction_fullhash) <= 32),
 PRIMARY KEY (db_id),
 UNIQUE (id),
 UNIQUE(full_hash),
 CONSTRAINT constraint_ff FOREIGN KEY (block_id) REFERENCES block (id) ON DELETE CASCADE
);
ALTER SEQUENCE transaction_db_id_seq OWNED BY transaction.db_id;
CREATE INDEX ON transaction (block_timestamp);
CREATE INDEX ON transaction (sender_id);
CREATE INDEX ON transaction (recipient_id);
CREATE INDEX ON transaction (recipient_id, amount, height);
CREATE INDEX ON transaction (block_id);


--
-- Table structure for table unconfirmed_transaction
--

DROP TABLE IF EXISTS unconfirmed_transaction;
CREATE SEQUENCE unconfirmed_transaction_db_id_seq;
CREATE TABLE unconfirmed_transaction (
 db_id numeric(20) NOT NULL DEFAULT nextval('unconfirmed_transaction_db_id_seq'),
 id numeric(20) NOT NULL,
 expiration numeric(11) NOT NULL,
 transaction_height numeric(11) NOT NULL,
 fee_per_byte numeric(20) NOT NULL,
 timestamp numeric(11) NOT NULL,
 transaction_bytes bytea NOT NULL,
 height numeric(11) NOT NULL,
 PRIMARY KEY (db_id),
 UNIQUE (id)
);
ALTER SEQUENCE unconfirmed_transaction_db_id_seq OWNED BY unconfirmed_transaction.db_id;
CREATE INDEX ON unconfirmed_transaction (transaction_height, fee_per_byte, timestamp);
