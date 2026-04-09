CREATE INDEX idx_papers_doi ON papers(doi);
CREATE INDEX idx_papers_published ON papers(published_date DESC);
CREATE INDEX idx_papers_source ON papers(source, source_id);
CREATE INDEX idx_papers_ingested ON papers(ingested_at DESC);
CREATE INDEX idx_scores_relevant ON paper_scores(is_relevant, scored_at DESC);
CREATE INDEX idx_scores_paper ON paper_scores(paper_id);
CREATE INDEX idx_summaries_paper ON paper_summaries(paper_id);
CREATE INDEX idx_trends_topic ON topic_trends(topic, period_end DESC);
CREATE INDEX idx_pipeline_runs ON pipeline_runs(workflow_name, started_at DESC);