CREATE VIEW papers_today AS
  SELECT p.*, ps.relevance_score, ps.matched_topics, ps.is_relevant,
         s.objective, s.methodology_type, s.key_findings, s.limitations
  FROM papers p
  JOIN paper_scores ps ON ps.paper_id = p.id
  LEFT JOIN paper_summaries s ON s.paper_id = p.id
  WHERE ps.is_relevant = true
    AND p.ingested_at >= CURRENT_DATE
  ORDER BY ps.relevance_score DESC;

CREATE VIEW papers_archive AS
  SELECT p.*, ps.relevance_score, ps.matched_topics,
         s.objective, s.methodology_type, s.key_findings
  FROM papers p
  JOIN paper_scores ps ON ps.paper_id = p.id
  LEFT JOIN paper_summaries s ON s.paper_id = p.id
  WHERE ps.is_relevant = true
  ORDER BY p.published_date DESC;

CREATE VIEW pipeline_stats AS
  SELECT
    (SELECT COUNT(*) FROM papers) AS total_papers,
    (SELECT COUNT(*) FROM papers WHERE ingested_at >= CURRENT_DATE) AS today_ingested,
    (SELECT COUNT(*) FROM paper_scores WHERE is_relevant = true) AS total_relevant,
    (SELECT COUNT(*) FROM paper_summaries) AS total_processed,
    (SELECT COUNT(DISTINCT source) FROM papers) AS source_count,
    (SELECT json_agg(json_build_object('source', source, 'count', cnt))
     FROM (SELECT source, COUNT(*) as cnt FROM papers GROUP BY source) t
    ) AS papers_by_source;