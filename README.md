COMPOUND
compound_id
discontinuation_phase enum
discontinuation_reason  nvarchar
discontinuation_year validate_year
discontinuation_company COMPANY
link NVARCHAR
repurpose_year
repurpose_company
repurpose_phase
- join: 
  compound_name MtM
  company Mt1
  gene MtM
  clinical annotation MtM
  pathway annotation MtM
  disease MtM
  target MtM
  mechanism of action MtM
  indication MtM


COMPOUND NAME
compound_id
name  nvarchar
is_repurposed BOOL

COMPANY
name  nvarchar

GENE TARGET
gene  nvarchar

CLINICAL ANNOTATION
annotation nvarchar

PATHWAY ANNOTATION
annotation  nvarchar

DISEASE
name  nvarchar

TARGET
- join:
  target names 1tM

TARGET NAMES
name  nvarchar

MECHANISM OF ACTION
mechanism nvarchar

INDICATION
indication nvarchar
type enum

REPURPOSED INDICATIONS
indication_id
compound_id

REPURPOSED EFFORTS
effort nvarchar



