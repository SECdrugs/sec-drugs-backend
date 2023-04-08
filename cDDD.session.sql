select *
from compound c
where id = '9534bef3-5492-48e8-a540-571332616201'
  inner join compound_mechanism_of_action j1 on j1.compound_id == c.id
  inner join mechanism_of_action t1 on t1.id = j1.mechanism_of_action_id
  inner join compound_disease j2 on j2.compound_id == c.id
  inner join disease t2 on t2.id = j2.disease_id
  inner join compound_mechanism_of_action j1 on j1.compound_id == c.id
  inner join mechanism_of_action t1 on t1.mechanism_of_action_id = j1.mechanism_of_action_id
  inner join compound_mechanism_of_action j1 on j1.compound_id == c.id
  inner join mechanism_of_action t1 on t1.mechanism_of_action_id = j1.mechanism_of_action_id
  inner join compound_mechanism_of_action j1 on j1.compound_id == c.id
  inner join mechanism_of_action t1 on t1.mechanism_of_action_id = j1.mechanism_of_action_id
  inner join compound_mechanism_of_action j1 on j1.compound_id == c.id
  inner join mechanism_of_action t1 on t1.mechanism_of_action_id = j1.mechanism_of_action_id