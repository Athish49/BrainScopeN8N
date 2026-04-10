CREATE OR REPLACE FUNCTION search_papers(
  query_embedding vector(768),
  match_count INT DEFAULT 20
)
RETURNS TABLE (
  paper_id UUID,
  title TEXT,
  abstract TEXT,
  source TEXT,
  published_date DATE,
  url TEXT,
  relevance_score FLOAT,
  matched_topics TEXT[],
  methodology_type TEXT,
  objective TEXT,
  key_findings TEXT,
  similarity FLOAT
) AS $$
BEGIN
  RETURN QUERY
  SELECT
    p.id AS paper_id,
    p.title,
    p.abstract,
    p.source,
    p.published_date,
    p.url,
    ps.relevance_score,
    ps.matched_topics,
    s.methodology_type,
    s.objective,
    s.key_findings,
    1 - (pe.embedding <=> query_embedding) AS similarity
  FROM paper_embeddings pe
  JOIN papers p ON p.id = pe.paper_id
  LEFT JOIN paper_scores ps ON ps.paper_id = p.id
  LEFT JOIN paper_summaries s ON s.paper_id = p.id
  WHERE ps.is_relevant = true
  ORDER BY pe.embedding <=> query_embedding
  LIMIT match_count;
END;
$$ LANGUAGE plpgsql;