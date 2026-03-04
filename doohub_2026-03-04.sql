--
-- PostgreSQL database dump
--

\restrict jr1thgVIapBmgOSKfcaziedNYoFaSsDDc0TBwwgOk2DcqjSgZud7LXHtjwub98i

-- Dumped from database version 16.12
-- Dumped by pg_dump version 16.11

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE IF EXISTS ONLY public.sessions DROP CONSTRAINT IF EXISTS sessions_user_id_fkey;
ALTER TABLE IF EXISTS ONLY public.session_messages DROP CONSTRAINT IF EXISTS session_messages_session_id_fkey;
ALTER TABLE IF EXISTS ONLY public.pipelines DROP CONSTRAINT IF EXISTS pipelines_user_id_fkey;
DROP INDEX IF EXISTS public.ix_users_username;
DROP INDEX IF EXISTS public.ix_sessions_session_key;
DROP INDEX IF EXISTS public.ix_pipelines_pipeline_key;
ALTER TABLE IF EXISTS ONLY public.users DROP CONSTRAINT IF EXISTS users_pkey;
ALTER TABLE IF EXISTS ONLY public.sessions DROP CONSTRAINT IF EXISTS sessions_pkey;
ALTER TABLE IF EXISTS ONLY public.session_messages DROP CONSTRAINT IF EXISTS session_messages_pkey;
ALTER TABLE IF EXISTS ONLY public.pipelines DROP CONSTRAINT IF EXISTS pipelines_pkey;
ALTER TABLE IF EXISTS ONLY public.alembic_version DROP CONSTRAINT IF EXISTS alembic_version_pkc;
ALTER TABLE IF EXISTS public.users ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.sessions ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.session_messages ALTER COLUMN id DROP DEFAULT;
ALTER TABLE IF EXISTS public.pipelines ALTER COLUMN id DROP DEFAULT;
DROP SEQUENCE IF EXISTS public.users_id_seq;
DROP TABLE IF EXISTS public.users;
DROP SEQUENCE IF EXISTS public.sessions_id_seq;
DROP TABLE IF EXISTS public.sessions;
DROP SEQUENCE IF EXISTS public.session_messages_id_seq;
DROP TABLE IF EXISTS public.session_messages;
DROP SEQUENCE IF EXISTS public.pipelines_id_seq;
DROP TABLE IF EXISTS public.pipelines;
DROP TABLE IF EXISTS public.alembic_version;
SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: alembic_version; Type: TABLE; Schema: public; Owner: doohub
--

CREATE TABLE public.alembic_version (
    version_num character varying(32) NOT NULL
);


ALTER TABLE public.alembic_version OWNER TO doohub;

--
-- Name: pipelines; Type: TABLE; Schema: public; Owner: doohub
--

CREATE TABLE public.pipelines (
    id integer NOT NULL,
    user_id integer NOT NULL,
    pipeline_key character varying(100) NOT NULL,
    repo_path character varying(500) NOT NULL,
    issue_number integer,
    issue_title character varying(500),
    task_description text,
    status character varying(30) DEFAULT 'planning'::character varying NOT NULL,
    plan text,
    branch character varying(200),
    pr_number integer,
    pr_url character varying(500),
    error text,
    review_round integer DEFAULT 0 NOT NULL,
    model character varying(50) DEFAULT 'claude-sonnet-4-6'::character varying NOT NULL,
    total_cost_usd double precision DEFAULT '0'::double precision NOT NULL,
    claude_session_id character varying(200),
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    updated_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.pipelines OWNER TO doohub;

--
-- Name: pipelines_id_seq; Type: SEQUENCE; Schema: public; Owner: doohub
--

CREATE SEQUENCE public.pipelines_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.pipelines_id_seq OWNER TO doohub;

--
-- Name: pipelines_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doohub
--

ALTER SEQUENCE public.pipelines_id_seq OWNED BY public.pipelines.id;


--
-- Name: session_messages; Type: TABLE; Schema: public; Owner: doohub
--

CREATE TABLE public.session_messages (
    id integer NOT NULL,
    session_id integer NOT NULL,
    role character varying(20) NOT NULL,
    content text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.session_messages OWNER TO doohub;

--
-- Name: session_messages_id_seq; Type: SEQUENCE; Schema: public; Owner: doohub
--

CREATE SEQUENCE public.session_messages_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.session_messages_id_seq OWNER TO doohub;

--
-- Name: session_messages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doohub
--

ALTER SEQUENCE public.session_messages_id_seq OWNED BY public.session_messages.id;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: doohub
--

CREATE TABLE public.sessions (
    id integer NOT NULL,
    user_id integer NOT NULL,
    session_key character varying(100) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    project_path character varying(500) DEFAULT ''::character varying NOT NULL,
    model character varying(50) DEFAULT 'claude-opus-4-6'::character varying NOT NULL,
    interactive boolean DEFAULT false NOT NULL,
    claude_session_id character varying(200),
    name character varying(200) DEFAULT 'untitled'::character varying NOT NULL
);


ALTER TABLE public.sessions OWNER TO doohub;

--
-- Name: sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: doohub
--

CREATE SEQUENCE public.sessions_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sessions_id_seq OWNER TO doohub;

--
-- Name: sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doohub
--

ALTER SEQUENCE public.sessions_id_seq OWNED BY public.sessions.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: doohub
--

CREATE TABLE public.users (
    id integer NOT NULL,
    username character varying(50) NOT NULL,
    password_hash character varying(255) NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE public.users OWNER TO doohub;

--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: doohub
--

CREATE SEQUENCE public.users_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO doohub;

--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: doohub
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: pipelines id; Type: DEFAULT; Schema: public; Owner: doohub
--

ALTER TABLE ONLY public.pipelines ALTER COLUMN id SET DEFAULT nextval('public.pipelines_id_seq'::regclass);


--
-- Name: session_messages id; Type: DEFAULT; Schema: public; Owner: doohub
--

ALTER TABLE ONLY public.session_messages ALTER COLUMN id SET DEFAULT nextval('public.session_messages_id_seq'::regclass);


--
-- Name: sessions id; Type: DEFAULT; Schema: public; Owner: doohub
--

ALTER TABLE ONLY public.sessions ALTER COLUMN id SET DEFAULT nextval('public.sessions_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: doohub
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: alembic_version; Type: TABLE DATA; Schema: public; Owner: doohub
--

COPY public.alembic_version (version_num) FROM stdin;
005
\.


--
-- Data for Name: pipelines; Type: TABLE DATA; Schema: public; Owner: doohub
--

COPY public.pipelines (id, user_id, pipeline_key, repo_path, issue_number, issue_title, task_description, status, plan, branch, pr_number, pr_url, error, review_round, model, total_cost_usd, claude_session_id, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: session_messages; Type: TABLE DATA; Schema: public; Owner: doohub
--

COPY public.session_messages (id, session_id, role, content, created_at) FROM stdin;
231	25	user	list open issues	2026-03-03 21:12:21.252344+00
232	25	assistant	There are 2 open issues:\n\n| # | Title |\n|---|-------|\n| 17 | ZEN-173: Setup — Configure backup token on host |\n| 15 | ZEN-173: Migrate from SQLite to PostgreSQL with nightly GitHub backups |	2026-03-03 21:12:21.260295+00
233	25	user	are you sure? talavo project should habe alot more	2026-03-03 21:13:11.709477+00
234	25	assistant	Here are all 50 open issues on **bakicelebi/talavo**:\n\n| # | Title | Labels |\n|---|-------|--------|\n| 448 | ZEN-229: Refactor app ad blocking to consume server-hosted ContentBlocker JSON | |\n| 447 | ZEN-228: Build server-side adblock-rust filter compiler | |\n| 444 | ZEN-227: Fix adblock toggle not taking effect | |\n| 439 | ZEN-225: Fix iOS Now Playing next/prev buttons and auto-advance when backgrounded | |\n| 436 | ZEN-212: Validate app icon and launch image assets | |\n| 432 | ZEN-222: Fix "Me at the Zoo" placeholder video flashing | |\n| 428 | ZEN-220: Add in-app update check | |\n| 427 | ZEN-219: Add Sign in with Apple / Google | |\n| 426 | ZEN-218: Add offline support | |\n| 425 | ZEN-217: Improve accessibility support | |\n| 424 | ZEN-216: Add biometric authentication | |\n| 423 | ZEN-215: Add push notifications | |\n| 422 | ZEN-214: Add analytics and crash reporting | |\n| 421 | ZEN-213: Add onboarding / first-run tutorial | |\n| 420 | ZEN-212: Add localization | koksal |\n| 418 | ZEN-211: Add visual feedback to edge swipe navigation | |\n| 400 | ZEN-208: Disable vertical scroll on saved shortcuts page | koksal |\n| 399 | ZEN-207: YouTube Shorts UI loads slowly | koksal |\n| 398 | ZEN-206: Top filler doesn't match website background color | koksal |\n| 397 | ZEN-205: Add left-edge swipe for forward navigation | koksal |\n| 392 | ZEN-200: YouTube video tab should only navigate to videos | |\n| 390 | ZEN-198: Use consistent iOS border radius | |\n| 389 | ZEN-197: Investigate Cupertino widget usage | koksal |\n| 388 | ZEN-196: Remove Live Activity demo screen | |\n| 387 | ZEN-195: Handle edge cases — stale activities, error recovery | |\n| 386 | ZEN-194: Add Live Activity toggle in Settings | |\n| 385 | ZEN-193: Wire Live Activity to browser video playback | |\n| 384 | ZEN-192: Add real-time play state detection via JS events | |\n| 383 | ZEN-191: Extract upcoming tracks from YouTube autoplay queue | |\n| 382 | ZEN-190: Extract YouTube video metadata via JS injection | |\n| 375 | ZEN-188: Add onboarding GIFs for Zen Mode and Action Drawer | |\n| 367 | ZEN-184: Improve playlist navigation robustness | |\n| 366 | ZEN-183: Add video playback error detection and reporting | |\n| 365 | ZEN-182: Extract and display video info in mini player | |\n| 364 | ZEN-181: Add loop controls for video and playlist | |\n| 363 | ZEN-180: Show buffer progress in mini player | |\n| 345 | ZEN-172: Fix YouTube search hanging with Zen Mode | |\n| 332 | ZEN-169: Recover audio session after interruption | |\n| 331 | ZEN-168: Add diagnostic logging to background play | |\n| 330 | ZEN-167: Reset media session progress bar on track change | |\n| 303 | ZEN-159: Eliminate audible pause/resume gap in background | enhancement |\n| 285 | ZEN-158: Add missing feature settings | enhancement |\n| 272 | ZEN-147: Improve tab drag-to-reorder UX | enhancement |\n| 256 | ZEN-143: In-app bug report | enhancement, medium |\n| 255 | ZEN-142: Random review and share popups | enhancement, medium |\n| 253 | ZEN-140: Referral system | enhancement, medium |\n| 252 | ZEN-139: Subscription system (1€/month) | enhancement, high |\n| 251 | ZEN-138: Safari content blocker list import | enhancement, low |\n| 250 | ZEN-137: Native iOS context menus | enhancement, medium |\n| 248 | ZEN-135: iCloud sync for tabs, shortcuts, settings | enhancement, low |\n\n50 open issues total. The main repo is **bakicelebi/talavo**, not Lenkomotive/talavo-backend.	2026-03-03 21:13:11.715927+00
235	25	user	Analyze the app and create a marketing strategy. How can this app reach a wide audiance.	2026-03-03 21:16:27.083878+00
236	25	assistant	## Talavo / ZenView — App Analysis & Marketing Strategy\n\n### What the App Is\n\n**ZenView** is an **iOS browser** (Flutter) with a heavy YouTube focus, backed by a Python/FastAPI audio extraction service. The core value proposition:\n\n| Feature | Status |\n|---------|--------|\n| Built-in ad blocking (YouTube + web) | Shipped |\n| YouTube background playback | Shipped |\n| Mini player with controls | Shipped |\n| Zen Mode (distraction-free YouTube) | Shipped |\n| Audio download/MP3 conversion | Shipped |\n| Tab management + shortcuts | Shipped |\n| Live Activities (Now Playing) | In progress |\n| Playlist management | Planned |\n| Subscription (1€/month) | Planned |\n| Referral system | Planned |\n\n---\n\n### Target Audience\n\n1. **Primary**: YouTube power users (18-35) tired of ads and wanting background play without YouTube Premium (~€12/month)\n2. **Secondary**: Privacy-conscious iOS users wanting a lightweight browser with ad blocking\n3. **Tertiary**: Music listeners who use YouTube as their primary music source\n\n---\n\n### Marketing Strategy\n\n#### 1. Positioning — "YouTube Premium features for 1€/month"\n\nThe #1 selling point is simple math: YouTube Premium costs ~€12/month. ZenView delivers the two most wanted Premium features (ad-free + background play) for 1€/month. Lead with this everywhere.\n\n**Tagline options:**\n- "Ad-free YouTube. Background play. 1€/month."\n- "The YouTube experience Apple won't give you."\n- "Browse clean. Listen free."\n\n#### 2. Organic Growth Channels (Free / Low Cost)\n\n**TikTok & Instagram Reels (highest ROI)**\n- Short "did you know?" clips: "This app gives you YouTube Premium features for 1€" — these go viral regularly\n- Screen recordings showing: ad blocked → background play → lock screen controls\n- "iPhone hack" format — these get millions of views\n- Post 3-5x/week, reuse across TikTok, Reels, and YouTube Shorts\n\n**Reddit**\n- Communities: r/iPhone, r/ios, r/YouTube, r/privacy, r/adblock, r/sideloaded\n- Don't spam — provide genuine value, mention the app when relevant\n- "I built an iOS browser that blocks YouTube ads and plays in background" posts do well on r/SideProject and r/Apple\n\n**Twitter/X**\n- iOS tips & tricks accounts regularly share app recommendations\n- Engage with threads about YouTube Premium pricing complaints\n- Build a presence around the "YouTube without Premium" niche\n\n**YouTube itself**\n- Partner with small-to-mid tech YouTubers (10K-100K subs) for honest reviews\n- These creators are cheap or even free if the app is genuinely good\n- Target channels: iOS tips, productivity, "apps you need" listicle creators\n\n#### 3. Referral System (Already Planned — Prioritize This)\n\nThis is your **single most important growth lever**. Suggestion:\n\n- Refer a friend → both get 1 extra free week\n- Cap at e.g. 3 months free total to prevent abuse\n- Make sharing dead simple: one-tap share with a personalized link\n- Show a referral leaderboard or count in the app\n\n#### 4. App Store Optimization (ASO)\n\n**Keywords to target:**\n- "ad blocker browser" / "ad free YouTube"\n- "YouTube background play" / "background video player"\n- "YouTube no ads iPhone"\n- "music from YouTube" / "YouTube to MP3"\n\n**Screenshots & preview video:**\n- Screen 1: YouTube playing with "0 ads" badge\n- Screen 2: Lock screen with Now Playing controls (background play)\n- Screen 3: Zen Mode comparison (before/after)\n- Screen 4: Mini player while browsing\n- Screen 5: Price comparison vs YouTube Premium\n\n**Localization** (issue ZEN-212 is already open) — Turkish, German, Spanish, Portuguese, Arabic, and Hindi would cover massive markets where YouTube Premium is either expensive relative to income or unavailable.\n\n#### 5. Strategic Timing\n\n- **Launch referral + subscription together** — free trial → referral loop → conversion\n- **Push hard around YouTube Premium price increases** — these generate massive social media complaints; be ready with content when it happens\n- **Back-to-school / New Year** — periods when people audit subscriptions\n\n#### 6. Community & Retention\n\n- **TestFlight beta community** — let early users feel ownership, collect feedback\n- **Telegram or Discord group** — direct line to users, builds loyalty\n- **Ship fast, communicate changes** — a simple in-app changelog builds trust\n\n#### 7. Content Marketing (Low effort, high long-tail)\n\n- Simple landing page with feature comparison table (ZenView vs YouTube Premium vs Safari)\n- Blog post: "How to listen to YouTube in the background on iPhone" — captures search traffic\n- ProductHunt launch — one-time but can drive thousands of installs\n\n---\n\n### Priority Actions (What to Do First)\n\n1. **Ship referral system** (ZEN-140) — this is your growth engine\n2. **Ship subscription** (ZEN-139) — monetize before scaling\n3. **Create 5 TikTok/Reels** showing the core value (ad-free + background play)\n4. **Optimize App Store listing** — keywords, screenshots, preview video\n5. **Add localization** (ZEN-212) — Turkish market alone is a quick win given your team\n6. **ProductHunt launch** — do this once the referral system is live\n7. **Reddit launch posts** on r/SideProject, r/Apple, r/ios\n\n---\n\n### Risks to Watch\n\n- **Apple App Store rejection** — ad blocking and YouTube background play push Apple's guidelines. Keep the app positioned as a "browser with content blocker" not "YouTube ad blocker". Safari Content Blocker API is the sanctioned approach (you're already on this with ZEN-229).\n- **YouTube ToS** — audio download features should stay low-profile in marketing. Position the app around the browser/playback experience, not downloading.\n- **yt-dlp breakage** — YouTube regularly breaks extractors. Your backend's health depends on yt-dlp updates. Monitor closely.\n\nThe biggest opportunity is the TikTok/Reels viral loop combined with the referral system. One good "iPhone hack" video can drive 100K+ installs overnight, and if referrals are live, those users bring more users organically.	2026-03-03 21:16:27.093064+00
242	25	user	what is product hunt launch	2026-03-03 21:25:39.286891+00
243	25	assistant	\n\n**ProductHunt** is a website ([producthunt.com](https://www.producthunt.com)) where makers launch new apps/products and the community upvotes and reviews them. It's one of the most popular platforms for indie app launches.\n\n### How it works:\n- You submit your app with a tagline, description, screenshots, and a "maker" comment\n- The community votes and comments throughout the day\n- Top products get featured on the homepage, driving thousands of visitors\n- A strong launch day can bring **5K-50K website visits** and **1K-10K installs**\n\n### Why it matters for ZenView:\n- The audience is **early adopters and tech enthusiasts** — exactly the type who'd try an alternative browser\n- A "Product of the Day" badge builds credibility and is great for your App Store listing\n- It generates **backlinks** that help SEO for your landing page\n- It's **completely free**\n\n### Tips for a good launch:\n- Launch on a **Tuesday or Wednesday** (less competition than Monday)\n- Prepare a short **demo video** (30-60 sec)\n- Have your team + friends ready to upvote and comment early (but don't use bots — they detect that)\n- Write a genuine "maker story" — why you built it, the problem it solves\n- Engage with every comment on launch day\n- Hunter (the person who submits) matters — if you can get someone with a following to "hunt" your product, it helps visibility\n\nIt's a one-shot thing — you only launch once — so do it after referrals and subscriptions are live so you can actually convert the traffic.	2026-03-03 21:25:39.292304+00
253	28	user	the session name should update witz what currently is busy with. bot shor 1-4 words maybe so it does not overflow	2026-03-03 21:33:26.082926+00
262	28	user	yo	2026-03-03 21:36:42.800778+00
263	28	assistant	yo! what's up?	2026-03-03 21:36:42.810294+00
264	28	user	the session name should update witz what currently is busy with. bot shor 1-4 words maybe so it does not overflow	2026-03-03 21:37:03.431924+00
265	29	user	hez	2026-03-04 10:39:09.298478+00
266	29	assistant	Hey! What's up? How can I help you today?	2026-03-04 10:39:09.314984+00
267	29	user	ow are zou today	2026-03-04 10:39:49.457507+00
268	29	assistant	Doing good, thanks! What can I help you with?	2026-03-04 10:39:49.46337+00
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: doohub
--

COPY public.sessions (id, user_id, session_key, created_at, project_path, model, interactive, claude_session_id, name) FROM stdin;
25	2	808c1204e18a	2026-03-03 21:12:15.093798+00	/projects/talavo	opus	f	8b7e8218-fbd2-4405-a806-3fd5e281aa08	A
28	1	e6776ee10aa7	2026-03-03 21:32:52.930998+00	/projects/Doohub	opus	f	9fcf5f57-17c4-4797-91a3-6e0b024c82d0	A
29	1	58ca863c0283	2026-03-04 10:39:07.317605+00	/projects/dooslave	opus	f	e71ad962-ff2a-4167-a0f5-8e67afaf43e8	B
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: doohub
--

COPY public.users (id, username, password_hash, created_at) FROM stdin;
1	admin	$2b$12$MjU7NezvemrI51UzSJQsmu8p6nsnjCKymrEyUko/iYogggElFttm2	2026-03-02 14:31:35.527617+00
2	baki	$2b$12$/c25sRc/mZ.WV.O2QWQeiu4scybCe.WMzZPA4d.QmdhCv1MjtwZxm	2026-03-02 18:41:08.733899+00
\.


--
-- Name: pipelines_id_seq; Type: SEQUENCE SET; Schema: public; Owner: doohub
--

SELECT pg_catalog.setval('public.pipelines_id_seq', 8, true);


--
-- Name: session_messages_id_seq; Type: SEQUENCE SET; Schema: public; Owner: doohub
--

SELECT pg_catalog.setval('public.session_messages_id_seq', 268, true);


--
-- Name: sessions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: doohub
--

SELECT pg_catalog.setval('public.sessions_id_seq', 29, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: doohub
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- Name: alembic_version alembic_version_pkc; Type: CONSTRAINT; Schema: public; Owner: doohub
--

ALTER TABLE ONLY public.alembic_version
    ADD CONSTRAINT alembic_version_pkc PRIMARY KEY (version_num);


--
-- Name: pipelines pipelines_pkey; Type: CONSTRAINT; Schema: public; Owner: doohub
--

ALTER TABLE ONLY public.pipelines
    ADD CONSTRAINT pipelines_pkey PRIMARY KEY (id);


--
-- Name: session_messages session_messages_pkey; Type: CONSTRAINT; Schema: public; Owner: doohub
--

ALTER TABLE ONLY public.session_messages
    ADD CONSTRAINT session_messages_pkey PRIMARY KEY (id);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: doohub
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: doohub
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: ix_pipelines_pipeline_key; Type: INDEX; Schema: public; Owner: doohub
--

CREATE UNIQUE INDEX ix_pipelines_pipeline_key ON public.pipelines USING btree (pipeline_key);


--
-- Name: ix_sessions_session_key; Type: INDEX; Schema: public; Owner: doohub
--

CREATE INDEX ix_sessions_session_key ON public.sessions USING btree (session_key);


--
-- Name: ix_users_username; Type: INDEX; Schema: public; Owner: doohub
--

CREATE UNIQUE INDEX ix_users_username ON public.users USING btree (username);


--
-- Name: pipelines pipelines_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: doohub
--

ALTER TABLE ONLY public.pipelines
    ADD CONSTRAINT pipelines_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- Name: session_messages session_messages_session_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: doohub
--

ALTER TABLE ONLY public.session_messages
    ADD CONSTRAINT session_messages_session_id_fkey FOREIGN KEY (session_id) REFERENCES public.sessions(id);


--
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: doohub
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES public.users(id);


--
-- PostgreSQL database dump complete
--

\unrestrict jr1thgVIapBmgOSKfcaziedNYoFaSsDDc0TBwwgOk2DcqjSgZud7LXHtjwub98i

