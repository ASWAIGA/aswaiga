{"filter":false,"title":"20230413215750_create_issues.rb","tooltip":"/db/migrate/20230413215750_create_issues.rb","undoManager":{"mark":0,"position":0,"stack":[[{"start":{"row":0,"column":0},"end":{"row":15,"column":3},"action":"insert","lines":["class CreateIssues < ActiveRecord::Migration[7.0]","  def change","    create_table :issues do |t|","      t.string :tipus","      t.string :severity","      t.string :priority","      t.string :issue","      t.string :status","      t.string :assign_to","      t.date :due_date","      t.string :reason_due_date","","      t.timestamps","    end","  end","end"],"id":1}]]},"ace":{"folds":[],"scrolltop":0,"scrollleft":0,"selection":{"start":{"row":15,"column":3},"end":{"row":15,"column":3},"isBackwards":false},"options":{"guessTabSize":true,"useWrapMode":false,"wrapToView":true},"firstLineState":0},"timestamp":1681466356023,"hash":"3174729b8507b0c8761c5bcedb46ca6eb305adcb"}