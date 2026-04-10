-- Enable RLS on all tables
ALTER TABLE papers ENABLE ROW LEVEL SECURITY;
ALTER TABLE paper_scores ENABLE ROW LEVEL SECURITY;
ALTER TABLE paper_summaries ENABLE ROW LEVEL SECURITY;
ALTER TABLE paper_embeddings ENABLE ROW LEVEL SECURITY;
ALTER TABLE pipeline_runs ENABLE ROW LEVEL SECURITY;
ALTER TABLE topic_trends ENABLE ROW LEVEL SECURITY;
ALTER TABLE digest_log ENABLE ROW LEVEL SECURITY;
ALTER TABLE pipeline_config ENABLE ROW LEVEL SECURITY;

-- Allow public read (for the Next.js dashboard using anon key)
CREATE POLICY "public_read_papers" ON papers FOR SELECT USING (true);
CREATE POLICY "public_read_scores" ON paper_scores FOR SELECT USING (true);
CREATE POLICY "public_read_summaries" ON paper_summaries FOR SELECT USING (true);
CREATE POLICY "public_read_embeddings" ON paper_embeddings FOR SELECT USING (true);
CREATE POLICY "public_read_runs" ON pipeline_runs FOR SELECT USING (true);
CREATE POLICY "public_read_trends" ON topic_trends FOR SELECT USING (true);
CREATE POLICY "public_read_config" ON pipeline_config FOR SELECT USING (true);

-- n8n uses the service_role key which bypasses RLS for all writes