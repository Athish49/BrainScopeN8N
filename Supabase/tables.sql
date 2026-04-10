-- Pipeline configuration (single row)
CREATE TABLE pipeline_config (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  domain TEXT NOT NULL,
  topics JSONB NOT NULL,
  excluded_keywords TEXT[],
  relevance_threshold FLOAT DEFAULT 0.6,
  max_papers_per_digest INT DEFAULT 15,
  digest_email TEXT,
  delivery_time_utc TIME DEFAULT '08:00',
  created_at TIMESTAMPTZ DEFAULT now(),
  updated_at TIMESTAMPTZ DEFAULT now()
);

-- Raw ingested papers
CREATE TABLE papers (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  doi TEXT UNIQUE,
  title TEXT NOT NULL,
  abstract TEXT,
  authors JSONB,
  source TEXT NOT NULL,
  source_id TEXT,
  published_date DATE,
  journal TEXT,
  url TEXT,
  pdf_url TEXT,
  is_preprint BOOLEAN DEFAULT false,
  is_retracted BOOLEAN DEFAULT false,
  retraction_checked_at TIMESTAMPTZ,
  raw_metadata JSONB,
  ingested_at TIMESTAMPTZ DEFAULT now(),
  UNIQUE(source, source_id)
);

-- Relevance scores
CREATE TABLE paper_scores (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  paper_id UUID REFERENCES papers(id) ON DELETE CASCADE,
  relevance_score FLOAT,
  matched_topics TEXT[],
  is_relevant BOOLEAN,
  triage_model TEXT,
  scored_at TIMESTAMPTZ DEFAULT now(),
  UNIQUE(paper_id)
);

-- Structured summaries
CREATE TABLE paper_summaries (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  paper_id UUID REFERENCES papers(id) ON DELETE CASCADE UNIQUE,
  objective TEXT,
  methodology TEXT,
  methodology_type TEXT,
  key_findings TEXT,
  limitations TEXT,
  datasets_mentioned TEXT[],
  statistical_claims JSONB,
  key_figures JSONB,
  funding_sources TEXT[],
  conflict_of_interest TEXT,
  generated_by TEXT,
  generated_at TIMESTAMPTZ DEFAULT now()
);

-- Vector embeddings (NEW in v2 — replaces Weaviate entirely)
CREATE TABLE paper_embeddings (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  paper_id UUID REFERENCES papers(id) ON DELETE CASCADE UNIQUE,
  embedding vector(768),
  content_text TEXT,
  created_at TIMESTAMPTZ DEFAULT now()
);

-- Digest delivery log
CREATE TABLE digest_log (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  digest_type TEXT,
  paper_count INT,
  paper_ids UUID[],
  delivered_at TIMESTAMPTZ DEFAULT now(),
  delivery_status TEXT
);

-- Trend tracking
CREATE TABLE topic_trends (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  topic TEXT NOT NULL,
  paper_count INT,
  period_start DATE,
  period_end DATE,
  top_keywords JSONB,
  recorded_at TIMESTAMPTZ DEFAULT now()
);

-- Pipeline run log
CREATE TABLE pipeline_runs (
  id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  workflow_name TEXT NOT NULL,
  started_at TIMESTAMPTZ DEFAULT now(),
  finished_at TIMESTAMPTZ,
  papers_ingested INT DEFAULT 0,
  papers_relevant INT DEFAULT 0,
  papers_processed INT DEFAULT 0,
  status TEXT DEFAULT 'running'
);