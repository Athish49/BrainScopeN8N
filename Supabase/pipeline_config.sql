INSERT INTO pipeline_config (
  domain,
  topics,
  excluded_keywords,
  relevance_threshold,
  max_papers_per_digest,
  digest_email,
  delivery_time_utc
) VALUES (
  'Biomedical AI & Drug Discovery',
  '[
    {
      "name": "Neural signal decoding",
      "keywords": [
        "brain computer interface",
        "BCI",
        "neural decoding",
        "neural signal decoding",
        "EEG decoding",
        "intracortical recording",
        "neural data analysis",
        "motor intention decoding",
        "imagined speech decoding"
      ]
    },
    {
      "name": "Non-invasive BCI",
      "keywords": [
        "EEG BCI",
        "fNIRS BCI",
        "non-invasive brain computer interface",
        "brain signal classification",
        "EEG signal processing",
        "SSVEP",
        "P300 BCI",
        "motor imagery EEG"
      ]
    },
    {
      "name": "Invasive BCI & implants",
      "keywords": [
        "intracortical BCI",
        "neural implants",
        "brain implant",
        "Utah array",
        "Neuralink",
        "electrocorticography",
        "ECoG",
        "neural electrode arrays"
      ]
    },
    {
      "name": "Neuroprosthetics & applications",
      "keywords": [
        "neuroprosthetics",
        "prosthetic control BCI",
        "brain controlled prosthesis",
        "robotic arm BCI",
        "assistive communication BCI",
        "paralysis rehabilitation BCI"
      ]
    },
    {
      "name": "AI for neural data",
      "keywords": [
        "deep learning for EEG",
        "transformer neural signals",
        "time series neural data",
        "self-supervised learning EEG",
        "brain signal classification deep learning",
        "neural foundation models"
      ]
    },
    {
      "name": "Brain stimulation & closed-loop systems",
      "keywords": [
        "closed-loop BCI",
        "brain stimulation",
        "deep brain stimulation",
        "DBS",
        "TMS",
        "adaptive neurostimulation",
        "neuromodulation"
      ]
    }
  ]'::jsonb,
  ARRAY['editorial', 'commentary', 'erratum', 'corrigendum'],
  0.6,
  15,
  'agr@iu.edu',
  '08:00'
);