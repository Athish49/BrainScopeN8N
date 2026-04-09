-- Enable RLS on all tables
ALTER TABLE papers ENABLE ROW LEVEL SECURITY;
ALTER TABLE paper_scores ENABLE ROW LEVEL SECURITY;
ALTER TABLE paper_summaries ENABLE ROW LEVEL SECURITY;
ALTER TABLE pipeline_runs ENABLE ROW LEVEL SECURITY;
ALTER TABLE topic_trends ENABLE ROW LEVEL SECURITY;
ALTER TABLE digest_log ENABLE ROW LEVEL SECURITY;
ALTER TABLE pipeline_config ENABLE ROW LEVEL SECURITY;

-- Allow public read access to the views used by the dashboard
CREATE POLICY "public_read_papers" ON papers FOR SELECT USING (true);
CREATE POLICY "public_read_scores" ON paper_scores FOR SELECT USING (true);
CREATE POLICY "public_read_summaries" ON paper_summaries FOR SELECT USING (true);
CREATE POLICY "public_read_runs" ON pipeline_runs FOR SELECT USING (true);
CREATE POLICY "public_read_trends" ON topic_trends FOR SELECT USING (true);
CREATE POLICY "public_read_config" ON pipeline_config FOR SELECT USING (true);

-- digest_log and write operations are internal only (service_role bypasses RLS)